package com.vizzuality.map.tileserver.util;

import java.awt.Color;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;

import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.ext.MessageBodyWriter;
import javax.ws.rs.ext.Provider;

import org.apache.log4j.Logger;

import com.vizzuality.map.tileserver.model.TileCluster;

/**
 * Writes the PNG to the output stream
 * @author tim
 */
@Provider
@Produces("image/png")
public class PNGWriter<T> implements MessageBodyWriter<T> {
	protected static final int tileSize = 256;
	protected static Logger log = Logger.getLogger(PNGWriter.class);
	
	// this is hard coded, and should really be parameterized, based on the way the data was processed
	protected static int pixelsPerCell = 4;
	protected static int zoomLookAhead = 6; // TODO determine this by calculating 2^zoomlookahead = tileSize
	
	public void writeTo(T t, Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType,
			MultivaluedMap<String, Object> httpHeaders, OutputStream entityStream) throws IOException,
			WebApplicationException {
		
		// TODO a test perhaps?
		List<TileCluster> clusters = (List<TileCluster>) t;
		log.debug("Cluster size: " + clusters.size());
		
		// don't waste time setting up PNG if no data
		if (clusters.size()>0) {
			int[] rasterData = new int[tileSize*tileSize];
			
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
			
			
			BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
			WritableRaster raster = bufferedImage.getWritableTile(0,0);
			raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
			PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
			byte[] png = encoder.pngEncode();
			entityStream.write(png);
		}
	}

	private void draw(int[] rasterData, int col, int index) {
		try {
			if (index>=0 && index<rasterData.length)
				rasterData[index] = col;
		} catch (RuntimeException e) {
		}
	}
	
	public long getSize(T t, Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType) {
		return -1;
	}

	public boolean isWriteable(Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType) {
		return true;
	}
	
	// works out the pixel offset for the top left corner of the cell
	// within the tile being rendered
	protected static int getTileOffset(int x, int zoomLookAhead, int pixelsPerCell) {
		int cellIdInTile = x % (2 << zoomLookAhead - 1);
		return cellIdInTile * pixelsPerCell;
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
	};}