//
//  HomeController.m
//  SpeciesLog
//
//  Created by Administrador on 13/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "HomeController.h"
#import "SpeciesLogAppDelegate.h"

@implementation HomeController


- (void)loadView 
{
	[super loadView];
		
	//CARGAMOS LA VISTA Y EL BOTON PARA IR AL SIGUIENTE NIVEL
	contentView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen]applicationFrame]];
	[contentView setImage:[UIImage imageNamed:@"HomeVert.png"]];
	//contentView.alpha=0.8f;
	contentView.autoresizesSubviews = NO;
	contentView.autoresizesSubviews = YES;
	contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.view = contentView;	
}

-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration
{
	/*
	if(orientation==UIInterfaceOrientationLandscapeLeft || orientation==UIInterfaceOrientationLandscapeRight)
	{
		[contentView setImage:[UIImage imageNamed:@"HomeHoriz2.png"]];
	}
	else
	{
		[contentView setImage:[UIImage imageNamed:@"HomeVert.png"]];
	}
	 */
}

- (void)viewDidAppear:(BOOL)animated 
{
	
}




- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
	[contentView release];
    [super dealloc];
}


@end
