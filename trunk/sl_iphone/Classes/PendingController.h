//
//  PendingController.h
//  SpeciesLog
//
//  Created by Administrador on 22/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

#import "CDato.h"
#import "PendingDataViewController.h"


#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface PendingController : UITableViewController  
{
	UITextView* textView;
	NSArray* fileList;
	PendingDataViewController *cDatoView;
	
	NSString* api_key;
	NSString* secret;
	NSString* token;
	NSString* api_sig;
	
	BOOL justOnePhoto;
	int indexPhotoUpload;
}
@property(nonatomic,retain) PendingDataViewController *cDatoView;



- (id) initWithTitle: (NSString*)title;
- (id) initWithTitle: (NSString*)title iconName:(NSString*)_iconName;
-(int)  LoadFileList;
-(void) loadApiSignatureData;
-(void) UploadData:(NSString*)imgName Description:(NSString*)desc;
-(void) showDetailedView: (NSIndexPath *)indexPath;
- (void) uploadOnePhoto;
@end
