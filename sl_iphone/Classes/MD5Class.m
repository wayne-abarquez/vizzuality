//
//  MD5Class.m
//  SpeciesLog
//
//  Created by Administrador on 29/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "MD5Class.h"


@implementation MD5Class

+(NSString*) stringToMD5:(NSString*)str
{
	const char *cStr = [str UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
			];	
}



@end
