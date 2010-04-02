package com.vizzuality.gmba.process.raster;

import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.regex.Pattern;

import com.vizzuality.gmba.process.GoogleTileUtil;


public class RasterMap {
	// 24 requires -Xmx256m
	private static final int cellPerDeg = 24;
	//private static int [][] raster = new int[360*cellPerDeg][180*cellPerDeg];
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	protected static final int maxZoom = 7;   
	
	// the schema for reading the env raster
	public static final int MIN_LAT = 1;
	public static final int MIN_LNG = 2;
	public static final int ELEVATION = 3;
	public static final int RELIEF = 4;
	public static final int TPCODE = 9;
	
	
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
	public static void loadRaster(File f, File outputdir, String filePrefix) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(f));
		String line = reader.readLine();
		System.out.println("Rendering environment data");
		int count = 0;
		
		FileWriter[] writers = new FileWriter[maxZoom+1];
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			writers[zoom] = new FileWriter(outputdir.getCanonicalPath() + "/" + filePrefix + "_z" + zoom + ".txt");
		}
		
		while (line!=null) {
			String parts[] = tab.split(line);
			double lat = Double.parseDouble(parts[MIN_LAT]);
			double lng = Double.parseDouble(parts[MIN_LNG]);
			int elevation = Integer.parseInt(parts[ELEVATION]);
			int relief = Integer.parseInt(parts[RELIEF]);
			int tpCode = Integer.parseInt(parts[TPCODE]);
			
			for (int zoom=0; zoom<=maxZoom; zoom++) {
				
				if (lat>85 || lat<-85) {
					continue;
				}
				
				int scale = 1 << zoom;
				
				// find the total pixels
				// p1 is the lower left, p2 the upper right, so google Y is inverted!
				Point2D p = GoogleTileUtil.toNormalisedPixelCoords(lat, lng);
				Point2D p2 = GoogleTileUtil.toNormalisedPixelCoords(((cellPerDeg*lat)+1)/cellPerDeg, ((cellPerDeg*lng)+1)/cellPerDeg);
				
				// calculate the tiles covered by this cell
				int tile1X = (int)(p.getX()*scale);
				int tile1Y = (int)(p.getY()*scale);
				int tile2X = (int)(p2.getX()*scale);
				int tile2Y = (int)(p2.getY()*scale);
				
				// for each tile covered
				// note the y invertion
				for (int x=tile1X; x<=tile2X; x++) {
					for (int y=tile2Y; y<=tile1Y; y++) {
						
						// x and y represent the tile we are in
						// determine the pixel corners to render
						// note again y goes top to bottom
						int minPixelX = (int)((p.getX()*scale*tileSize) - (x*tileSize));
						int minPixelY = (int)((p2.getY()*scale*tileSize) - (y*tileSize));
						int maxPixelX = (int)((p2.getX()*scale*tileSize) - (x*tileSize));
						int maxPixelY = (int)((p.getY()*scale*tileSize) - (y*tileSize));
						
						// put them into limits, which is needed when they span tile boundaries
						maxPixelX = (maxPixelX<0) ? 0 : maxPixelX;
						maxPixelX = (maxPixelX>255) ? 255 : maxPixelX;
						minPixelX = (minPixelX<0) ? 0 : minPixelX;
						minPixelX = (minPixelX>255) ? 0 : minPixelX;

						maxPixelY = (maxPixelY<0) ? 0 : maxPixelY;
						maxPixelY = (maxPixelY>255) ? 255 : maxPixelY;
						minPixelY = (minPixelY<0) ? 0 : minPixelY;
						minPixelY = (minPixelY>255) ? 0 : minPixelY;
						
						//writers[zoom].write(zoom + "\t" + x + "\t" + y + "\t" + minPixelX + "\t" + maxPixelY + "\t" + maxPixelX + "\t" + minPixelY + "\t" + elevation + "\n");
						writers[zoom].write(x + "\t" + y + "\t" + minPixelX + "\t" + minPixelY + "\t" + maxPixelX + "\t" + maxPixelY + "\t" + elevation + "\t" + relief + "\t" + tpCode + "\n");
					}
				}
			}
			
			if (++count%1000000 == 0) {
				System.out.println("Environment cells loaded: " + (count));
			}
			
			line = reader.readLine();
		}
		System.out.println("Environment cells loaded: " + (count));
		reader.close();
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			writers[zoom].flush();
			writers[zoom].close();
		}
	}
	
	public static void main(String[] args) throws IOException {
//		double lat = 82.6667;
//		double lng = -81;
//		int scale = 1 << 4;
//		Point2D p = GoogleTileUtil.toNormalisedPixelCoords(lat, lng);
//		int tileX = (int)(p.getX()*scale);
//		int tileY = (int)(p.getY()*scale);
//		int minPixelX = (int)((p.getX()*scale*tileSize) - (tileX*tileSize));
//		int minPixelY = (int)((p.getY()*scale*tileSize) - (tileY*tileSize));
//		p = GoogleTileUtil.toNormalisedPixelCoords(((cellPerDeg*lat)+1)/cellPerDeg, ((cellPerDeg*lng)+1)/cellPerDeg);
//		int maxPixelX = (int)((p.getX()*scale*tileSize) - (tileX*tileSize));
//		int maxPixelY = (int)((p.getY()*scale*tileSize) - (tileY*tileSize));
//		
//		System.out.println(p.getY()*scale*tileSize);
//		System.out.println(lat);
//		
//		System.out.println(tileY + ":"+ ((int)(p.getY()*scale)));
//		
//		System.out.println(lng);
//		System.out.println(((cellPerDeg*lat)+1)/cellPerDeg);
//		System.out.println(((cellPerDeg*lng)+1)/cellPerDeg);
//		System.out.println(minPixelX + "\t" + maxPixelY + "\t" + maxPixelX + "\t" + minPixelY + "\t" + "\n");
//		if (true) return;
		
		long timeTotal = System.currentTimeMillis();
		loadRaster(new File("/Users/tim/dev/workspace/GMBA/env.txt"), new File("/tmp/"), "env");
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		
		System.exit(0);
	}
	
	


	
}
