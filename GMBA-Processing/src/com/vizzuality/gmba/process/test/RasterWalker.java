package com.vizzuality.gmba.process.test;

import java.awt.Point;
import java.awt.Transparency;
import java.awt.geom.Point2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.regex.Pattern;

import com.vizzuality.gmba.process.GoogleTileUtil;
import com.vizzuality.gmba.process.PngEncoderB;


public class RasterWalker {
	// 24 requires -Xmx256m
	private static final int cellPerDeg = 24;
	private static int [][] raster = new int[360*cellPerDeg][180*cellPerDeg];
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	protected static final int maxZoom = 1;   
	
	// the schema for reading the env raster
	public static final int MIN_LAT = 1;
	public static final int MIN_LNG = 2;
	public static final int ELEVATION = 3;
	
	
	// structure to hold a triplet of ints
	static class Coverage {
		int minX = Integer.MAX_VALUE;
		int maxX = Integer.MIN_VALUE;
		int minY = Integer.MAX_VALUE;
		int maxY = Integer.MIN_VALUE;
		@Override
		public String toString() {
			return "x["+ minX +"-"+ maxX +"] y["+ minY +"-"+ maxY +"]";
		}
	}
	
	static class EnvCell {
		int elevation;
	}
			
	// both loads the environment data into memory
	public static void loadRaster(File f, EnvCell[] environmentRaster) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(f));
		String line = reader.readLine();
		System.out.println("Loading environment data");
		int count = 0;
		while (line!=null) {
			String parts[] = tab.split(line);
			double lat = Double.parseDouble(parts[MIN_LAT]);
			double lng = Double.parseDouble(parts[MIN_LNG]);
			int elevation = Integer.parseInt(parts[ELEVATION]);
			// generate a cell id
			int rasterIndex= new Double(((lat+90)*cellPerDeg*360*cellPerDeg) + ((lng+180)*cellPerDeg)).intValue(); 
			
			EnvCell e = new EnvCell();
			e.elevation = elevation;
			
			environmentRaster[rasterIndex] = e;
			
			if (++count%100000 == 0) {
				System.out.println("Environment cells loaded: " + (count));
			}
			
			line = reader.readLine();
		}
		System.out.println("Environment cells loaded: " + (count));
		reader.close();
	}
	
	public static void main(String[] args) throws IOException {
		EnvCell[] environmentRaster = new EnvCell[360*180*cellPerDeg*cellPerDeg];
		loadRaster(new File("/Users/tim/dev/workspace/GMBA/env.txt"), environmentRaster);
		
		long timeTotal = System.currentTimeMillis();
		
		// then loop the tiles themselves
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			long time = System.currentTimeMillis();
			System.out.println("Starting zoom[" + zoom + "]");
			int scale = 1 << zoom;
			
			// loop the tiles at the zoom
			for (int x=0; x<scale; x++) {
				for (int y=0; y<scale; y++) {
					
					int[] pixels = new int[tileSize*tileSize];
					// stored so we know how many are needed to work out the average 
					// when doing the interlacing
					int[] cellsContributingToPixel = new int[tileSize*tileSize];
					
					Rectangle2D tileBoundary = GoogleTileUtil.getTileRect(x, y, zoom);
					
					double minLat = tileBoundary.getMinY();
					double maxLat = tileBoundary.getMaxY();
					double minLng = tileBoundary.getMinX();
					double maxLng = tileBoundary.getMaxX();
					
					// calculate the min / max raster cells of interest to this tile
					int minRasterIndex= new Double(((minLat+90)*cellPerDeg*360*cellPerDeg) + ((minLng+180)*cellPerDeg)).intValue();
					int maxRasterIndex= new Double(((maxLat+90)*cellPerDeg*360*cellPerDeg) + ((maxLng+180)*cellPerDeg)).intValue();
					
					// calculate the cells either side of the tile index
					int modMin = minRasterIndex%(cellPerDeg*360);
					int modMax = maxRasterIndex%(cellPerDeg*360);
					
					// now loop the cells of interest
					for (int i=minRasterIndex; i<maxRasterIndex; i++) {
						if (i%(cellPerDeg*360) < modMin
								|| i%(cellPerDeg*360) > modMax) {
							continue;
						} else {
							
							// convert the raster id to lat and lng, to get the pixel corners to paint
							double lng = (((double)i%360)/cellPerDeg) - 180;
							
							int rowStart = i - (i%(360*cellPerDeg));
							double lat = (double)rowStart / (cellPerDeg*cellPerDeg*360) - 90;
							
							Point2D p = GoogleTileUtil.toNormalisedPixelCoords(lat, lng);
							int pXmin = (int) (p.getX()*scale*tileSize - (x*tileSize));
							int pYmin = (int) (p.getY()*scale*tileSize - (y*tileSize));
							p = GoogleTileUtil.toNormalisedPixelCoords(lat+(1/cellPerDeg), lng+(1/cellPerDeg));
							int pXmax = (int) (p.getX()*scale*tileSize - (x*tileSize));
							int pYmax = (int) (p.getY()*scale*tileSize - (y*tileSize));
							
							System.out.println("Box: lng[" + lng +"] lat[" + lat + "] x[" + pXmin + "-" + pXmax + "] y[" + pYmin + "-" + pYmax + "]");
							
							int rowPixels = pXmax-pXmin + 1;
							int rowPixelStart = pYmin;
							while (rowPixelStart <= pYmax) {
								// paint the row
								for (int pix=0; pix<=rowPixels; pix++) {
									
									System.out.println("Painting pixel: " + ((rowPixelStart*256) + pix));
									
									pixels[(rowPixelStart*256) + pix] = 0xFFFE091F;
								}
								rowPixelStart+=256;
							}
						}
					}
					
						
					// now fake a PNG write
					File f = new File("/tmp/env/" + zoom + "/" + x);
					f.mkdirs();
					FileOutputStream fos = new FileOutputStream("/tmp/env/" + zoom + "/" + x + "/" + y + ".png");
					BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
					WritableRaster raster = bufferedImage.getWritableTile(0,0);
					raster.setDataElements(0, 0, tileSize,tileSize, pixels);
					PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
					byte[] png = encoder.pngEncode();
					fos.write(png);
					fos.flush();
					fos.close();
					
				}
			}
			System.out.println("Finshed zoom["+ zoom +"], msecs[" + (System.currentTimeMillis()-time) + "]");
		}
		
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		
		System.exit(0);
	}
	
	


	
}
