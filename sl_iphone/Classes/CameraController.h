//
//  CameraController.h
//  SpeciesLog
//
//  Created by Administrador on 14/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootController.h"
#import	"CameraClass.h"

#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] 

@interface CameraController : RootController
{	
	UITextView* textView;
	UIImageView* lastPhoto;
	CameraClass* camera;
	NSArray* fileList;
	BOOL firstFoto;
}


-(void) snap;
-(void)loadText;
@property BOOL firstFoto;

@end
