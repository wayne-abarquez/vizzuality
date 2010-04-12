/**
 * 
 */
package com.vizzuality.gmba.process;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Pattern;

/**
 * This will process the export produced by export.sql to calculate the cell Ids
 * The output of this is fed into import.sql which will import and process the content
 * 
 * @author tim
 */
public class ProcessToCells {
	// log statements are made occasionally  
	protected static final int LOOP_LOG_INTERVAL = 100000;
	
	// reuse a pattern for parsing the input lines
	protected static final Pattern tab = Pattern.compile("\t");
	
	/**
	 * 
	 * @param input Source data
	 * @param output Output file to write to
	 * @param latIndex The index in the source data representing the latitude
	 * @param lngIndex The index in the source data representing the longitude
	 * @throws IOException If the output file cannot be written to
	 */
	public int process(File input, File output, int latIndex, int lngIndex, int resourceIdIndex, int nubIdIndex, int borIndex) throws IOException {
		BufferedReader reader = new BufferedReader(new FileReader(input));
		FileWriter writer = new FileWriter(output);
		int recordCount=0;
		try {
			String line = reader.readLine();
			int lineCount=1;
			
			Set<Integer> cells = new HashSet<Integer>();
			
			while (line != null) {
				String[] parts = tab.split(line);
				
				if (parts.length<latIndex
						|| parts.length<lngIndex
						|| parts.length<borIndex
						|| parts.length<nubIdIndex) {
					System.err.println("Invalid number of parts on line ");
				} else {
					try {
						String latString = parts[latIndex];
						String lngString = parts[lngIndex];
						int bor = Integer.parseInt(parts[borIndex]);
						String nubString = parts[nubIdIndex];
						
						int resourceId = Integer.parseInt(parts[resourceIdIndex]);
						
						BigDecimal lat = null;
						if (isNotNull(latString)) {
							lat = new BigDecimal(latString);
						}
						BigDecimal lng = null;
						if (isNotNull(lngString)) {
							lng = new BigDecimal(lngString);
						}
						
						int nubId = -1;
						if (isNotNull(nubString)) {
							nubId = Integer.parseInt(nubString);
						}
						
						
						// check all values are accounted for
						if (lat!=null && lng!=null && nubId>0) {
							lat = lat.add(new BigDecimal(90));
							lng = lng.add(new BigDecimal(180));
							
							// only deal with things in range
							if (lat.intValue()>=0 && lat.intValue()<180
									&& lng.intValue()>=0 && lng.intValue()<360) {
								
								// calc the cell id for the start of the row it lies on
								// 360 x 24 = 8640
								int row = lat.multiply(new BigDecimal(4320)).divide(new BigDecimal(180), BigDecimal.ROUND_DOWN).intValue();
								row = row*8640;
								
								
								// calc the offset in the row
								// 360 x 24 = 8640
								int offset = lng.multiply(new BigDecimal(8640)).divide(new BigDecimal(360), BigDecimal.ROUND_DOWN).intValue();
								
								int cell = row+offset;
								int modcell = cell%8640;
								
								writer.write(cell + "\t" + 
										modcell + "\t" + 
										nubId + "\t" +
										resourceId + "\t" +
										bor + "\n");
								
								cells.add(cell);
								
								recordCount++;
							}
						}
						
					} catch (NumberFormatException e) {
						System.out.println(lineCount + " has bad data: " + line);
					}
				}
				
				if (lineCount%LOOP_LOG_INTERVAL == 0) {
					System.out.println("Processed " + lineCount + ": " + line);
					System.out.println("Cells: " + cells.size());
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
		File fin = new File("/Users/tim/dev/data/spatial/timSpatial.txt");
		File fout = new File("/tmp/timSpatialCells.txt");
		ProcessToCells me = new ProcessToCells();
		try {
			int recordCount = me.process(fin,fout,3,4,2,0,1);
			System.out.println("Records with valid spatial data: " + recordCount);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
