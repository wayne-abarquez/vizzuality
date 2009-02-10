//
//  NetworkConn.m
//  SpeciesLog
//
//  Created by Administrador on 03/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "NetworkConn.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>


@implementation NetworkConn

+(BOOL) connectionWithFlickr
{
	NSError    *error = nil;
	NSURL* url1=[NSURL URLWithString:@"http://www.flickr.com"];
	int i=0;
	BOOL encontrado=NO;
	while(i < 3 && encontrado == NO)
	{
		NSString* ip1=[NSString	stringWithContentsOfURL:url1 encoding:NSASCIIStringEncoding error:&error]; 
		if(ip1!=nil)
			encontrado=YES;
		else
			i++;		
	}
	return encontrado;
}

+ (NSString *) getIPAddressForHost: (NSString *) theHost
{
	struct hostent *host = gethostbyname([theHost UTF8String]);
	
    if (host == NULL) 
	{
        herror("resolv");
		return NULL;
	}
	
	struct in_addr **list = (struct in_addr **)host->h_addr_list;
	NSString *addressString = [NSString stringWithCString:inet_ntoa(*list[0])];
	return addressString;
}
+ (BOOL)addressFromString:(NSString *)IPAddress address:(struct sockaddr_in *)address
{
	if (!IPAddress || ![IPAddress length])
	{
		return NO;
	}
	
	memset((char *) address, sizeof(struct sockaddr_in), 0);
	address->sin_family = AF_INET;
	address->sin_len = sizeof(struct sockaddr_in);
	
	int conversionResult = inet_aton([IPAddress UTF8String], &address->sin_addr);
	if (conversionResult == 0) 
	{
		NSAssert1(conversionResult != 1, @"Failed to convert the IP address string into a sockaddr_in: %@", IPAddress);
		return NO;
	}
	
	return YES;
}

+ (BOOL) hostAvailable: (NSString *) theHost
{
	
	NSString *addressString = [self getIPAddressForHost:theHost];
	if (!addressString) 
	{
		printf("Error recovering IP address from host name\n");
		return NO;
	}
	
	struct sockaddr_in address;
	BOOL gotAddress = [self addressFromString:addressString address:&address];
	
	if (!gotAddress)
	{
		printf("Error recovering sockaddr address from %s\n", [addressString UTF8String]);
		return NO;
	}
	
	SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&address);
	SCNetworkReachabilityFlags flags;
	
	BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
	CFRelease(defaultRouteReachability);
	
	if (!didRetrieveFlags) 
	{
		printf("Error. Could not recover network reachability flags\n");
		return NO;
	}
	
	BOOL isReachable = flags & kSCNetworkFlagsReachable;
	return isReachable ? YES : NO;;
}

@end
