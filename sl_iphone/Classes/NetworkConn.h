//
//  NetworkConn.h
//  SpeciesLog
//
//  Created by Administrador on 03/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NetworkConn : NSObject 
{

}
+ (NSString *) getIPAddressForHost: (NSString *) theHost;
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address;
+ (BOOL) hostAvailable: (NSString *) theHost;
+ (BOOL) connectionWithFlickr;
@end
