/**
 * 
 */
package com.vizzuality.map.tileserver;

/**
 * Represents a single pixel cluster keyed on a tile and the taxon
 * represented
 * 
 * @author tim
 */
public class TileCluster {
	protected int zoom;
	protected int tileX; // the tile to render to
	protected int tileY;
	protected int clusterX; // the location of the pixel cluster
	protected int clusterY;
	
	public TileCluster() {};
	public TileCluster(int zoom, int tileX, int tileY, int clusterX, int clusterY) {
		this.zoom = zoom;
		this.tileX = tileX;
		this.tileY = tileY;
		this.clusterX = clusterX;
		this.clusterY = clusterY;
	}
	public int getZoom() {
		return zoom;
	}
	public void setZoom(int zoom) {
		this.zoom = zoom;
	}
	public int getTileX() {
		return tileX;
	}
	public void setTileX(int tileX) {
		this.tileX = tileX;
	}
	public int getTileY() {
		return tileY;
	}
	public void setTileY(int tileY) {
		this.tileY = tileY;
	}
	public int getClusterX() {
		return clusterX;
	}
	public void setClusterX(int clusterX) {
		this.clusterX = clusterX;
	}
	public int getClusterY() {
		return clusterY;
	}
	public void setClusterY(int clusterY) {
		this.clusterY = clusterY;
	}
}
