//
//  CameraClass.h
//  SpeciesLog
//
//  Created by Administrador on 14/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSClass.h"

//#define SOURCETYPE UIImagePickerControllerSourceTypeSavedPhotosAlbum
#define SOURCETYPE UIImagePickerControllerSourceTypePhotoLibrary
//#define SOURCETYPE UIImagePickerControllerSourceTypeCamera
#define DOCSFOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

@interface CameraClass :  UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>
{
	int lastPhotoIndex;	
	BOOL tookPhoto;
	UIImagePickerController * miPicker;
	UIImage* miImg;
	NSDictionary* miEditInfo;
	//GPSClass* gps;
}

-(int)  loadLastPhotoIndex;
-(void) saveToDiskLastPhotoIndex;
-(void) savePhotoToDocuments:(UIImage *)image editingInfo:(NSDictionary *)editingInfo scientificName:(NSString *)message;
-(void) showGetInfoPanel;
-(void) saveToPhotoAlbum:(UIImage*)img;

@property (nonatomic,retain) UIImage* miImg;
@property int lastPhotoIndex;
@property BOOL tookPhoto;

@end
