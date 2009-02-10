//
//  GPSClass.m
//  SpeciesLog
//
//  Created by Administrador on 26/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "GPSClass.h"


@implementation GPSClass

@synthesize lat;
@synthesize lon;

-(void) initLocationService
{
	printf("inicializando GPS");
	locmanager = [[CLLocationManager alloc] init];
	[locmanager setDelegate:self];
	[locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
	[locmanager setDistanceFilter:100];
	firstTime=YES;
	if (![locmanager locationServicesEnabled])
	{
		printf("NO LOCATIONXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
		[self ShowAlert:@"GPS" Text:@"Service Not Enable"];
		self.lat=0.0f;
		self.lon=0.0f;
	}
	else 
		printf("SI LOACIONXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
	
	
	
}
-(void) startLocation
{
	printf("\nSTART LOCATION");
	[locmanager startUpdatingLocation];
}
-(void) stopLocation
{
	[locmanager stopUpdatingLocation];	
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	NSDate* eventDate =  newLocation.timestamp;
	NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	printf("\nEN LA CALLBACK DEL GPS");
	
	if(abs(howRecent)<5.0 )
	{
		printf("\nacuaracy Horizontal:%f",newLocation.horizontalAccuracy);
		
		if(firstTime==YES)
		{			
			lat=newLocation.coordinate.latitude;
			lon=newLocation.coordinate.longitude;
			accuaracy=newLocation.horizontalAccuracy;
			printf("\nFIRST TIME lat:%f lon:%f acu:%f",lat,lon,accuaracy);
			firstTime=NO;
		}
		else if( newLocation.horizontalAccuracy<accuaracy)
		{
			lat=newLocation.coordinate.latitude;
			lon=newLocation.coordinate.longitude;
			accuaracy=newLocation.horizontalAccuracy;
			printf("\nNEW BEST LOCATION lat:%f lon:%f acu:%f",lat,lon,accuaracy);
			//[self ShowAlert:@"BEST ACCUARACY" Text:[NSString stringWithFormat:@"%f",accuaracy]];
		}
		
		/*NO QUEREMOS PARAR, SINO QUE NOS DE LA MEJOR, Y  A SU VEZ 
		 [self ShowAlert:@"Last Photo Coordinates" Text:[NSString stringWithFormat: @"lat:%f\nlon:%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude]];
		 
		//[locmanager stopUpdatingLocation];	
		
		NSNumber *numero=[[NSNumber alloc]initWithDouble:newLocation.coordinate.latitude];
		[[NSUserDefaults standardUserDefaults] setObject:numero forKey:@"lastLatitude"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		numero=[[NSNumber alloc]initWithDouble:newLocation.coordinate.longitude];
		[[NSUserDefaults standardUserDefaults] setObject:numero forKey:@"lastLongitude"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		 */
	}
	
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	[self ShowAlert:@"GPS Error" Text:@"Not Signal"];
	
}

-(void) ShowAlert:(NSString*)tittle Text:(NSString*)text
{
	UIAlertView * alert =[[UIAlertView alloc] initWithTitle:tittle message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

-(void)ShowAlertWithMaps:(NSString*)tittle Text:(NSString*)text
{
	UIAlertView * alert =[[[UIAlertView alloc] initWithTitle:tittle message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Go To Maps",nil]autorelease];
	[alert show];
	[alert release];	
}

-(void) goToMaps
{
	NSString *mapString = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%f,%f", lat,lon];
	NSURL *url = [NSURL URLWithString:mapString];	
	// Switch to Safari and display that map
	[[UIApplication sharedApplication] openURL:url];	
}

/*NO ME EJECUTA LA CALLBAKC, REVISAR

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	printf("\nEN LA CALLBACK DEL MENU DE COORDENADAS");
	
	if(buttonIndex==1)
	{
		printf("\nEN LA CALLBACK DEL MENU DE COORDENADAS BOTON1");
		[self goToMaps];
	}
	//[alert release];
}

*/


@end


/*
 static int i=0;
 NSLog(@"%f %f", [newLocation horizontalAccuracy], [newLocation verticalAccuracy]);
 
 // Location has been found. Create GMap URL
 CLLocationCoordinate2D loc = [newLocation coordinate];
 [(UITextView *)self.view setText:[NSString stringWithFormat:@"\nPeticion numero:%d\nLat:%f\nLon:%f\n",i,loc.latitude,loc.longitude]];
 i++;
 
 
 /*
 
 NSString *mapString = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%f,%f", loc.latitude, loc.longitude];
 NSURL *url = [NSURL URLWithString:mapString];
 
 // Switch to Safari and display that map
 [[UIApplication sharedApplication] openURL:url];	
 */
