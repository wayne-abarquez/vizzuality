package com.vizzuality.gmba.process.test;

import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;

import com.vizzuality.gmba.process.GoogleTileUtil;
import com.vizzuality.gmba.process.PngEncoderB;


public class RasterInMemory {
	// 24 requires -Xmx256m
	private static final int cellPerDeg = 24;
	private static int [][] raster = new int[360*cellPerDeg][180*cellPerDeg];
	
	public static void main(String[] args) throws IOException {
		int maxZoom = 7;   
		Random random = new Random();
		
		System.out.println("Writing random data");
		for (int i=0; i<raster.length; i++) {
			for (int j=0; j<raster[i].length; j++) {
				raster[i][j] = random.nextInt(100);
			}
		}
		System.out.println("Done writing random data");
		
		long timeTotal = System.currentTimeMillis();
		
		// simulate rendering each pixel in each tile by looking up the 
		// raster layer values
		
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			// utility counts
			int numTiles = 0;
			long pixelsInspected = 0;

			System.out.println("Starting zoom[" + zoom + "]");
			long time = System.currentTimeMillis();
			// each of the X tiles
			for (int x=0; x<(1<<zoom); x++) {
				// each of the X tiles
				for (int y=0; y<(1<<zoom); y++) {
					
					// the data for the tile
					int[] rasterData = new int[tileSize*tileSize];
					
					
					// for each row of the tiles
					for (int pixelX=0; pixelX<tileSize; pixelX++) {
						// for each column of the row
						for (int pixelY=0; pixelY<tileSize; pixelY++) {
							// simulate a lookup and a google calc
							//int value = (raster[x][y]);
							//GoogleTileUtil.toTileXY(pixelX, pixelY, zoom);
							
							//double topLat = Math.toDegrees((2 * Math.atan(Math.exp(Math.PI * (1 - (2 * topLatMerc))))) - (Math.PI / 2));
							
							
							
							// pick a random color
							//System.out.println(value + ": " + colorsAsInt[value%colorsAsInt.length]);
							//rasterData[(tileSize*pixelX) + pixelY] = colorsAsInt[random.nextInt(colorsAsInt.length)];
							//rasterData[(tileSize*pixelX) + pixelY] = colorsAsInt[(pixelX/pixelY)%6];
							//rasterData[(tileSize*pixelX) + pixelY] = colorsAsInt[value%colorsAsInt.length];
							//rasterData[(tileSize*pixelX) + pixelY] = colorsAsInt[(new Long(pixelsInspected)).intValue()%colorsAsInt.length];
							rasterData[(tileSize*pixelX) + pixelY] = random.nextInt();
							pixelsInspected++;
						}
					}

					// now fake a PNG write
					File f = new File("/tmp/env/" + zoom + "/" + x);
					f.mkdirs();
					FileOutputStream fos = new FileOutputStream("/tmp/env/" + zoom + "/" + x + "/" + y + ".png");
					BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
					WritableRaster raster = bufferedImage.getWritableTile(0,0);
					raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
					PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
					byte[] png = encoder.pngEncode();
					fos.write(png);
					fos.flush();
					fos.close();
					
					
					numTiles++;
					
				}
			}
			
			System.out.println("Finshed zoom["+ zoom +"], tiles["+ numTiles +"], pixels["+ pixelsInspected +"], msecs[" + (System.currentTimeMillis()-time) + "]");
		}
		
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		System.exit(0);
	}
	
	protected static final int tileSize = 256;

	// because Colors are cached internally in Java, we save MUCH time creating them first
	// and stopping their garbage collection (300msec to create a color on macbook pro)
/*	
	protected static final Color[] colors = {
		new Color(0xFA, 0xBA, 0x00),
		new Color(0xFA, 0xB0, 0x00),
//		new Color(0xFD, 0x8D, 0x00),
//		new Color(0xF9, 0x7A, 0x00),
		new Color(0xFC, 0x5D, 0x0E),
		new Color(0xFD, 0x3F, 0x16),
		new Color(0xFC, 0x31, 0x17),
//		new Color(0xFE, 0x21, 0x1D),
		new Color(0xFE, 0x09, 0x1F)
	};
 
	// the colors that are actually used (internally, Java will pick up a cached color from the 
	// above cache)
	protected static final int[] colorsAsInt = {
		0xFFFABA00,
		0xFFFAB000,
//		0xFFFD8D00,
//		0xFFF97A00,
		0xFFFC5D0E,
		0xFFFD3F16,
		0xFFFC3117,
//		0xFFFE211D,
		0xFFFE091F
	};	
	
	*/
	
	
}
