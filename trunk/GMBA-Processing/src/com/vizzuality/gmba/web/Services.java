/**
 * 
 */
package com.vizzuality.gmba.web;

import java.awt.Desktop;
import java.io.IOException;
import java.net.URI;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mortbay.jetty.Server;
import org.mortbay.jetty.webapp.WebAppContext;


/**
 * This is the single general Services class implementing the JSON methods
 * for the client to call.
 * 
 * No Java frameworks are involved in the making of this, to make it both 
 * very fast and simple to extend for non Java developers
 * 
 * @author tim
 */
public class Services extends AbstractServlet {
	/**
	 * Generated 
	 */
	private static final long serialVersionUID = 7422230555858547086L;

	/**
	 * This calls the method mapped by the URL, and returns the response 
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		Connection c = null;
		
		try {
			c = this.getConnection();
			
			if ("/SEARCH".equalsIgnoreCase(req.getPathInfo())) {
				// we throw error if not parsable but otherwise default to null
				resp.getWriter().write(search(c,
						extractInt(req, "taxonId", null, true, true),
						extractInt(req, "minCellId", null, false, true),
						extractInt(req, "maxCellId", null, false, true),
						extractInt(req, "minElevation", null, false, true),
						extractInt(req, "maxElevation", null, false, true),
						extractInt(req, "minRelief", null, false, true),
						extractInt(req, "maxRelief", null, false, true),
						extractInts(req, "tpCode", false, true),
						extractBool(req, "logSql", false)));
			}
			
		} catch (SQLException e) {
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
		resp.getWriter().flush();
	}
	
	/**
	 * Performs the search to determine the number of records to return
	 * @param c To the database
	 * @param taxonId to search for
	 * @param minCellId to limit searches to
	 * @param maxCellId to limit searches to
	 * @param minElevation to limit searches to
	 * @param maxElevationto limit searches to
	 * @param minReliefto limit searches to
	 * @param maxReliefto limit searches to
	 * @param tpCodeto limit searches to
	 * @return The JSON for the search count
	 * @throws SQLException On SQL errors
	 */
	protected String search(Connection c, int taxonId, Integer minCellId, Integer maxCellId, Integer minElevation, 
			Integer maxElevation, Integer minRelief, Integer maxRelief, Integer[] tpCode, boolean logSQL) throws SQLException {
		Statement s = c.createStatement();
		
		// this is a single count for the time being, but this will change to get better statistics
		StringBuffer sb = new StringBuffer("select count(*) from occurrence_density where nub_id=" + taxonId);
		
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
		if (tpCode!=null) {
			sb.append(" and tp_code in(");
			for (int i=0; i<tpCode.length; i++) {
				sb.append(tpCode[i]);
				if (i<tpCode.length-1) {
					sb.append(",");
				}
			}
			sb.append(")");
		}
		
		if (logSQL)
			System.out.println(sb.toString());
		ResultSet rs = s.executeQuery(sb.toString());
		sb.setLength(0);
		sb.append("{count:");
		while (rs.next()) {
			sb.append(rs.getString(1));
		}
		sb.append("}");
		rs.close();
		s.close();
		
		return sb.toString();
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
				Desktop.getDesktop().browse(new URI("http://localhost:7001"));
			} catch (RuntimeException e) {
				// swallow opening issues on the browser.  just for helping dev...
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
