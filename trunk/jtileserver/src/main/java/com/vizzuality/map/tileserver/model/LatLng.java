/**
 * 
 */
package com.vizzuality.map.tileserver.model;

/**
 * Represents a single pixel cluster keyed on a tile and the taxon
 * represented
 * 
 * @author tim
 */
public class LatLng {
	protected float latitude;
	protected float longitude;
	
	public LatLng() {}

	public float getLatitude() {
		return latitude;
	}

	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}

	public float getLongitude() {
		return longitude;
	}

	public void setLongitude(float longitude) {
		this.longitude = longitude;
	};
	
}
