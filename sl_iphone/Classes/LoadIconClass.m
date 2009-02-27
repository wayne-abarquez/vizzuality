//
//  UIProgressHUD.m
//  SpeciesLog
//
//  Created by Administrador on 03/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "LoadIconClass.h"
#import "SpeciesLogAppDelegate.h"

@implementation LoadIconClass

+ (void) killHUD
{
	if(miHUD)
	{
		[miHUD show:NO];
		[miHUD release];
	}
	miHUD=nil;
}
+(void) updateHUDText:(NSString*)text
{
	if(miHUD)
		[miHUD setText:text];
}
+ (void) presentHUD:(UIView*)vista Text:(NSString*)text
{
	if(miHUD==nil)
	{
		
		miHUD = [[UIProgressHUD alloc] initWithWindow:vista];
		[miHUD setText:text];
		[miHUD show:YES];
	}
	else
		[miHUD setText:text];
	
}
+ (void) presentHUD:(UIView*)vista Text:(NSString*)text Delay:(float)delay
{
	if(miHUD==nil)
	{
		miHUD = [[UIProgressHUD alloc] initWithWindow:vista];
		[miHUD setText:text];
		[miHUD show:YES];
	    [self performSelector:@selector(killHUD) withObject:miHUD afterDelay:delay];
	}
	else
		[miHUD setText:text];
}

//PARA SACARLO EN UN SEGUNDO HILO!!!

+(void) startThreadHUD:(UIView*)vista  Text:(NSString*)text
{
	//[NSThread detachNewThreadSelector:@selector(showHUDInThread:) toTarget:self withObject:vista];
	
	HUDInfoText=text;
	loading=YES;
	if(miThread==nil)
	{				
		miThread=[[NSThread  alloc] initWithTarget:self  selector:@selector(showHUDInThread:)  object:vista];
		[miThread start];
	}
}

+(void) showHUDInThread:(UIView*)vista
{
	
	if(miHUD==nil)
	{
		SpeciesLogAppDelegate* sp=(SpeciesLogAppDelegate*)[[UIApplication sharedApplication] delegate];
		
		printf("EN EL HILO");
		HUDpool = [[NSAutoreleasePool alloc] init];
		miHUD = [[UIProgressHUD alloc] initWithWindow:vista];
		//miHUD = [[UIProgressHUD alloc] initWithWindow:sp.window];
		[miHUD setText:HUDInfoText];
		[miHUD show:YES];
	}
	 
	 
}

+(void) killThreadHud
{
	
	[self killHUD];	
	if(miThread)
	{	
		[miThread cancel];
		[miThread release];
		miThread=nil;	
		//[HUDpool drain];
		loading=NO;
	}
		  
}
+ (BOOL) isLoading
{
	return loading;
}

@end
