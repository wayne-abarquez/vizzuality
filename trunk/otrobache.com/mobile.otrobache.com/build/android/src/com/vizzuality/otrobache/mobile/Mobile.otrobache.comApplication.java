package com.vizzuality.otrobache.mobile;

import org.appcelerator.titanium.TiApplication;

public class Mobile.otrobache.comApplication extends TiApplication {

	@Override
	public void onCreate() {
		super.onCreate();
		
		appInfo = new Mobile.otrobache.comAppInfo(this);
	}
}
