package com.vizzuality.gmba.process.test;

import java.awt.Point;
import java.awt.Transparency;
import java.awt.geom.Point2D;
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


public class RasterWalkerOld {
	// 24 requires -Xmx256m
	private static final int cellPerDeg = 24;
	private static int [][] raster = new int[360*cellPerDeg][180*cellPerDeg];
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	protected static final int maxZoom = 7;   
	
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
		loadRaster(new File("/Users/tim/dev/workspace/GMBA/src/com/vizzuality/gmba/process/test/env.txt"), environmentRaster);
		
		
		System.out.println("Writing random data");
		// loop the environment raster
		Random random = new Random();
		for (int i=0; i<raster.length; i++) {
			for (int j=0; j<raster[i].length; j++) {
				raster[i][j] = random.nextInt(100);
			}
		}
		System.out.println("Done writing random data");
		
		long timeTotal = System.currentTimeMillis();
		
		// start by indexing the env data by tile id:
		
		// zo: 0,0 width = all, start=0, height=all
		// z1: 0,0 width = half, start=0, height=half
		// z1: 0,1 width = half, start=..., height=half
		// kind of thing.
		
		// each list item is a zoom
		// the map provides the google tile identifier mapped to the raster content cells
		List<Map<Point,Coverage>> rasterIndex = new LinkedList<Map<Point,Coverage>>();
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			System.out.println("Indexing zoom " + zoom);
			
			int scale = 1<<zoom;
			Map<Point, Coverage> zoomIndex = new HashMap<Point, Coverage>();
			
			// loop the tiles at the zoom
			for (int x=0; x<scale; x++) {
				for (int y=0; y<scale; y++) {
					
					Coverage c = new Coverage();
					
					// find the column
					for (int i=0; i<raster.length; i++) {
						double lng = ((double)i/cellPerDeg)-180;
						int tileX = GoogleTileUtil.toTileX(lng, zoom);
						if (tileX==x && i<c.minX) {
							c.minX=i;
						}
						lng+=(1/cellPerDeg);
						tileX = GoogleTileUtil.toTileX(lng, zoom);
						if (tileX==x && i>c.maxX) {
							c.maxX=i;
						}						
					}
					// find the row
					for (int i=0; i<raster[0].length; i++) {
						double lat = (((double)i/cellPerDeg)-90);
						
						if(lat>85 || lat<-85){
							//System.out.println("Skipping: " + lat);
							continue;
						}
						
						int tileY = GoogleTileUtil.toTileY(lat, zoom);
						if (tileY==y && i>c.maxY) {
							c.maxY=i;
						}
						lat+=(1/cellPerDeg);
						tileY = GoogleTileUtil.toTileY(lat, zoom);
						if (tileY==y && i<c.minY) {
							c.minY=i;
						}						
					}
					
					if (c.minY<Integer.MAX_VALUE
							&& c.maxY>Integer.MIN_VALUE) {
						//System.out.println("Tile[" + x + "," + y + "]: " + c);
						zoomIndex.put(new Point(x,y), c);
					}
				}
			}
			rasterIndex.add(zoomIndex);
		}
		System.out.println("Done indexing");
		
		// then loop the tiles themselves
		// open the raster, and store the # cells contributing to the raster
		// in each loop, loop ONLY the cells of interest and project them on to the tiles

		// this reduces calculatations massively
		
		
		
		for (int zoom=0; zoom<=maxZoom; zoom++) {
			long time = System.currentTimeMillis();
			System.out.println("Starting zoom[" + zoom + "]");
			int scale = 1 << zoom;
			
			Map<Point, Coverage> zoomRaster = rasterIndex.get(zoom);
			
			// loop the tiles at the zoom
			for (int x=0; x<scale; x++) {
				for (int y=0; y<scale; y++) {
					
					int[] rasterData = new int[tileSize*tileSize];
					// stored so we know how many are needed to work out the average 
					// when doing the interlacing
					int[] cellsContributingToPixel = new int[tileSize*tileSize];
					
					// get the raster cells of interest to this tile
					Coverage c = zoomRaster.get(new Point(x,y));
					
					if (c!=null) {
						// loop the environment raster
						for (int i=c.minX; i<=c.maxX; i++) {
							for (int j=c.minY; j<=c.maxY; j++) {
						
								// longitude
								double lng = (i/cellPerDeg)-180;
								double lat = (j/cellPerDeg)-90;
								Point tileRef = GoogleTileUtil.toTileXY(lat, lng, zoom);
								if (tileRef.x==x && tileRef.y==y) {
									Point2D p = GoogleTileUtil.toNormalisedPixelCoords(lat, lng);
									double pX = p.getX()*scale;
									double pY = p.getY()*scale;
									// TODO write to tile raster
									
									
									
								}
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
					} else {
						System.out.println("No coverage for z[" + zoom + "] x[" + x + "] y[" + y + "]");
					}
					
				}
			}
			System.out.println("Finshed zoom["+ zoom +"], msecs[" + (System.currentTimeMillis()-time) + "]");
		}
		
		System.out.println("Total msecs[" + (System.currentTimeMillis()-timeTotal) + "]");
		
		System.exit(0);
	}
	
	


	
}
