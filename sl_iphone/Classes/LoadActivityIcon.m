//
//  LoadActivityIcon.m
//  SpeciesLog
//
//  Created by Administrador on 19/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "LoadActivityIcon.h"
#import "SpeciesLogAppDelegate.h"

#define INDICATOR_VIEW	999

@implementation LoadActivityIcon

- (void) stopAnimation
{
	
	UIActivityIndicatorView *activityIndicator = (UIActivityIndicatorView *)[self.view viewWithTag:INDICATOR_VIEW];
	[activityIndicator stopAnimating]; 
}

- (id) init
{
	if (self = [super init]) self.title = @"Hello World";
	return self;
}

- (void)loadViewSito
{
	UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	
	SpeciesLogAppDelegate* sp=(SpeciesLogAppDelegate*)[[UIApplication sharedApplication]delegate];
		
	UIView* fondoTransparente=[[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 480.0f)];
	fondoTransparente.backgroundColor = [UIColor blackColor];
	fondoTransparente.alpha=0.0;
	
	UIView* fondoLoading=[[UIView alloc]initWithFrame:CGRectMake(100.0f, 100.0f, 128.0f, 128.0f)];
	fondoLoading.backgroundColor = [UIColor blackColor];
		
	// Add the progress indicator but do not start it
	progressShowing = YES;
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
	[activityIndicator setCenter:CGPointMake(64.0f, 64.0f)];
    [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.tag = INDICATOR_VIEW;
	[activityIndicator startAnimating];
	
	[fondoLoading addSubview:activityIndicator];		
	[contentView addSubview:fondoTransparente];
	[contentView addSubview:fondoLoading];
	[sp.window addSubview:contentView];
		
	[activityIndicator release];
	[contentView release]; 
	[fondoLoading release];
	[fondoTransparente release];
}



@end
