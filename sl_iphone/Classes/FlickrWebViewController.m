//
//  FlickrWebViewController.m
//  SpeciesLog
//
//  Created by Administrador on 28/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#import "FlickrWebViewController.h"
#import "MD5Class.h"
#import "XMLParser.h"
#import "NetworkConn.h"
#import "LoadIconClass.h"
#import "LoadActivityIcon.h"

@implementation FlickrWebViewController

@class SpeciesLogAppDelegate;

@synthesize token;
@synthesize secret;
@synthesize api_key;
@synthesize frob;
@synthesize webView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{	
	[super viewDidLoad];			
}

- (void)viewWillAppear:(BOOL)animated
{ 	
	//[LoadIconClass presentHUD:self.view	Text:@"Checking network status "];
}
- (void)viewDidAppear:(BOOL)animated 
{
	[LoadIconClass startThreadHUD:self.view Text:@"Checking network status"];	
	[NSThread detachNewThreadSelector:@selector(checkNetwork) toTarget:self withObject:nil];	
}

-(void) checkNetwork
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	//MAIN BUNDLE
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];	
	//APIKEY AND SECRET
	secret=[info objectForKey: @"FlikcrSecret"];
	api_key =[info objectForKey: @"FlickrApiKey"];
	//TOKEN
	NSString* _token=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrToken"];
	token=[_token copy];
	
	//VERIFICAMOS ESTADO DE LA CONEXION CON FLIKCR
	BOOL connection=[NetworkConn connectionWithFlickr];	
	if(_token)
	{	
		if(connection==YES)
		{
		
			NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@auth_token%@methodflickr.auth.checkToken",secret,api_key,token]];
			NSString* stringUrl=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.checkToken&api_key=%@&auth_token=%@&api_sig=%@",api_key,token,api_sig];
			NSURL* url=[NSURL URLWithString:stringUrl];
			XMLParser* 	xmlData=[[XMLParser alloc]init];
			NSString *res=[[xmlData parseXMLFile:url] copy];
			[LoadIconClass killThreadHud];
			if([ xmlData.statValue isEqualToString:@"ok"])
				[self performSelectorOnMainThread:@selector(goToMainApp) withObject:nil waitUntilDone:YES];
			else	
				[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:VERIFY_TOKEN]  waitUntilDone:YES];
		}
		else //NO PODEMOS VERIFICAR SI EL TOKEN ES O NO CORRECTO
		{
			[LoadIconClass killThreadHud];
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:FLICKER_UNABLE]  waitUntilDone:YES];
		}
	}
	else
	{
		[LoadIconClass killThreadHud];
		if(connection==YES)
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:REGISTER_REQUEST]  waitUntilDone:YES];
		else //NO PODEMOS VERIFICAR SI EL TOKEN ES O NO CORRECTO
			[self performSelectorOnMainThread:@selector(showAlert:) withObject:[NSNumber numberWithInt:EXIT_APP]  waitUntilDone:YES];
	}	
	[pool release];	 
}


-(void) AuthProcess
{
	
	NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%sapi_key%smethodflickr.auth.getFrob",[secret UTF8String],[api_key UTF8String]]];
	NSString* stringUrlFrob=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.getFrob&api_key=%s&api_sig=%s",[api_key UTF8String],[api_sig UTF8String]];
	NSURL* urlFrob=[NSURL URLWithString:stringUrlFrob];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	frob=[[xmlData parseXMLFile:urlFrob] copy];
	printf("FROB :%s\n",[frob UTF8String]);
	
	NSString* api_sig2 = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@frob%@permswrite",secret,api_key,frob]];	
	NSString* stringUrlAuth=[NSString stringWithFormat:@"http://flickr.com/services/auth/?api_key=%@&perms=write&frob=%@&api_sig=%@",api_key,frob,api_sig2];
	printf("\nURL AUTH:%s",[ stringUrlAuth UTF8String]);
	NSURL* urlAuth=[NSURL URLWithString:stringUrlAuth];
	NSURLRequest* requestObj=[NSURLRequest requestWithURL:urlAuth];
	[webView setDelegate:self];
	[webView loadRequest:requestObj];
	
}

-(IBAction)getToken
{
	if( [LoadIconClass isLoading]==NO)
	{
		
	NSString* api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@frob%@methodflickr.auth.getToken",secret,api_key,frob]];
	NSString* stringUrlToken=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.auth.getToken&api_key=%@&frob=%@&api_sig=%@",api_key,frob,api_sig];
	printf("\nURL TOKEN:%s",[stringUrlToken UTF8String]);
	NSURL* urlToken=[NSURL URLWithString:stringUrlToken];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	NSString* _token=[[xmlData parseXMLFile:urlToken] copy];
	//[LoadIconClass killHUD];
	if([xmlData.statValue isEqualToString:@"ok"])
	{
		token=[_token copy];
		[[NSUserDefaults standardUserDefaults]setObject:token forKey:@"FlickrToken"];
		[[NSUserDefaults standardUserDefaults]synchronize];
		printf("\nTOKEN ESCRITO EN DISCO:%s\n",[token UTF8String]);	
		
		[self showAlert:[NSNumber numberWithInt:REGISTER_SUCESS]];
		[self goToMainApp];
	}
	else
	{
		[self showAlert:[NSNumber numberWithInt:TOKEN_DONE_ERROR]];
		
	}	
	}
}

- (void)webViewDidStartLoad:(UIWebView *)_webView
{
	[LoadIconClass presentHUD:self.view Text:@"Accessing Flicker. Please wait..."];
	
}
- (void)webViewDidFinishLoad:(UIWebView *)_webView
{	
	[LoadIconClass killHUD];
	NSString *currentURL= webView.request.URL.absoluteString;
	printf("\nURL:%s",[currentURL UTF8String]);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{	
	printf("ERROR AL CARGAR LA PAGINA");
	[self showAlert:[NSNumber numberWithInt:EXIT_APP]];
}

-(void) showAlert:(NSNumber*)num
{
	int numMsg=[num intValue];
	if(numMsg==VERIFY_TOKEN)//TOKEN:SI RED:SI-> VERIFICAR: Boton de registro o salir.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Token Revocated" message:@"Register SpeciesLoc in Flickr again" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Register",nil];
	}
	else if(numMsg==FLICKER_UNABLE)//TOKEN:SI RED:NO-> PUEDE HACER FOTOS PERO NO SUBIRLAS.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Unable to access Flickr" message:@"Can take and storage photos, but cannot upload them" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Continue",nil];
	}
	else if(numMsg==REGISTER_REQUEST)//TOKEN:NO RED:SI-> REGISTRAR APLICACION.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Request" message:@"Register SpeciesLoc in Flickr" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Register",nil];
	}
	else if(numMsg==EXIT_APP)//TOKEN:NO RED:NO-> IMPOSIBLE HACER NADA, SALIR FUERA.
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Network Fail" message:@"Unable to access Flicker. Connected to Internet?" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:nil];
	}
	else if(numMsg == TOKEN_DONE_ERROR)
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Error" message:@"SpeciesLog could not register in Flickr. Try again process" delegate:self cancelButtonTitle:@"EXIT" otherButtonTitles:@"Try again",nil];
	}
	else if(numMsg == REGISTER_SUCESS)
	{
		alert =[[UIAlertView alloc] initWithTitle:@"Register Success" message:@"SpeciesLog in now registered in Flickr. Enjoy" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	}
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{	

	if(buttonIndex == 0 && [ alertView.title isEqualToString:@"Register Success"]==NO)
	{
		[[UIApplication sharedApplication] terminate];
	}
	else if([ alertView.title isEqualToString:@"Token Revocated"])
	{
		[self AuthProcess];
	}
	else if([ alertView.title isEqualToString:@"Unable to access Flickr"])
	{
		//CONTINUE WITHOUT REGISTERING
		[self goToMainApp];
	}
	else if([ alertView.title isEqualToString:@"Register Request"])
	{
		[self AuthProcess];
	}
	else if([ alertView.title isEqualToString:@"Network Fail"])
	{
		// NOTHING TO BE DONE
	}
	else if([ alertView.title isEqualToString:@"Register Error"])
	{
		[self AuthProcess];
	}	
}
-(void) goToMainApp
{
	SpeciesLogAppDelegate* sp=[[UIApplication sharedApplication] delegate];
	[sp loadMainApp];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}



@end
