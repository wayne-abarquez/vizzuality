package com.vizzuality.gmba.process.tiles;

import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Pattern;

/**
 * Renders the enviroment data
 * 
 * Elevaton becomes Red
 * Relief Green
 * tvcCode blue
 * 
 * @author tim
 */
public class RasterRender {
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	
	protected static int maxElevation = 7889;
	protected static int maxRelief = 3397;
	
	public static void main(String[] args) throws IOException {
		long timeTotal = System.currentTimeMillis();
		
		if (args.length != 7) {
			System.out.println("Usage: RasterRender sourceDirectory sourcePrefix sourceSuffix outputDirectory numZooms maxElevation maxRelief");
			return;
		}
		
		String inputDir = args[0]; // e.g. /tmp
		String inputPrefix = args[1]; // e.g. env
		String inputSuffix = args[2]; // e.g. _sorted.txt
		File output = new File(args[3]); // e.g. /tmp/env
		int zooms = Integer.parseInt(args[4]);
		maxElevation = Integer.parseInt(args[5]);
		maxRelief = Integer.parseInt(args[6]);
		
		for (int i=0; i<=zooms; i++) {
			run(new File(inputDir + "/" + inputPrefix + "_z" + i + inputSuffix),output, i);
		}
		
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		System.exit(0);
	}

	public static void run(File input, File output, int z) throws IOException {
		System.out.println("Running: " + input.getCanonicalPath());
		BufferedReader reader = new BufferedReader(new FileReader(input));
		String line = reader.readLine();
		
		// prev row values
		int _tileX=-1;
		int _tileY=-1;
		
		int[][] pixels = new int[3][tileSize*tileSize];
		// 2 because only the first 2 are interpolated by averaging
		int[][] pixelsContributers = new int[2][tileSize*tileSize];
		
		boolean flush = false;
		int count = 1;
		while (line!=null) {
			String parts[] = tab.split(line);
			
			int tileX = Integer.parseInt(parts[0]);
			int tileY = Integer.parseInt(parts[1]);
			int minPixelX = Integer.parseInt(parts[2]);
			int minPixelY = Integer.parseInt(parts[3]);
			int maxPixelX = Integer.parseInt(parts[4]);
			int maxPixelY = Integer.parseInt(parts[5]);
			int elevation = Integer.parseInt(parts[6]);
			int relief = Integer.parseInt(parts[7]);
			int tvzcode = Integer.parseInt(parts[8]);
			
			// if it is a new tile (and not the first)
			//if (flush && (zoom!=_zoom || tileX!=_tileX || tileY!=_tileY)) {
			if (flush && (tileX!=_tileX || tileY!=_tileY)) {
				
				//System.out.println("Flushing on line: " + count);
				
				// write the last one
				File f = new File(output, "z" + z + "/" + _tileX);
				f.mkdirs();
				FileOutputStream fos = new FileOutputStream(f.getAbsoluteFile() + "/" + _tileY + ".png");
				BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
				WritableRaster raster = bufferedImage.getWritableTile(0,0);
				
				int[] tile = assignColours(pixels);
				raster.setDataElements(0, 0, tileSize,tileSize, tile);
				PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
				byte[] png = encoder.pngEncode();
				fos.write(png);
				fos.flush();
				fos.close();
				
				pixels = new int[3][tileSize*tileSize];
				pixelsContributers = new int[2][tileSize*tileSize];
				
			}
			
			// draw the pixels
			int width = maxPixelX - minPixelX + 1;
			int height = maxPixelY - minPixelY + 1;
			
			// start at the top
			try {
				int start = (minPixelY * tileSize)+minPixelX;
				for (int i=0; i<height; i++) {
					for (int j=0; j<width; j++){
						
						// elevation
						int value = elevation;
						int contributers = pixelsContributers[0][start + j];
						// interpolate by averaging
						if (contributers>0) {
							value = (int)  ((((double)pixels[0][start + j] * contributers) + value) / (contributers+1));
						}
						pixelsContributers[0][start + j] = contributers + 1;						
						pixels[0][start + j] = value;

						// relief
						value = relief;
						contributers = pixelsContributers[1][start + j];
						// interpolate by averaging
						if (contributers>0) {
							value = (int)  ((((double)pixels[1][start + j] * contributers) + value) / (contributers+1));
						}
						pixelsContributers[1][start + j] = contributers + 1;						
						pixels[1][start + j] = value;
						
						value = tvzcode;
						// interpolate with max
						if(value>pixels[2][start + j]) {
							pixels[2][start + j] = value;
						}
						
					}
					start+=tileSize;
				}
			} catch (java.lang.ArrayIndexOutOfBoundsException e) {
				e.printStackTrace();
				System.err.println("Error on line " + count);
				System.err.println(line);
				// continue on bad pixels
			}
			
			line = reader.readLine();
			flush = true;
			_tileX = tileX;
			_tileY = tileY;
			//_zoom = zoom;
			count++;
		}
		
		
		// always write last tile
		File f = new File(output, "z" + z + "/" + _tileX);
		f.mkdirs();
		FileOutputStream fos = new FileOutputStream(f.getAbsoluteFile() + "/" + _tileY + ".png");
		BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
		WritableRaster raster = bufferedImage.getWritableTile(0,0);
		int[] tile = assignColours(pixels);
		raster.setDataElements(0, 0, tileSize,tileSize, tile);
		PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
		byte[] png = encoder.pngEncode();
		fos.write(png);
		fos.flush();
		fos.close();
	}

	protected static int[] assignColours(int[][] pixels) {
		int[] tile = new int[tileSize * tileSize];
		for (int i=0; i<tile.length; i++) {
			int r = ((int)( pixels[0][i] * (double)0xFF / maxElevation)) << 16 ;			
			int g = ((int)( pixels[1][i] * (double)0xFF / maxRelief)) << 8 ;
			int b = 0;
			if (pixels[2][i] > 0 ) {
				for (int j=0; j<pixels[2][i]; j++) {
					b+=0xF;
				}	
			}
			int color = r|g|b;
			if (color>0) {
				tile[i]=0xFF000000 | color;
			}
		}
		return tile;
	}	
}
