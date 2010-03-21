package com.vizzuality.otrobache.mobile;

import org.appcelerator.titanium.ITiAppInfo;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.TiProperties;
import org.appcelerator.titanium.util.Log;

/* GENERATED CODE
 * Warning - this class was generated from your application's tiapp.xml
 * Any changes you make here will be overwritten
 */
public class Mobile.otrobache.comAppInfo implements ITiAppInfo
{
	private static final String LCAT = "AppInfo";
	
	public Mobile.otrobache.comAppInfo(TiApplication app) {
		TiProperties properties = app.getAppProperties();
					
		properties.setString("ti.deploytype", "development");
	}
	
	public String getId() {
		return "com.vizzuality.otrobache.mobile";
	}
	
	public String getName() {
		return "mobile.otrobache.com";
	}
	
	public String getVersion() {
		return "1.0";
	}
	
	public String getPublisher() {
		return "Vizzuality";
	}
	
	public String getUrl() {
		return "http://www.vizzuality.com";
	}
	
	public String getCopyright() {
		return "2010 Vizzuality";
	}
	
	public String getDescription() {
		return "otrobache.com report app";
	}
	
	public String getIcon() {
		return "default_app_logo.png";
	}
	
	public boolean isAnalyticsEnabled() {
		return false;
	}
	
	public String getGUID() {
		return "ea34ab7b-1833-46c2-b671-b616d2ce1162";
	}
}
