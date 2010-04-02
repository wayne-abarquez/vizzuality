/**
 * 
 */
package com.vizzuality.gmba.process;

import java.awt.Color;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.regex.Pattern;


/**
 * Renders a tile from voldemort store
 * 
 * Rather a quick hack...
 * 
 * @author tim
 */
public class TileRenderer {
	
	protected static Pattern rowSeparator = Pattern.compile("-");
	protected static Pattern valueSeparator = Pattern.compile(",");
	protected static final int tileSize = 256;
	
	// because Colors are cached internally in Java, we save MUCH time creating them first
	// and stopping their garbage collection (300msec to create a color on macbook pro)
	protected static final Color[] colors = {
		new Color(0xFA, 0xBA, 0x00),
		new Color(0xFA, 0xB0, 0x00),
		new Color(0xFD, 0x8D, 0x00),
		new Color(0xF9, 0x7A, 0x00),
		new Color(0xFC, 0x5D, 0x0E),
		new Color(0xFD, 0x3F, 0x16),
		new Color(0xFC, 0x31, 0x17),
		new Color(0xFE, 0x21, 0x1D),
		new Color(0xFE, 0x09, 0x1F)
	};
 
	// the colors that are actually used (internally, Java will pick up a cached color from the 
	// above cache)
	protected static final int[] colorsAsInt = {
		0xFFFABA00,
		0xFFFAB000,
		0xFFFD8D00,
		0xFFF97A00,
		0xFFFC5D0E,
		0xFFFD3F16,
		0xFFFC3117,
		0xFFFE211D,
		0xFFFE091F
	};	
	
	// renders to the output stream and nothing more
	// does not close the OS, but will flush it
	// data in format [x,y,count]* pipe indicates new line
	//    59792,457939,1|59821,457922,2
	public static void render(String data, int zoomLookAhead, OutputStream out) throws IOException {
		//long time = System.currentTimeMillis();
		
		int pixelsPerCell = tileSize / (2<<(zoomLookAhead-1));
		//System.out.println("Pixels per cell = " + pixelsPerCell);
		int[] rasterData = new int[tileSize*tileSize];
		
		//System.out.println("Data: " + data);
		String[] cells = rowSeparator.split(data);
		//System.out.println("Cells: " + cells.length);
		//for (String cell : cells) {
			//System.out.println(cells.toString());
		//}
		for (String cell : cells) {
			try {
				//System.out.println("Cell: " + cell);
				String[] atoms = valueSeparator.split(cell);
				
				// x,y,count
				int x = Integer.parseInt(atoms[0]);
				int y = Integer.parseInt(atoms[1]);
				int count = Integer.parseInt(atoms[2]);
				
				// get the pixel offset for the X,Y in this tile
				int offsetX = getTileOffset(x, zoomLookAhead, pixelsPerCell);
				int offsetY = getTileOffset(y, zoomLookAhead, pixelsPerCell);
				
				//System.out.println("Offset x[" + offsetX + "] y[" + offsetY + "]");
				
				// determine the starting draw position
				int cellStart = (offsetY*tileSize)+(offsetX);
				int colorIndex = getColorIndex(count);
				
				// for the number of rows in the cell
	        	for (int i=0; i<pixelsPerCell; i++) {
	        		//System.out.println("  drawing row");
	        		// draw the cells
	        		for (int j=cellStart; j<cellStart+pixelsPerCell; j++) {
	        			//System.out.println("    drawing column j[" + j + "]");
	        			rasterData[j] = colorsAsInt[colorIndex];
	        		}
	        		cellStart+=tileSize;
	        	}
	        	
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		//System.out.println("Time to generate raster data: " + (System.currentTimeMillis() - time));
		//time = System.currentTimeMillis();
		
		// now create the image from the raster
		
		BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
		WritableRaster raster = bufferedImage.getWritableTile(0,0);
		raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
		PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
		byte[] png = encoder.pngEncode();
		out.write(png);
		out.flush();
		//System.out.println("Time to generate image: " + (System.currentTimeMillis() - time));
	}
	
	/**
	 * @param count to use in lookup
	 * @return the color index to use
	 */
	private static int getColorIndex(int count) {
		int colorIndex = 0;
		if (10 < count && count <= 20) {
			colorIndex = 1;
		} else if (20 < count && count <= 50) {
			colorIndex = 2;
		} else if (50 < count && count <= 100) {
			colorIndex = 3;
		} else if (100 < count && count <= 1000) {
			colorIndex = 4;
		} else if (1000 < count && count <= 3000) {
			colorIndex = 5;
		} else if (3000 < count && count <= 8000) {
			colorIndex = 6;
		} else if (8000 < count && count <= 15000) {
			colorIndex = 7;
		} else if (15000 < count) {
			colorIndex = 8;
		}
		return colorIndex;
	}	
	
	// works out the pixel offset for the top left corner of the cell
	// within the tile being rendered
	protected static int getTileOffset(int x, int zoomLookAhead, int pixelsPerCell) {
		//System.out.println("2<<" +(zoomLookAhead-1) + "=" +  (2<<zoomLookAhead-1));
		int cellIdInTile = x % (2<<zoomLookAhead-1);
		//System.out.println("cellIdInTile: " + cellIdInTile);
		return cellIdInTile * pixelsPerCell;
	}
	
	public static void main(String[] args) {
		try {
			//System.out.println(getTileOffset(11, 3, 32));
			
			for (int i=0; i<10; i++) {
				File f = new File("/tmp/tile-" + i + ".png");
				FileOutputStream fos = new FileOutputStream(f);
				
				System.out.println("Rendering");
				render("59792,457939,1-59821,457922,2", 6, fos);
				System.out.println("Done rendering");
				//render("8,10,100000", 3, fos);
				//render("8,10,100000|11,8,10", 3, fos);
				fos.close();
				System.out.println("Done");
			}
			System.exit(0);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
