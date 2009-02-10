//
//  SpeciesLogAppDelegate.h
//  SpeciesLog
//
//  Created by Administrador on 13/01/09.
//  Copyright Alfortel Telecomunicaciones 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootController.h"
#import "HomeController.h"
#import "CameraController.h"
#import "PendingController.h"
#import "FlickrWebViewController.h"
#import "RecentController.h"		

@interface SpeciesLogAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate>
{
    UIWindow *window;	
	
	FlickrWebViewController* flickrViewController;
	
	UINavigationController* homeController;
	UINavigationController* recentController;
	UINavigationController* cameraController;
	UINavigationController* uploadController;
	UINavigationController* settingsController;
	UINavigationController* settingsController2;

	UITabBarController* tBarController;
	
	GPSClass* gps;
	
	NSMutableArray *arrayCDato;
		
	BOOL firsTimeGPS;
}

-(void) loadMainApp;
-(void) goHome;
-(void) loadGPSIphone;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) GPSClass* gps;
@property (nonatomic, retain) NSMutableArray *arrayCDato;

@end

