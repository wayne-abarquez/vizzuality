package com.vizzuality.map.tileserver;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;
import java.util.Properties;

import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.ObjectPool;
import org.apache.commons.pool.impl.GenericObjectPool;

public class Manager {
	protected GlobalMercator gm = new GlobalMercator();
	protected PoolingDataSource dataSource;
	
	public Manager() {
		try {
			Class.forName("org.postgresql.Driver");
		} catch (ClassNotFoundException e) {
		}
		
		GenericObjectPool connectionPool = new GenericObjectPool();
		connectionPool.setMaxActive(25);
		connectionPool.setMaxIdle(25);
		connectionPool.setMinIdle(10);
		Properties props = new Properties();
		props.setProperty("Username", "postgres");
		props.setProperty("Password", "");
		ConnectionFactory connectionFactory = new DriverConnectionFactory(new org.postgresql.Driver(),"jdbc:postgresql://localhost/tiledb?compatible=7.2",props);
		PoolableConnectionFactory poolableConnectionFactory = new PoolableConnectionFactory(connectionFactory,connectionPool,null,null,false,true);
		dataSource = new PoolingDataSource(connectionPool);
	}
	
	public void get(int tileX, int tileY, int zoom, int[] rasterData) {
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;		
		try {
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			rset = stmt.executeQuery("select y(the_geom) as latitude,x(the_geom) as longitude from points9 where the_geom && v_get_tile("+tileX+","+tileY+","+zoom+") group by latitude, longitude");

			
			while(rset.next()) {
				int[] pix = gm.MetersToPixels(rset.getDouble("longitude"), rset.getDouble("latitude"), zoom);
				int x = pix[0];
				int y = pix[1];
				//draw the cells
				try {
					
					// center cell
					rasterData[x + (256*y)] = 0xFFFF6666;
					
					// 5x5 box around the center
					for (int i=x-2; i<=x+2; i++) {
						for (int j=y-2; j<=y+2; j++) {
							draw(rasterData, 0xFFFF6666, i + (256*j));
						}
					}
					
					// black perimeter
					draw(rasterData, 0xFF000000, x-4 + (256*(y-1)));
					draw(rasterData, 0xFF000000, x-4 + (256*(y)));
					draw(rasterData, 0xFF000000, x-4 + (256*(y+1)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y-1)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y)));
					draw(rasterData, 0xFF000000, x+4 + (256*(y+1)));
					draw(rasterData, 0xFF000000, x-1 + (256*(y-4)));
					draw(rasterData, 0xFF000000, x + (256*(y-4)));
					draw(rasterData, 0xFF000000, x+1 + (256*(y-4)));
					draw(rasterData, 0xFF000000, x-1 + (256*(y+4)));
					draw(rasterData, 0xFF000000, x + (256*(y+4)));
					draw(rasterData, 0xFF000000, x+1 + (256*(y+4)));					
					
					// corner
					draw(rasterData, 0xFF000000, x-3 + (256*(y-3)));
					draw(rasterData, 0xFF000000, x+3 + (256*(y-3)));
					draw(rasterData, 0xFF000000, x-3 + (256*(y+3)));
					draw(rasterData, 0xFF000000, x+3 + (256*(y+3)));
					// rounded edge of black perimeter
					draw(rasterData, 0xFF1A1A1A, x-4 + (256*(y-2)));
					draw(rasterData, 0xFF1A1A1A, x-2 + (256*(y-4)));
					draw(rasterData, 0xFF1A1A1A, x+2 + (256*(y-4)));
					draw(rasterData, 0xFF1A1A1A, x+4 + (256*(y-2)));
					draw(rasterData, 0xFF1A1A1A, x+4 + (256*(y+2)));
					draw(rasterData, 0xFF1A1A1A, x+2 + (256*(y+4)));
					draw(rasterData, 0xFF1A1A1A, x-2 + (256*(y+4)));
					draw(rasterData, 0xFF1A1A1A, x-4 + (256*(y+2)));
					
					// between center and perimeter
					draw(rasterData, 0xFF552222, x-2 + (256*(y-3)));
					draw(rasterData, 0xFFAA4444, x-1 + (256*(y-3)));
					draw(rasterData, 0xFFCC5555, x + (256*(y-3)));
					draw(rasterData, 0xFFAA4444, x+1 + (256*(y-3)));
					draw(rasterData, 0xFF552222, x+2 + (256*(y-3)));
					draw(rasterData, 0xFF552222, x-2 + (256*(y+3)));
					draw(rasterData, 0xFFAA4444, x-1 + (256*(y+3)));
					draw(rasterData, 0xFFCC5555, x + (256*(y+3)));
					draw(rasterData, 0xFFAA4444, x+1 + (256*(y+3)));
					draw(rasterData, 0xFF552222, x+2 + (256*(y+3)));
					draw(rasterData, 0xFF552222, x-3 + (256*(y-2)));
					draw(rasterData, 0xFFAA4444, x-3 + (256*(y-1)));
					draw(rasterData, 0xFFCC5555, x-3 + (256*(y)));
					draw(rasterData, 0xFFAA4444, x-3 + (256*(y+1)));
					draw(rasterData, 0xFF552222, x-3 + (256*(y+2)));
					draw(rasterData, 0xFF552222, x+3 + (256*(y-2)));
					draw(rasterData, 0xFFAA4444, x+3 + (256*(y-1)));
					draw(rasterData, 0xFFCC5555, x+3 + (256*(y)));
					draw(rasterData, 0xFFAA4444, x+3 + (256*(y+1)));
					draw(rasterData, 0xFF552222, x+3 + (256*(y+2)));

					
				} catch (RuntimeException e) {
				}				
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
            try { if (rset != null) rset.close(); } catch(Exception e) { }
            try { if (stmt != null) stmt.close(); } catch(Exception e) { }
            try { if (conn != null) conn.close(); } catch(Exception e) { }		
        }
	}
	
	private void draw(int[] rasterData, int col, int index) {
		try {
			if (index>=0 && index<rasterData.length)
				rasterData[index] = col;
		} catch (RuntimeException e) {
		}
	}	
}
