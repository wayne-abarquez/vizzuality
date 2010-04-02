/**
 * 
 */
package com.vizzuality.gmba.process;

import java.awt.Point;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Comparator;
import java.util.regex.Pattern;

/**
 * A script that will take an input of latitude and longitude and process them to 
 * a cache of tiles for Google Maps
 * 
 * @author tim
 */
public class BuildGTileCache2 {
	// log statements are made occasionally  
	protected static final int LOOP_LOG_INTERVAL = 100000;
	
	// reuse a pattern for parsing the input lines
	protected static final Pattern tab = Pattern.compile("\t");
	
	/**
	 * 
	 * @param input Source data
	 * @param output Output directory
	 * @param latIndex The index in the source data representing the latitude
	 * @param lngIndex The index in the source data representing the longitude
	 * @param countIndex The index in the source data representing the count or null for 1 per line
	 * @param numberZooms To process to inclusive
	 * @throws IOException If the output file cannot be written to
	 */
	public int generateGoogleIds(File input, File output, int latIndex, int lngIndex, Integer countIndex, int numberZooms) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(input));
		FileWriter writer = new FileWriter(output);
		int recordCount=0;
		try {
			String line = reader.readLine();
			int lineCount=1;
			
			while (line != null) {
				String[] parts = tab.split(line);
				
				if (parts.length<latIndex
						|| parts.length<lngIndex
						|| (countIndex!=null && parts.length<countIndex)) {
					System.err.println("Invalid number of parts on line ");
				} else {
					try {
						String latString = parts[latIndex];
						String lngString = parts[lngIndex];
						int count = 1;
						if (countIndex!=null) {
							count = Integer.parseInt(parts[countIndex]);	
						}
						
						
						BigDecimal lat = null;
						if (isNotNull(latString)) {
							lat = new BigDecimal(latString);
						}
						BigDecimal lng = null;
						if (isNotNull(lngString)) {
							lng = new BigDecimal(lngString);
						}
						
						// check all values are accounted for
						if (lat!=null && lng!=null && count>0) {
							
							// only deal with things in range
							if (Math.floor(lat.doubleValue())>-85 && Math.ceil(lat.doubleValue())<85
									&& lng.intValue()>=-180 && lng.intValue()<180) {
								
								// write the intermediate output file
								// this is:
								// z0_x z0_y z1_x z1_y... count
								for (int i=0; i<=numberZooms; i++) {
									Point p = GoogleTileUtil.toTileXY(lat.doubleValue(), lng.doubleValue(), i);
									//writer.write(lat + "\t" +lng + "\t" + p.x + "\t" + p.y + "\t");
									writer.write(p.x + "\t" + p.y + "\t");
								}
								writer.write(count + "\n");
								
								recordCount++;
							}
						}
						
					} catch (NumberFormatException e) {
						System.out.println(lineCount + " has bad data: " + line);
					}
				}
				
				if (lineCount%LOOP_LOG_INTERVAL == 0) {
					System.out.println("Processed " + lineCount + ": " + line);
				}
				
				line = reader.readLine();
				lineCount++;
			}
			
		} finally {
			reader.close();
			writer.close();
		}
		return recordCount;
	}
	
	/**
	 * @param s To check
	 * @return true if it is not apparently null
	 */
	private boolean isNotNull(String s) {
		if (s!=null 
				&& !"NULL".equalsIgnoreCase(s)
				&& !"\\N".equalsIgnoreCase(s)
				&& !"\\\\N".equalsIgnoreCase(s)
				&& !"".equalsIgnoreCase(s)
				&& !" ".equalsIgnoreCase(s)) {
				return true;
		} else {
			return false;	
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// 9 is lat, 10 is lng
		BuildGTileCache2 me = new BuildGTileCache2();
		try {
			File fin = new File("/Users/tim/dev/GMBA/tim_lat_lng_cnt.txt");
			File fgoogle = new File("/tmp/gmba/googleTilesDensity.txt");
			//File fin = new File("/tmp/tim/tim_lat_lng_cnt.txt");
			//File fgoogle = new File("/tmp/tim/googleId.txt");
			int recordCount = me.generateGoogleIds(fin,fgoogle,0, 1, 2, 13);
			System.out.println("Records with data: " + recordCount);
			
			// now sort the file
//			FileUtils util = new FileUtils();
//			File fgoogleSorted = new File("/tmp/gmba/googleTilesDensitySorted.txt");
//			util.sort(fgoogle, fgoogleSorted, "_part", 100000, ".txt", 
//					new Comparator<Object>(){
//						@Override
//						public int compare(Object o1, Object o2) {
//							return ((String) o1).compareTo((String) o2);
//						}});
//			
//			System.out.println("Sorted google tile data");
			// linux sort infile -o outfile is better
			
			
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
