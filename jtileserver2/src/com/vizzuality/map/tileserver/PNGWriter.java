package com.vizzuality.map.tileserver;

import java.awt.Color;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

/**
 * Writes the PNG to the output stream
 * @author tim
 */
public class PNGWriter {
	protected static final int tileSize = 256;
	
	
	public byte[] generate(List<TileCluster> clusters) throws IOException {
		long ts = System.currentTimeMillis();
		// don't waste time setting up PNG if no data
		if (clusters.size()>0) {
			int[] rasterData = new int[tileSize*tileSize];
			ts = ts("Raster created in", ts);
			for (TileCluster tdc : clusters) {
				// get the pixel offset for the X,Y in this tile
				//int offsetX = getTileOffset(tdc.getClusterX(), zoomLookAhead, pixelsPerCell);
				//int offsetY = getTileOffset(tdc.getClusterY(), zoomLookAhead, pixelsPerCell);
				int x = tdc.getClusterX();
				int y = tdc.getClusterY();
				
				// System.out.println("Offset x[" + offsetX + "] y[" +offsetY + "]");
				
				//draw the cells
				try {
					
					// center cell
					rasterData[x + (256*y)] = 0xFFFF6666;
					
					// 5x5 box around the center
					for (int i=x-2; i<=x+2; i++) {
						for (int j=y-2; j<=y+2; j++) {
							draw(rasterData, 0xFFFF6666, i + (256*j));
						}
					}
					
					// black perimeter
					draw(rasterData, 0xFF000000, x-4 + (256*(y-1)));
					draw(rasterData, 0xFF000000, x-4 + (256*(y)));
					draw(rasterData, 0xFF000000, x-4 + (256*(y+1)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y-1)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y+1)));
					draw(rasterData, 0xFF000000, x-1 + (256*(y-4)));
					draw(rasterData, 0xFF000000, x + (256*(y-4)));
					draw(rasterData, 0xFF000000, x+1 + (256*(y-4)));
					draw(rasterData, 0xFF000000, x-1 + (256*(y+4)));
					draw(rasterData, 0xFF000000, x + (256*(y+4)));
					draw(rasterData, 0xFF000000, x+1 + (256*(y+4)));					
					
					// corner
					draw(rasterData, 0xFF000000, x-3 + (256*(y-3)));
					draw(rasterData, 0xFF000000, x+3 + (256*(y-3)));
					draw(rasterData, 0xFF000000, x-3 + (256*(y+3)));
					draw(rasterData, 0xFF000000, x+3 + (256*(y+3)));
					// rounded edge of black perimeter
					draw(rasterData, 0xFF1A1A1A, x-4 + (256*(y-2)));
					draw(rasterData, 0xFF1A1A1A, x-2 + (256*(y-4)));
					draw(rasterData, 0xFF1A1A1A, x+2 + (256*(y-4)));
					draw(rasterData, 0xFF1A1A1A, x+4 + (256*(y-2)));
					draw(rasterData, 0xFF1A1A1A, x+4 + (256*(y+2)));
					draw(rasterData, 0xFF1A1A1A, x+2 + (256*(y+4)));
					draw(rasterData, 0xFF1A1A1A, x-2 + (256*(y+4)));
					draw(rasterData, 0xFF1A1A1A, x-4 + (256*(y+2)));
					
					// between center and perimeter
					draw(rasterData, 0xFF552222, x-2 + (256*(y-3)));
					draw(rasterData, 0xFFAA4444, x-1 + (256*(y-3)));
					draw(rasterData, 0xFFCC5555, x + (256*(y-3)));
					draw(rasterData, 0xFFAA4444, x+1 + (256*(y-3)));
					draw(rasterData, 0xFF552222, x+2 + (256*(y-3)));
					draw(rasterData, 0xFF552222, x-2 + (256*(y+3)));
					draw(rasterData, 0xFFAA4444, x-1 + (256*(y+3)));
					draw(rasterData, 0xFFCC5555, x + (256*(y+3)));
					draw(rasterData, 0xFFAA4444, x+1 + (256*(y+3)));
					draw(rasterData, 0xFF552222, x+2 + (256*(y+3)));
					draw(rasterData, 0xFF552222, x-3 + (256*(y-2)));
					draw(rasterData, 0xFFAA4444, x-3 + (256*(y-1)));
					draw(rasterData, 0xFFCC5555, x-3 + (256*(y)));
					draw(rasterData, 0xFFAA4444, x-3 + (256*(y+1)));
					draw(rasterData, 0xFF552222, x-3 + (256*(y+2)));
					draw(rasterData, 0xFF552222, x+3 + (256*(y-2)));
					draw(rasterData, 0xFFAA4444, x+3 + (256*(y-1)));
					draw(rasterData, 0xFFCC5555, x+3 + (256*(y)));
					draw(rasterData, 0xFFAA4444, x+3 + (256*(y+1)));
					draw(rasterData, 0xFF552222, x+3 + (256*(y+2)));

					
				} catch (RuntimeException e) {
				}
				
				// for the number of rows in the cell
//	        	for (int i=0; i<pixelsPerCell; i++) {
//	        		// draw the cells
//	        		for (int j=cellStart; j<cellStart+pixelsPerCell; j++) {
//	        			try {
//							rasterData[j] = colorsAsInt[colorIndex];
//						} catch (RuntimeException e) {
//							log.error(e.getMessage(), e);
//						}
//	        		}
//	        		cellStart+=tileSize;
//	        	}							
			}
			ts = ts("Raster drawn in", ts);
			BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
			ts = ts("BufferedImage created in", ts);
			WritableRaster raster = bufferedImage.getWritableTile(0,0);
			ts = ts("Raster created in", ts);
			raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
			ts = ts("Raster data set in", ts);
			PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
			byte[] png = encoder.pngEncode();
			ts = ts("PNG Encoded in", ts);
			
			return png;
		}
		return null;
	}

	private void draw(int[] rasterData, int col, int index) {
		try {
			if (index>=0 && index<rasterData.length)
				rasterData[index] = col;
		} catch (RuntimeException e) {
		}
	}
	
	// because Colors are cached internally in Java, we save MUCH time creating them first
	// and stopping their garbage collection (300msec to create a color on macbook pro)
	protected static final Color[] colors = {
		new Color(0xFF, 0x66, 0x66),
		new Color(0x00, 0x00, 0x00),
		new Color(0x1A, 0x1A, 0x1A),
		new Color(0x55, 0x22, 0x22),
		new Color(0xAA, 0x44, 0x44),
		new Color(0xCC, 0x55, 0x55)
	};
 
	// the colors that are actually used (internally, Java will pick up a cached color from the 
	// above cache)
	protected static final int[] colorsAsInt = {
		0xFFFF6666,
		0xFF000000,
		0xFF1A1A1A,
		0xFF552222,
		0xFFAA4444,
		0xFFCC5555		
	};
	public long ts(String message, long last) {
		System.out.println(message + ": " + (System.currentTimeMillis() - last));
		return System.currentTimeMillis();
	}
	
}