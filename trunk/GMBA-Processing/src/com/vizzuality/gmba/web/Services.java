/**
 * 
 */
package com.vizzuality.gmba.web;

import java.awt.Desktop;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URI;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.jetty.Server;
import org.mortbay.jetty.webapp.WebAppContext;

/**
 * This is the single general Services class implementing the JSON methods
 * for the client to call.
 * 
 * No Java web frameworks are involved in the making of this, to make it both 
 * very fast and simple to extend for non Java developers
 * 
 * @author tim
 */
public class Services extends AbstractServlet {
	/**
	 * Generated 
	 */
	private static final long serialVersionUID = 7422230555858547086L;
	
	// the directory where downloads will be stored
	private String downloadDirectory;
	private String downloadPath;
	
	// the job-id to start from
	static int job = 0;
	
	@Override
	public void init() throws ServletException {
		super.init();
		downloadDirectory = getServletContext().getRealPath("/")+"/" + getInitParameter("downloadDirectory");
		downloadPath = getInitParameter("downloadDirectory");
		
		File f = new File(downloadDirectory);
		if (!f.exists()) {
			f.mkdirs();
		}
		
		// now scan any existing jobs to restart numbering
		FilenameFilter filter = new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				if (name.startsWith("job-")) return true;
				return false;
			}
		};
		String[] names = f.list(filter);
		for (String n : names) {
			// the first 4 chars are job-
			int pointIndex = n.indexOf(".");
			if (pointIndex>0) {
				String s = n.substring(4, pointIndex);
				//System.out.println(n + " -> " + s);
				try {
					int j = Integer.parseInt(s) + 1;
					if (job<j) {
						job = j;
					}
				} catch (NumberFormatException e) {
					System.err.println("Appears there are bad files in the download directory. Cannot extract job number from[" + n + "].  Expected (e.g.) [job-1.zip, job-1.done, job-1.error]");
				}
			}
		}
		System.out.println("Starting job index at: " + job);
	}

	/**
	 * This calls the method mapped by the URL, and returns the response 
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
			
			if ("/SEARCH".equalsIgnoreCase(req.getPathInfo())) {
				Connection c = null;
				
				try {
					c = this.getConnection();
				
					// we throw error if not parsable but otherwise default to null
					BigDecimal minLat = extractDecimal(req, "minLatitude", null, false, true);
					BigDecimal maxLat = extractDecimal(req, "maxLatitude", null, false, true);
					BigDecimal minLng = extractDecimal(req, "minLongitude", null, false, true);
					BigDecimal maxLng = extractDecimal(req, "maxLongitude", null, false, true);
					
					Integer minCellId = null;
					Integer maxCellId = null;
					if (minLat!=null && minLng!=null) {
						minCellId = toCell(minLat, minLng, null);
					}
					if (maxLat!=null && maxLng!=null) {
						maxCellId = toCell(maxLat, maxLng, null);
					}
					
					// we throw error if not parsable but otherwise default to null
					resp.getWriter().write(search(c,
							extractInt(req, "taxonId", new Integer(0), false, true),
							minCellId,
							maxCellId,
							extractInt(req, "minElevation", null, false, true),
							extractInt(req, "maxElevation", null, false, true),
							extractInt(req, "minRelief", null, false, true),
							extractInt(req, "maxRelief", null, false, true),
							extractInts(req, "tvzCode", false, true),
							extractBool(req, "logSql", false)));
				} catch (Exception e) {
					resp.getWriter().write("An error has occured: <br/>");
					e.printStackTrace(resp.getWriter());
				} finally {
					try {
						c.close();
					} catch (Exception e) {
						// proper hosed!
						e.printStackTrace();
					}
				}
			}
			
			if ("/DOWNLOAD".equalsIgnoreCase(req.getPathInfo())) {
				try {
					Connection c = this.getConnection2();

					// we throw error if not parsable but otherwise default to null
					BigDecimal minLat = extractDecimal(req, "minLatitude", null, false, true);
					BigDecimal maxLat = extractDecimal(req, "maxLatitude", null, false, true);
					BigDecimal minLng = extractDecimal(req, "minLongitude", null, false, true);
					BigDecimal maxLng = extractDecimal(req, "maxLongitude", null, false, true);
					
					Integer minCellId = null;
					Integer maxCellId = null;
					if (minLat!=null && minLng!=null) {
						minCellId = toCell(minLat, minLng, null);
					}
					if (maxLat!=null && maxLng!=null) {
						maxCellId = toCell(maxLat, maxLng, null);
					}
					
					// we throw error if not parsable but otherwise default to null
					resp.getWriter().write(download(c,
							extractInt(req, "taxonId", null, false, true),
							extractString(req, "rank", false),
							minCellId,
							maxCellId,
							extractInt(req, "minElevation", null, false, true),
							extractInt(req, "maxElevation", null, false, true),
							extractInt(req, "minRelief", null, false, true),
							extractInt(req, "maxRelief", null, false, true),
							extractInts(req, "tvzCode", false, true),
							extractBool(req, "logSql", false)));
					
					// note that the connection is NOT closed!
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			
			if ("/POLL".equalsIgnoreCase(req.getPathInfo())) {
				String job = extractString(req, "jobId", true);
				File f = new File(downloadDirectory+"/job-"+job+".done");
				if (!f.exists()) {
					resp.getWriter().write("{\"status\":\"notReady\"}");
				} else if (f.length()!=0) {
					resp.getWriter().write("{\"status\":\"downloadFailed\", \"url\":\"/" +downloadPath + "/job-"+ job +  ".error\"}");
				} else {
					resp.getWriter().write("{\"status\":\"complete\", \"url\":\"/" +downloadPath + "/job-"+ job +  ".zip\"}");
				}
			}
			
		resp.getWriter().flush();
	}
	
	/**
	 * @param lat To use
	 * @param lng To use
	 * @param defaultValue To use if outside of range
	 * @return The cell Id for the lat lng pair
	 */
	private Integer toCell(BigDecimal lat, BigDecimal lng, Integer defaultValue) {
		lat = lat.add(new BigDecimal(90));
		lng = lng.add(new BigDecimal(180));
		
		// only deal with things in range
		if (lat.intValue()>=0 && lat.intValue()<=180
				&& lng.intValue()>=0 && lng.intValue()<=360) {
			
			// calc the cell id for the start of the row it lies on
			// 360 x 24 = 8640
			int row = lat.multiply(new BigDecimal(4320)).divide(new BigDecimal(180), BigDecimal.ROUND_DOWN).intValue();
			row = row*8640;
			
			
			// calc the offset in the row
			// 360 x 24 = 8640
			int offset = lng.multiply(new BigDecimal(8640)).divide(new BigDecimal(360), BigDecimal.ROUND_DOWN).intValue();
			
			int cell = row+offset;
			return cell;
		}
		System.err.println("Latitude[" + lat.subtract(new BigDecimal(90)) + "] or Longitude[" + lng.subtract(new BigDecimal(180)) + "] is outside range.  Ignoring...");
		return defaultValue;
	}

	/**
	 * Performs the search to determine the number of records to return
	 * @param c To the database
	 * @param taxonId to search for
	 * @param minCellId to limit searches to
	 * @param maxCellId to limit searches to
	 * @param minElevation to limit searches to
	 * @param maxElevation to limit searches to
	 * @param minRelief to limit searches to
	 * @param maxRelief to limit searches to
	 * @param tvzCode to limit searches to
	 * @return The JSON for the search count
	 * Each record is around 500bytes
	 * @throws SQLException On SQL errors
	 */
	protected String search(Connection c, Integer taxonId, Integer minCellId, Integer maxCellId, Integer minElevation, 
			Integer maxElevation, Integer minRelief, Integer maxRelief, Integer[] tvzCode, boolean logSQL) throws SQLException {
		StringBuffer sb = new StringBuffer("from occurrence_density where nub_id=" + taxonId);
				
		if (minCellId!=null) {
			// use the mod hack to limit results
			sb.append(" and cell_id>=" + minCellId);
			sb.append(" and mod_cell_id>=" + minCellId%8640);
		}
		if (maxCellId!=null) {
			// use the mod hack to limit results
			sb.append(" and cell_id<=" + maxCellId);
			sb.append(" and mod_cell_id<=" + maxCellId%8640);
		}
		if (minElevation!=null) {
			sb.append(" and elevation>=" + minElevation);
		}
		if (maxElevation!=null) {
			sb.append(" and elevation<=" + maxElevation);
		}
		if (minRelief!=null) {
			sb.append(" and relief>=" + minRelief);
		}
		if (maxRelief!=null) {
			sb.append(" and relief<=" + maxRelief);
		}
		if (tvzCode!=null) {
			sb.append(" and tvzcode in(");
			for (int i=0; i<tvzCode.length; i++) {
				sb.append(tvzCode[i]);
				if (i<tvzCode.length-1) {
					sb.append(",");
				}
			}
			sb.append(")");
		}
		
		StringBuffer result = new StringBuffer();
		result.append("{");
		
		// add number of basis_of_record
		// 1=observtion
		// 2=specimen
		String sql = "select sum(count) "  + sb.toString();
		addCount(c, logSQL, result, sql, "\"total\":");
		result.append(",");
		sql = "select sum(count) "  + sb.toString() + " and basis_of_record=1";
		addCount(c, logSQL, result, sql, "\"observation\":");
		result.append(",");
		sql = "select sum(count) "  + sb.toString() + " and basis_of_record=2";
		addCount(c, logSQL, result, sql, "\"specimen\":");
		result.append(",");
		sql = "select count(distinct resource_id) "  + sb.toString();
		addCount(c, logSQL, result, sql, "\"resources\":");
		result.append("}");
		
		return result.toString();
	}

	// add a count to the results
	private void addCount(Connection c, boolean logSQL, StringBuffer result,
			String sql, String prefix) throws SQLException {
		Statement s = c.createStatement();
		if (logSQL) System.out.println(sql);
		ResultSet rs = s.executeQuery(sql);
		result.append(prefix);
		while (rs.next()) {
			if (rs.getString(1) == null) {
				result.append("0");
			} else {
				result.append(rs.getString(1));
			}
		}
		rs.close();
		s.close();
	}
	
	/**
	 * Performs the download
	 * @param c To the database
	 * @param nubId to search for
	 * @param taxonId to search for
	 * @param rank the rank at which the taxonId is (kingdom, phylum etc) 
	 * @param minCellId to limit searches to
	 * @param maxCellId to limit searches to
	 * @param minElevation to limit searches to
	 * @param maxElevation to limit searches to
	 * @param minRelief to limit searches to
	 * @param maxRelief to limit searches to
	 * @param tvzCode to limit searches to
	 * @return The JSON for the search count
	 * @throws SQLException On SQL errors
	 */
	
	protected String download(Connection c, Integer taxonId, String rank, Integer minCellId, Integer maxCellId, Integer minElevation, 
			Integer maxElevation, Integer minRelief, Integer maxRelief, Integer[] tvzCode, boolean logSQL) throws IOException {
			
		
		StringBuffer sb = new StringBuffer("select * from occurrence_download where ");
		boolean first = true;
		if (taxonId!=null) {
			if ("KINGDOM".equalsIgnoreCase(rank)) {
				sb.append(" kingdom_concept_id=" + taxonId);
			} else if ("PHYLUM".equalsIgnoreCase(rank)) {
				sb.append(" phylum_concept_id=" + taxonId);
			} else if ("CLASS".equalsIgnoreCase(rank)) {
				sb.append(" class_concept_id=" + taxonId);
			} else if ("ORDER".equalsIgnoreCase(rank)) {
				sb.append(" order_concept_id=" + taxonId);
			} else if ("FAMILY".equalsIgnoreCase(rank)) {
				sb.append(" family_concept_id=" + taxonId);
			} else if ("GENUS".equalsIgnoreCase(rank)) {
				sb.append(" genus_concept_id=" + taxonId);
			} else if ("SPECIES".equalsIgnoreCase(rank)) {
				sb.append(" species_concept_id=" + taxonId);
			} else {
				sb.append(" nub_concept_id=" + taxonId);
			}
			first=false;
		}
				
		if (minCellId!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			// use the mod hack to limit results
			sb.append(" cell_id>=" + minCellId);
			sb.append(" and mod_cell_id>=" + minCellId%8640);
		}
		if (maxCellId!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			// use the mod hack to limit results
			sb.append(" cell_id<=" + maxCellId);
			sb.append(" and mod_cell_id<=" + maxCellId%8640);
		}
		if (minElevation!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			sb.append(" elevation>=" + minElevation);
		}
		if (maxElevation!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			sb.append(" elevation<=" + maxElevation);
		}
		if (minRelief!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			sb.append(" relief>=" + minRelief);
		}
		if (maxRelief!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			sb.append(" relief<=" + maxRelief);
		}
		if (tvzCode!=null) {
			if (!first) {
				sb.append(" and ");
				first=false;
			}
			sb.append(" tvzcode in(");
			for (int i=0; i<tvzCode.length; i++) {
				sb.append(tvzCode[i]);
				if (i<tvzCode.length-1) {
					sb.append(",");
				}
			}
			sb.append(")");
		}
		
		if (logSQL)
			System.out.println(sb.toString());
		Download d = new Download(sb.toString(), c, downloadDirectory + "/job-" + job + ".txt", downloadDirectory + "/job-" + job + ".done");
		
		Thread t = new Thread(d);
		t.start();
		
		return "{\"url\": \"/service/poll?jobId=" + job++ + "\"}";
	}	
	
	// utility class to write the download 
	class Download implements Runnable {
		String sql;
		Connection c;
		String output;
		String lockFile;
		
		public Download(String sql, Connection c, String output,String lockFile) {
			this.sql = sql;
			this.c = c;
			this.output = output;
			this.lockFile = lockFile;
		}



		@Override
		public void run() {
			// we create a line by line only reading query
			try {
				Statement s = c.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_READ_ONLY);
				s.setFetchSize(Integer.MIN_VALUE);
				ResultSet rs = s.executeQuery(sql);
				ResultSetMetaData metaData = rs.getMetaData();
				int columns = metaData.getColumnCount();		
				
				BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(output),"UTF-8"));
				
				while (rs.next()) {
					for (int i=1; i<=columns; i++) {
						Object o = rs.getObject(i);
						if (o!=null) {
							writer.write(o.toString());
						} 
							
						writer.write("\t");
					}
					writer.write("\n");
				}
				rs.close();
				s.close();
				writer.flush();
				writer.close();
				
				// now zip the file
				ZipOutputStream out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(output.replaceAll(".txt", ".zip"))));
				byte data[] = new byte[2048];
				BufferedInputStream in = new BufferedInputStream(new FileInputStream(output));
				ZipEntry entry = new ZipEntry("results.txt");
				out.putNextEntry(entry);
				int count;
	            while((count = in.read(data, 0, 2048)) != -1) {
	               out.write(data, 0, count);
	            }
	            in.close();
	            out.flush();
	            out.close();
				
				File f = new File(lockFile);
				if (!f.exists()) {
					f.createNewFile();
				}
			} catch (Exception e) { // write exception to the job file
				File f = new File(lockFile.replaceAll("done", "error"));
				if (!f.exists()) {
					try {
						f.createNewFile();
						PrintWriter w = new PrintWriter(f);
						e.printStackTrace(w);
						w.flush();
						w.close();
						
					} catch (IOException e1) {
						e1.printStackTrace();
					}
				}
				System.err.println("Error with running job for SQL: " + sql);
				e.printStackTrace();
				
			} finally {
				try {
					c.close();
				} catch (Exception e) {
					// proper hosed!
					e.printStackTrace();
				}				
			}
		}
	}
	
	
	/**
	 * Utility to launch the application during development
	 */
	public static void main(String[] args) {
		Server server = new Server(Integer.parseInt(args[0]));
		WebAppContext webapp = new WebAppContext("webapp", "/");
		server.setHandler(webapp);
		try {
			server.start();
			try {
				Desktop.getDesktop().browse(new URI("http://localhost:" + args[0]));
//				Desktop.getDesktop().browse(new URI("http://localhost:7001/service/download?taxonId=14706247&minElevation=6000&logSql=true"));
				
			} catch (RuntimeException e) {
				// swallow opening issues on the browser.  just for helping dev...
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
