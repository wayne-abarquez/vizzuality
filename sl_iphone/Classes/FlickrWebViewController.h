//
//  FlickrWebViewController.h
//  SpeciesLog
//
//  Created by Administrador on 28/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VERIFY_TOKEN	 1
#define FLICKER_UNABLE	 2
#define REGISTER_REQUEST 3
#define EXIT_APP		 4
#define TOKEN_DONE_ERROR 5
#define REGISTER_SUCESS  6


@interface FlickrWebViewController : UIViewController  <UIWebViewDelegate,UIAlertViewDelegate>
{	
	IBOutlet UIWebView* webView;
	UIAlertView* alert;
	NSString* token;
	NSString* secret;
	NSString* api_key;
	NSString* frob;	
	
}

@property (nonatomic, retain) NSString* token;
@property (nonatomic, retain) NSString* secret;
@property (nonatomic, retain) NSString* api_key;
@property (nonatomic, retain) NSString* frob;
@property (nonatomic, retain) UIWebView* webView;

- (IBAction) getToken;
- (void) AuthProcess;
- (void) showAlert:(NSNumber*)num;
- (void) goToMainApp;

@end
