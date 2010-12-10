/**
 * 
 */
package com.vizzuality.map.tileserver.service.impl;

import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.vizzuality.map.tileserver.model.LatLng;
import com.vizzuality.map.tileserver.model.TileCluster;
import com.vizzuality.map.tileserver.service.TileManager;
import com.vizzuality.map.tileserver.util.GoogleTileUtil;


/**
 * @author timrobertson
 *
 */
public class TileManagerImpl extends BaseManager implements TileManager {
	protected static int zoomLookAhead = 6; // force points to go to 4x4 pixels
	
	@Override
	public Collection<TileCluster> get(int tileX, int tileY, int zoom) {
		// mock some lat lng data
		/*
		List<Float[]> data = new LinkedList<Float[]>();
		for (int lng=-179; lng<180; lng+=10) {
			for (int lat=-85; lat<85; lat+=10) {
				data.add(new Float[]{new Float(lat), new Float(lng)});
			}
		}
		
		List<TileCluster> tile = new LinkedList<TileCluster>();
		int z = zoom+6;
		z = (z>23)?23:z;
		for (Float[] f : data) {
			int x = GoogleTileUtil.toTileX(f[1], z);
			int y = GoogleTileUtil.toTileY(f[0], z);
			tile.add(new TileCluster(zoom, tileX, tileY, x, y));
		}
		
		return tile;
		*/
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("tileX", tileX);
		params.put("tileY", tileY);
		params.put("zoom", zoom);
		List<LatLng> points = list(LatLng.class, TileCluster.class.getName() +".list", params);
		List<TileCluster> tile = new LinkedList<TileCluster>();
		int z = zoom+6;
		z = (z>23)?23:z;
		for (LatLng ll : points) {
			int x = GoogleTileUtil.toTileX(ll.getLongitude(), z);
			int y = GoogleTileUtil.toTileY(ll.getLatitude(), z);
			tile.add(new TileCluster(zoom, tileX, tileY, x, y));
		}
		
		return tile;
	}
}
