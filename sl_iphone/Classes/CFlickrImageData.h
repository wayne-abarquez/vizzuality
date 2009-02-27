//
//  CFlickrImageData.h
//  SpeciesLog
//
//  Created by Administrador on 04/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CFlickrImageData : NSObject
{
	NSString* farm;
	NSString* server;
	NSString* user_id;
	NSString* secret;
	NSString* title;
}

@property (nonatomic,retain) NSString* farm;
@property (nonatomic,retain) NSString* server;
@property (nonatomic,retain) NSString* user_id;
@property (nonatomic,retain) NSString* secret;
@property (nonatomic,retain) NSString* title;

@end
