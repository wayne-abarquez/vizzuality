//
//  RootController.m
//  SpeciesLog
//
//  Created by Administrador on 13/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "RootController.h"


@implementation RootController


- (id) initWithTitle: (NSString*)title
{
	if (self = [super init]) 
	{
		self.title = title;		
	}
	return self;
}

- (id) initWithTitle: (NSString*)title iconName:(NSString*)_iconName
{
	if (self = [super init]) 
	{
		self.title = title;	
		self.tabBarItem.image = [UIImage imageNamed:_iconName];
	}
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
	//AJUSTAMOS LOS VALORES DEL NAVIGATOR	
	
	self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;	
	
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	return YES;
 }
 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
