/**
 * 
 */
package com.vizzuality.gmba.web;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.impl.GenericObjectPool;

/**
 * This is the base servlet that will set up the database connections, and 
 * handle the method routing
 * 
 * No Java frameworks are involved in the making of this, to make it both 
 * very fast and simple to extend for non Java developers
 * 
 * @author tim
 */
public class AbstractServlet extends HttpServlet {
	/**
	 * Generated 
	 */
	private static final long serialVersionUID = 7471038005738316400L;

	/**
	 * The pool of mysql connections to use
	 * We use 2 pools, to allow for seperation of services vs. downloads
	 */
	protected PoolingDataSource dataSource;
	protected PoolingDataSource dataSource2;
	
	/**
	 * Sets up the connection pool to the database on initialization
	 */
	@Override
	public void init() throws ServletException {
		super.init();
		// enforce mysql
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		GenericObjectPool connectionPool = new GenericObjectPool(null, 25);
		connectionPool.setTestOnBorrow(true);
		ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(getInitParameter("connectURI"), getInitParameter("user"), getInitParameter("password"));
		@SuppressWarnings("unused")
		PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory,connectionPool,null,"select 1",false,true);
		dataSource = new PoolingDataSource(connectionPool);
		
		// repeat for download pool
		GenericObjectPool connectionPool2 = new GenericObjectPool(null, 25);
		connectionPool2.setTestOnBorrow(true);
		ConnectionFactory connectionFactory2 = new DriverManagerConnectionFactory(getInitParameter("connectURI"), getInitParameter("user"), getInitParameter("password"));
		@SuppressWarnings("unused")
		PoolableConnectionFactory poolableConnectionFactory2 = new PoolableConnectionFactory(connectionFactory2,connectionPool2,null,"select 1",false,true);
		dataSource2 = new PoolingDataSource(connectionPool2);		
	}
	
	/**
	 * Warning -  do not forget to close the connections you borrow using connection.close()
	 * which will return then to the pool
	 * @return a new connection
	 * @throws SQLException on error
	 */
	protected Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	
	/**
	 * Warning -  do not forget to close the connections you borrow using connection.close()
	 * which will return then to the pool
	 * @return a new connection
	 * @throws SQLException on error
	 */
	protected Connection getConnection2() throws SQLException {
		return dataSource2.getConnection();
	}
	
	/**
	 * @param req To extract from
	 * @param paramName To extract
	 * @param defaultValue If it is null or can't be made into an Int
	 * @param throwErrorIfNull True to throw error or return the default value if no param found
	 * @param throwErrorIfUnparsable True to throw error or return the default value if not parsable found
	 * @return The value or the default if errors occur
	 * @throws NumberFormatException Only if throw error is true and an issue occurs
	 */
	protected Integer extractInt(HttpServletRequest req, String paramName, Integer defaultValue, boolean throwErrorIfNull, boolean throwErrorIfUnparsable) throws NumberFormatException {
		String s = req.getParameter(paramName);
		if (s != null) {
			try {
				return Integer.parseInt(s);
			} catch (NumberFormatException e) {
				if (throwErrorIfUnparsable) {
					throw e;
				} else {
					return defaultValue;
				}
			}
		}
		if (throwErrorIfNull) {
			throw new NumberFormatException("Cannot create integer for param[" + paramName + "] as no value was in the request");
		} else {
			return defaultValue;
		}
	}

	
	/**
	 * @param req To extract from
	 * @param paramName To extract
	 * @param defaultValue If it is null or can't be made into an BigDecimal
	 * @param throwErrorIfNull True to throw error or return the default value if no param found
	 * @param throwErrorIfUnparsable True to throw error or return the default value if not parsable found
	 * @return The value or the default if errors occur
	 * @throws NumberFormatException Only if throw error is true and an issue occurs
	 */
	protected BigDecimal extractDecimal(HttpServletRequest req, String paramName, BigDecimal defaultValue, boolean throwErrorIfNull, boolean throwErrorIfUnparsable) throws NumberFormatException {
		String s = req.getParameter(paramName);
		if (s != null) {
			try {
				return new BigDecimal(s);
			} catch (NumberFormatException e) {
				if (throwErrorIfUnparsable) {
					System.err.println("Bad decimal:" + s);
					throw e;
				} else {
					return defaultValue;
				}
			}
		}
		if (throwErrorIfNull) {
			throw new NumberFormatException("Cannot create decimal for param[" + paramName + "] as no value was in the request");
		} else {
			return defaultValue;
		}
	}
	
	
	/**
	 * @param req To extract from
	 * @param paramName To extract
	 * @param throwErrorIfNull True if it is a mandatory field 
	 * @return The extracted string
	 * @throws IllegalArgumentException If it is missing and required
	 */
	protected String extractString(HttpServletRequest req, String paramName, boolean throwErrorIfNull) throws IllegalArgumentException {
		String s = req.getParameter(paramName);
		if (s==null && throwErrorIfNull) {
			throw new IllegalArgumentException(paramName + " is a required property but is missing in the request");
		}
		return s;
	}
	
	/**
	 * @param req to extract from
	 * @param paramName to extract
	 * @param throwErrorIfNull true if null triggers an error or the default to return null
	 * @param throwErrorIfUnparsable true if bad data triggers an error, or defaults to null value
	 * @return the integer array
	 * @throws NumberFormatException only errors are to be thrown
	 */
	protected Integer[] extractInts(HttpServletRequest req, String paramName, boolean throwErrorIfNull, boolean throwErrorIfUnparsable) throws NumberFormatException {
		String[] s = req.getParameterValues(paramName);
		if (s != null && s.length>0) {
			Integer[] i = new Integer[s.length];
			for (int x=0; x<s.length; x++) {
				try {
					i[x] = Integer.parseInt(s[x]);
				} catch (NumberFormatException e) {
					if (throwErrorIfUnparsable) {
						throw e;
					} else {
						i[x]=null;
					}
				}
			}
			return i;
		}
		if (throwErrorIfNull) {
			throw new NumberFormatException("Cannot create integer for param[" + paramName + "] as no value was in the request");
		} else {
			return null;
		}
	}
	
	/**
	 * @param req To extract from
	 * @param paramName The param to read
	 * @param defaultValue to use if not found, or not one of y,yes,1,true, t
	 * @return true only if it appears to be true, otherwise defaultValue
	 */
	protected boolean extractBool(HttpServletRequest req, String paramName, boolean defaultValue) {
		String s = req.getParameter(paramName);
		if ("true".equalsIgnoreCase(s)
				|| "t".equalsIgnoreCase(s)
				|| "yes".equalsIgnoreCase(s)
				|| "y".equalsIgnoreCase(s)
				|| "1".equalsIgnoreCase(s)) {
			return true;
		}
		return defaultValue;
	}
}
