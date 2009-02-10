//
//  GPSClass.h
//  SpeciesLog
//
//  Created by Administrador on 26/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@interface GPSClass:NSObject < CLLocationManagerDelegate >
{
	CLLocationManager *locmanager;
	float lat;
	float lon;
	float accuaracy;
	BOOL  firstTime;
}


-(void) initLocationService;
-(void) startLocation;
-(void)	stopLocation;
-(void) ShowAlert:(NSString*)tittle Text:(NSString*)text;
-(void) ShowAlertWithMaps:(NSString*)tittle Text:(NSString*)text;

@property float lat;
@property float lon;

@end
