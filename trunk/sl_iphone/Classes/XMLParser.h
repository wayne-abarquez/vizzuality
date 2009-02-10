//
//  XMLParser.h
//  SpeciesLog
//
//  Created by Administrador on 30/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFlickrImageData.h"

#define RECENT_PHOTOS       1
#define RECENT_PHOTOS_INFO  3
#define REGISTER_DATA       2
#define GET_UPLOAD_RESPONSE 4

@interface XMLParser : NSObject
{
	NSString		*current;
	NSMutableString	*outstring;
	NSString		*statValue;
	NSString		*frobValue;
	int				tipoPeticion;
	NSMutableArray* tablaFotos;
	NSMutableArray* tablaFotosInfo;
}
@property (nonatomic,retain) NSString *statValue;

- (NSString *)parseXMLFile: (NSURL *) url;
- (NSMutableArray*) getRecentPhotos:(NSURL *) url;
- (NSMutableArray*) getRecentPhotosInfo:(NSURL *) url;
- (NSString *) parseXMLData: (NSData *) data;
- (NSString *) getUploadPhotoResponse: (NSData *) data;



@end