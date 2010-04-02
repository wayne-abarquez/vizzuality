package com.vizzuality.gmba.process.test;

import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.Raster;
import java.awt.image.WritableRaster;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Pattern;

import com.vizzuality.gmba.process.PngEncoderB;


public class Renderer2 {
	// 24 requires -Xmx256m
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	
	public static void main(String[] args) throws IOException {
		run(new File("/tmp/env_z0_Sorted.txt"), 0);
		run(new File("/tmp/env_z1_Sorted.txt"), 1);
		run(new File("/tmp/env_z2_Sorted.txt"), 2);
		run(new File("/tmp/env_z3_Sorted.txt"), 3);
		run(new File("/tmp/env_z4_Sorted.txt"), 4);
		run(new File("/tmp/env_z5_Sorted.txt"), 5);
		run(new File("/tmp/env_z6_Sorted.txt"), 6);
		run(new File("/tmp/env_z7_Sorted.txt"), 7);
//		run(new File("/tmp/env_z8_Sorted.txt"), 8);
//		run(new File("/tmp/env_z9_Sorted.txt"), 9);
		System.exit(0);
	}

	public static void run(File input, int z) throws IOException {
		System.out.println("Running: " + input.getCanonicalPath());
		BufferedReader reader = new BufferedReader(new FileReader(input));
		String line = reader.readLine();
		
		// prev row values
		int _tileX=-1;
		int _tileY=-1;
		//int _zoom=-1;
		int[] pixels = new int[tileSize*tileSize];
		int[] pixelsContributers = new int[tileSize*tileSize];
		boolean flush = false;
		int count = 1;
		while (line!=null) {
			String parts[] = tab.split(line);
			
			//int zoom = Integer.parseInt(parts[0]);
			int tileX = Integer.parseInt(parts[0]);
			int tileY = Integer.parseInt(parts[1]);
			int minPixelX = Integer.parseInt(parts[2]);
			int minPixelY = Integer.parseInt(parts[3]);
			int maxPixelX = Integer.parseInt(parts[4]);
			int maxPixelY = Integer.parseInt(parts[5]);
			int elevation = Integer.parseInt(parts[6]);
			
			// if it is a new tile (and not the first)
			//if (flush && (zoom!=_zoom || tileX!=_tileX || tileY!=_tileY)) {
			if (flush && (tileX!=_tileX || tileY!=_tileY)) {
				
				//System.out.println("Flushing on line: " + count);
				
				// write the last one
				File f = new File("/tmp/env/z" + z + "/" + _tileX);
				f.mkdirs();
				FileOutputStream fos = new FileOutputStream("/tmp/env/z" + z + "/" + _tileX + "/" + _tileY + ".png");
				BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
				WritableRaster raster = bufferedImage.getWritableTile(0,0);
				
				// assign colours
				assignColours(pixels);
								
				
				raster.setDataElements(0, 0, tileSize,tileSize, pixels);
				PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
				byte[] png = encoder.pngEncode();
				fos.write(png);
				fos.flush();
				fos.close();
				
				pixels = new int[tileSize*tileSize];
				pixelsContributers = new int[tileSize*tileSize];
				
			}
			
			// draw the pixels
			int width = maxPixelX - minPixelX + 1;
			int height = maxPixelY - minPixelY + 1;
			
			// start at the top
			try {
				int start = (minPixelY * tileSize)+minPixelX;
				for (int i=0; i<height; i++) {
					for (int j=0; j<width; j++){
						int contributers = pixelsContributers[start + j];
						int value = elevation;
						// interpolate by averaging
						if (contributers>0) {
							value = (int)  ((((double)pixels[start + j] * contributers) + value) / (contributers+1));
						}
						pixelsContributers[start + j] = contributers + 1;						
						pixels[start + j] = value;

						// interpolate with max
//						if(value>pixels[start + j]) {
//							pixels[start + j] = value;
//						}
						
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
		File f = new File("/tmp/env/z" + z + "/" + _tileX);
		f.mkdirs();
		FileOutputStream fos = new FileOutputStream("/tmp/env/z" + z + "/" + _tileX + "/" + _tileY + ".png");
		BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
		WritableRaster raster = bufferedImage.getWritableTile(0,0);
		assignColours(pixels);
		
		raster.setDataElements(0, 0, tileSize,tileSize, pixels);
		PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
		byte[] png = encoder.pngEncode();
		fos.write(png);
		fos.flush();
		fos.close();
		

		
		
	}

	private static void assignColours(int[] pixels) {
		for (int i=0; i<pixels.length; i++) {
			if (pixels[i]<=100) {
				pixels[i]=0;
			} else if (pixels[i]<=300) {
				pixels[i] = 0x11FF0000; 
			} else if (pixels[i]<=600) {
				pixels[i] = 0x22FF0000; 
			} else if (pixels[i]<=900) {
				pixels[i] = 0x33FF0000; 
			} else if (pixels[i]<=1300) {
				pixels[i] = 0x44FF0000; 
			} else if (pixels[i]<=1800) {
				pixels[i] = 0x55FF0000; 
			} else if (pixels[i]<=2400) {
				pixels[i] = 0x66FF0000; 
			} else if (pixels[i]<=2800) {
				pixels[i] = 0x77FF0000; 
			} else if (pixels[i]<=3200) {
				pixels[i] = 0x88FF0000; 
			} else if (pixels[i]<=3600) {
				pixels[i] = 0x99FF0000; 
			} else if (pixels[i]<=4000) {
				pixels[i] = 0xAAFF0000; 
			} else if (pixels[i]<=4400) {
				pixels[i] = 0xBBFF0000; 
			} else if (pixels[i]<=4800) {
				pixels[i] = 0xCCFF0000; 
			} else if (pixels[i]<=5200) {
				pixels[i] = 0xDDFF0000; 
			} else if (pixels[i]<=5600) {
				pixels[i] = 0xEEFF0000; 
			} else if (pixels[i]>=5600) {
				pixels[i] = 0xFFFF0000; 
			}
		}
	}	
}
