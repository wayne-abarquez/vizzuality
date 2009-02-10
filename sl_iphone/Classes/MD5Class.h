//
//  MD5Class.h
//  SpeciesLog
//
//  Created by Administrador on 29/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface MD5Class : NSObject
{
}
+(NSString*) stringToMD5:(NSString*)str;
@end
