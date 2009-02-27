//
//  SpeciesLogAppDelegate.m
//  SpeciesLog
//
//  Created by Administrador on 13/01/09.
//  Copyright Alfortel Telecomunicaciones 2009. All rights reserved.
//

#import "SpeciesLogAppDelegate.h"
#import "GPSClass.h"
#import "CDato.h"
#import "BBDD_admin.h"

@implementation SpeciesLogAppDelegate

@synthesize window;
@synthesize	gps;
@synthesize arrayCDato;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	firsTimeGPS=YES;
	
	//CREAMOS LOS CONTROLADORES DE CADA PANTALLA	
	[BBDD_admin copyDatabaseIfNeeded];
	
	//Initialize the global array.
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	self.arrayCDato = tempArray;
	[tempArray release];

	//Once the db is copied, get the initial data to display on the screen.
	[CDato getInitialDataToDisplay:[BBDD_admin getDBPath]];	
		
	
	flickrViewController= [[FlickrWebViewController alloc] initWithNibName:@"FlickrWebView" bundle:[NSBundle mainBundle]];
	[window addSubview:flickrViewController.view];		
    [window makeKeyAndVisible];	
	 
}
-(void) loadMainApp
{
	//CREAMOS LOS CONTROLADORES
	homeController= [[UINavigationController alloc] initWithRootViewController:[[HomeController alloc] initWithTitle:@"HOME" iconName:@"HomeIcon.png"]];
	recentController = [[UINavigationController alloc] initWithRootViewController:[[RecentController alloc] initWithTitle:@"RECENT" iconName:@"DownloadIcon.png"]];
	cameraController = [[UINavigationController alloc] initWithRootViewController:[[CameraController alloc] initWithTitle:@"CAMERA" iconName:@"CamaraIcon.png"]];
	uploadController = [[UINavigationController alloc] initWithRootViewController:[[PendingController alloc] initWithTitle:@"PENDING" iconName:@"UploadIcon.png"]];
	settingsController = [[UINavigationController alloc] initWithRootViewController:[[RootController alloc] initWithTitle:@"SETTINGS" iconName:@"IconTab1.png"]];
	settingsController2 = [[UINavigationController alloc] initWithRootViewController:[[RootController alloc] initWithTitle:@"ABOUT US" iconName:@"IconTab1.png"]];
	
	//CREAMOS EL TOOLBAR
	tBarController = [[UITabBarController alloc] init];
	NSMutableArray* controllers= [NSMutableArray arrayWithObjects:homeController,recentController,cameraController,uploadController,settingsController,settingsController2,nil];	
	tBarController.viewControllers =controllers;
	tBarController.customizableViewControllers = controllers;
	tBarController.delegate = self;	
		
	//AÑADIMOS LA VISTA
	[flickrViewController.view removeFromSuperview];
	[window addSubview:tBarController.view];		
  	[flickrViewController release];	
	
	[self loadGPSIphone];
}

-(void)loadGPSIphone
{
	//CREAMOS EL GPS
	gps=[[GPSClass alloc]init];
	[gps initLocationService];
	[gps startLocation];	
}

- (void)dealloc 
{
    [window release];
	[gps release];
	[homeController release];
	[cameraController release];
	[uploadController release];
	[settingsController release];
    [super dealloc];
}


-(void)goHome
{
	tBarController.selectedIndex=0;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

	if(viewController==homeController)
	{
		printf("HOME\n");	
	}
	else if(viewController==uploadController)
		printf("UPLOAD\n");
	else if(viewController==cameraController)
	{
		printf("CAMERA");	
		CameraController* cm=(CameraController*)cameraController.topViewController;
		if(cm.firstFoto==NO)
		{
			[cm snap];
		}
	}
	else
	{
		printf("SETTINGS");
	}
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	printf("\nCOOOOORRRRRRRREEEEEEEE Y SALVA!!!");
	[gps stopLocation];
	[CDato finalizeStatements];
}

@end
