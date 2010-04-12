package com.vizzuality.gmba.process.tiles;

import java.awt.geom.Point2D;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.regex.Pattern;


public class RasterPrepare {
	// 24 requires -Xmx256m
	private static final int cellPerDeg = 24;
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	
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
	public static void loadRaster(File f, File outputdir, String filePrefix, int maxZoom, int minLatIndex, int minLngIndex, int elevationIndex, int reliefIndex, int tpCpdeIndex) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(f));
		String line = reader.readLine();
		System.out.println("Preparing environment data");
		int count = 0;
		
		FileWriter[] writers = new FileWriter[maxZoom+1];
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			writers[zoom] = new FileWriter(outputdir.getCanonicalPath() + "/" + filePrefix + "_z" + zoom + ".txt");
		}
		
		while (line!=null) {
			String parts[] = tab.split(line);
			double lat = Double.parseDouble(parts[minLatIndex]);
			double lng = Double.parseDouble(parts[minLngIndex]);
			int elevation = Integer.parseInt(parts[elevationIndex]);
			int relief = Integer.parseInt(parts[reliefIndex]);
			int tvzcode = Integer.parseInt(parts[tpCpdeIndex]);
			
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
						maxPixelX = (maxPixelX>tileSize-1) ? tileSize-1 : maxPixelX;
						minPixelX = (minPixelX<0) ? 0 : minPixelX;
						minPixelX = (minPixelX>tileSize-1) ? 0 : minPixelX;

						maxPixelY = (maxPixelY<0) ? 0 : maxPixelY;
						maxPixelY = (maxPixelY>tileSize-1) ? tileSize-1 : maxPixelY;
						minPixelY = (minPixelY<0) ? 0 : minPixelY;
						minPixelY = (minPixelY>tileSize-1) ? 0 : minPixelY;
						
						//writers[zoom].write(zoom + "\t" + x + "\t" + y + "\t" + minPixelX + "\t" + maxPixelY + "\t" + maxPixelX + "\t" + minPixelY + "\t" + elevation + "\n");
						writers[zoom].write(x + "\t" + y + "\t" + minPixelX + "\t" + minPixelY + "\t" + maxPixelX + "\t" + maxPixelY + "\t" + elevation + "\t" + relief + "\t" + tvzcode + "\n");
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
		if (args.length != 9) {
			System.out.println("Usage: RasterPrepare sourceFile outputDir filePrefix numberOfZooms minLatitudeIndex minLongitudeIndex elevationIndex reliefIndex tvzCodeIndex");
			return;
		}
		
		// the schema for reading the env raster
		int zoom=Integer.parseInt(args[3]);
		int minLat=Integer.parseInt(args[4]);
		int minLng=Integer.parseInt(args[5]);
		int elevation=Integer.parseInt(args[6]);
		int relief=Integer.parseInt(args[7]);
		int tvzCode=Integer.parseInt(args[8]);
		
		long timeTotal = System.currentTimeMillis();
		loadRaster(new File(args[0]), new File(args[1]), args[2], zoom, minLat, minLng, elevation, relief, tvzCode);
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		
		System.exit(0);
	}
	
	


	
}
