/**
 * 
 */
package com.vizzuality.map.tileserver.service;

import java.util.Collection;

import com.vizzuality.map.tileserver.model.TileCluster;

/**
 * @author timrobertson
 */
public interface TileManager {
	public Collection<TileCluster> get(int tileX, int tileY, int zoom);
}
