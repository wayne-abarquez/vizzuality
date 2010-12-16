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

public class ManagerOld {
	protected GlobalMercator gm = new GlobalMercator();
	protected PoolingDataSource dataSource;
	
	public ManagerOld() {
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
	
	public List<TileCluster> get(int tileX, int tileY, int zoom) {
		List<TileCluster> tiles = new LinkedList<TileCluster>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rset = null;		
		try {
			long ts = System.currentTimeMillis();
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			rset = stmt.executeQuery("select y(the_geom) as latitude,x(the_geom) as longitude from points9 where the_geom && v_get_tile("+tileX+","+tileY+","+zoom+") group by latitude, longitude");
			ts = ts("QueryTime: ", ts);
			
			while(rset.next()) {
				int[] pix = gm.MetersToPixels(rset.getDouble("longitude"), rset.getDouble("latitude"), zoom);
				tiles.add(new TileCluster(zoom, tileX, tileY, pix[0]%256, 256-(pix[1]%256)));
			}
			ts = ts("BuildTime: ", ts);
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
            try { if (rset != null) rset.close(); } catch(Exception e) { }
            try { if (stmt != null) stmt.close(); } catch(Exception e) { }
            try { if (conn != null) conn.close(); } catch(Exception e) { }		
        }

		return tiles;
	}
	
	
	public List<TileCluster> getMock(int tileX, int tileY, int zoom) {
		// mock some lat lng data
		
		List<Double[]> data = new LinkedList<Double[]>();
		data.add(new Double[]{Double.parseDouble("2282662.11513993"),Double.parseDouble("-1828746.43116984")});
		data.add(new Double[]{Double.parseDouble("1706238.31515968"),Double.parseDouble("-1630578.12862497")});
		data.add(new Double[]{Double.parseDouble("1571015.27474036"),Double.parseDouble("-1847369.01376138")});
		data.add(new Double[]{Double.parseDouble("1687088.91564221"),Double.parseDouble("-1699896.6914234")});
		data.add(new Double[]{Double.parseDouble("1348165.0186833"),Double.parseDouble("-1550465.08748143")});
		data.add(new Double[]{Double.parseDouble("1625043.20805021"),Double.parseDouble("-1667513.98408663")});
		data.add(new Double[]{Double.parseDouble("1253234.82805657"),Double.parseDouble("-1795354.71961713")});
		data.add(new Double[]{Double.parseDouble("1765924.89092801"),Double.parseDouble("-1559988.34614384")});
		data.add(new Double[]{Double.parseDouble("1290656.65587947"),Double.parseDouble("-1778384.64514907")});
		data.add(new Double[]{Double.parseDouble("1379362.50252984"),Double.parseDouble("-1802506.63995095")});
		data.add(new Double[]{Double.parseDouble("1577861.68929678"),Double.parseDouble("-1533845.11571706")});
		data.add(new Double[]{Double.parseDouble("1574686.360971"),Double.parseDouble("-1572284.54659235")});
		data.add(new Double[]{Double.parseDouble("1682115.80690742"),Double.parseDouble("-1610013.053048")});
		data.add(new Double[]{Double.parseDouble("1590004.90970994"),Double.parseDouble("-1427355.40650752")});
		data.add(new Double[]{Double.parseDouble("1334973.78289835"),Double.parseDouble("-1589569.13836656")});
		data.add(new Double[]{Double.parseDouble("1411946.92760216"),Double.parseDouble("-1477765.23797687")});
		data.add(new Double[]{Double.parseDouble("1493365.16076771"),Double.parseDouble("-1682962.05588661")});
		data.add(new Double[]{Double.parseDouble("1460871.34384229"),Double.parseDouble("-1451963.5588764")});
		data.add(new Double[]{Double.parseDouble("1662558.55333959"),Double.parseDouble("-1683666.37494758")});
		data.add(new Double[]{Double.parseDouble("1253234.26066401"),Double.parseDouble("-1795357.66284728")});
		data.add(new Double[]{Double.parseDouble("1548141.51840877"),Double.parseDouble("-1861726.68102047")});
		data.add(new Double[]{Double.parseDouble("1798636.2443924"),Double.parseDouble("-1790422.15083659")});
		data.add(new Double[]{Double.parseDouble("1823603.91106933"),Double.parseDouble("-1715332.81006711")});
		data.add(new Double[]{Double.parseDouble("1636536.99375442"),Double.parseDouble("-1719738.01406034")});
		data.add(new Double[]{Double.parseDouble("1793227.27808256"),Double.parseDouble("-1854568.80171009")});
		data.add(new Double[]{Double.parseDouble("1736977.87310709"),Double.parseDouble("-1650150.155643")});
		data.add(new Double[]{Double.parseDouble("1766941.15615387"),Double.parseDouble("-1655166.74173823")});
		data.add(new Double[]{Double.parseDouble("1314493.41385167"),Double.parseDouble("-1466248.7356105")});
		data.add(new Double[]{Double.parseDouble("1662408.8941045"),Double.parseDouble("-1617588.36361855")});
		data.add(new Double[]{Double.parseDouble("1255253.61602974"),Double.parseDouble("-1681483.16651516")});
		data.add(new Double[]{Double.parseDouble("1294467.24332082"),Double.parseDouble("-1687244.41749658")});
		data.add(new Double[]{Double.parseDouble("2282654.44458988"),Double.parseDouble("-1828686.65620714")});
		data.add(new Double[]{Double.parseDouble("1485365.09858662"),Double.parseDouble("-1655518.26338116")});
		data.add(new Double[]{Double.parseDouble("1701942.78045093"),Double.parseDouble("-1672234.04637298")});
		data.add(new Double[]{Double.parseDouble("1512114.60878003"),Double.parseDouble("-1473407.42547884")});
		data.add(new Double[]{Double.parseDouble("1572105.07513718"),Double.parseDouble("-1600095.56609586")});
		data.add(new Double[]{Double.parseDouble("1312623.80460483"),Double.parseDouble("-1673063.76952594")});
		data.add(new Double[]{Double.parseDouble("1363893.26052049"),Double.parseDouble("-1469527.49512607")});
		data.add(new Double[]{Double.parseDouble("1727375.89421692"),Double.parseDouble("-1601435.62155351")});
		data.add(new Double[]{Double.parseDouble("1309704.50346617"),Double.parseDouble("-1602417.88190527")});
		data.add(new Double[]{Double.parseDouble("1606485.13741741"),Double.parseDouble("-1590925.26452636")});
		data.add(new Double[]{Double.parseDouble("1833244.81625386"),Double.parseDouble("-1783474.27912761")});
		data.add(new Double[]{Double.parseDouble("1375688.39261772"),Double.parseDouble("-1780293.13222534")});
		data.add(new Double[]{Double.parseDouble("1702715.9209542"),Double.parseDouble("-1748980.25461656")});
		data.add(new Double[]{Double.parseDouble("1672330.36387189"),Double.parseDouble("-1549204.98133336")});
		data.add(new Double[]{Double.parseDouble("1315757.69429056"),Double.parseDouble("-1677429.49536806")});
		data.add(new Double[]{Double.parseDouble("1796099.16956746"),Double.parseDouble("-1680072.00564704")});
		data.add(new Double[]{Double.parseDouble("1760879.47493193"),Double.parseDouble("-1621982.66451645")});
		
		List<TileCluster> tiles = new LinkedList<TileCluster>();
		GlobalMercator gm = new GlobalMercator();
		for (Double[] ll : data) {
			int[] pix = gm.MetersToPixels(ll[1], ll[0], zoom);
			//System.out.println("pix["+pix[0] + "," + pix[1]+"], tile["+pix[0]%256 + "," + pix[1]%256+"]");
			tiles.add(new TileCluster(zoom, tileX, tileY, pix[0]%256, 256-(pix[1]%256)));
		}
		return tiles;
		
		/*
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("tileX", tileX);
		params.put("tileY", tileY);
		params.put("zoom", zoom);
		List<LatLng> points = list(LatLng.class, TileCluster.class.getName() +".list", params);
		List<TileCluster> tiles = new LinkedList<TileCluster>();
		
		for (LatLng ll : points) {
			int[] pix = gm.MetersToPixels(ll.getLongitude(), ll.getLatitude(), zoom);
			tiles.add(new TileCluster(zoom, tileX, tileY, pix[0]%256, 256-(pix[1]%256)));
		}
		
		return tiles;
		*/
	}
	
	public long ts(String message, long last) {
		System.out.println(message + ": " + (System.currentTimeMillis() - last));
		return System.currentTimeMillis();
	}
	
}
