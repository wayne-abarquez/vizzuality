/**
 * 
 */
package util;

import java.awt.Point;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.regex.Pattern;

/**
 * Takes the dumpfile of taxon_site and will add all the google tile x,y
 * creating a new taxon_site dump file
 * @author tim
 */
public class TaxonSiteProcess {
	protected static Pattern tab = Pattern.compile("\t");
	/**
	 * @param args InFile OutFile
	 */
	public static void main(String[] args) {
		if (args.length!= 1) {
			System.out.println("Usage: TaxonSiteProcess infile");
		}
		BufferedReader br = null;
		BufferedWriter bw = null;
		long time = System.currentTimeMillis();
		int count = 0;
		try {
			br = new BufferedReader(new FileReader(args[0]));
			bw = new BufferedWriter(new FileWriter(new File(args[0].replaceAll(".txt", "_processed.txt"))));
			
			String line = br.readLine();
			
			while (line != null) {
				// id
				// taxon_id
				// latitude
				// longitude
				// num_occ
				try {
					String[] atoms = tab.split(line);
					
					StringBuffer sb = new StringBuffer();
					sb.append(line);
					
					Double lat = Double.parseDouble(atoms[2]);
					Double lng = Double.parseDouble(atoms[3]);
					for (int zoom=0; zoom<=23; zoom++) {
						Point p = GoogleTileUtil.toTileXY(lat, lng, zoom);
						sb.append("\t");
						sb.append(p.x);
						sb.append("\t");
						sb.append(p.y);
					}
					
					bw.write(sb.toString());
					
					
				} catch (RuntimeException e) {
					System.err.println("Error with line: " + line);
					e.printStackTrace();
				}
				
				count++;
				if (count % 1000 == 0) {
					System.out.println("Processed: " + count);
				}
				line = br.readLine();
				
				if (line != null) {
					bw.write("\n");
				}
				
			}
			bw.flush();
			System.out.println("Finished processing " + count + " records in " + (System.currentTimeMillis() - time) + " msecs");
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			try {
				bw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
