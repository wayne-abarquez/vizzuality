//
//  XMLParser.m
//  SpeciesLog
//
//  Created by Administrador on 30/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser
@synthesize statValue;

- (NSString *)parseXMLFile: (NSURL *) url
{	
	outstring = [[NSMutableString alloc] init];	
	tipoPeticion=REGISTER_DATA;	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
	[parser parse];
    [parser release];	
	return [[frobValue copy] autorelease];
}


- (NSString *)parseXMLData: (NSData *) data
{	
	outstring = [[NSMutableString alloc] init];
	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
	[parser parse];
    [parser release];
	
	return [outstring autorelease];
}

- (NSString *) getUploadPhotoResponse: (NSData *) data
{
	outstring = [[NSMutableString alloc] init];	
	
	tipoPeticion=GET_UPLOAD_RESPONSE;	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
	[parser parse];
    [parser release];
	
	return [outstring autorelease];
}


-(NSMutableArray*) getRecentPhotos:(NSURL *) url
{
	tablaFotos = [[NSMutableArray alloc] initWithCapacity:1];	
	tipoPeticion=RECENT_PHOTOS;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
	[parser parse];
    [parser release];	
	return [[tablaFotos copy] autorelease];
}

- (NSMutableArray*) getRecentPhotosInfo:(NSURL *) url
{
	tablaFotosInfo = [[NSMutableArray alloc] initWithCapacity:1];
	
	tipoPeticion=RECENT_PHOTOS_INFO;
	NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
	[parser parse];
    [parser release];	
	
	return [[tablaFotosInfo copy] autorelease];
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if(tipoPeticion==GET_UPLOAD_RESPONSE)
	{
		if( [elementName isEqualToString:@"photoid"])
		{
			
		}
	}
	else if(tipoPeticion==RECENT_PHOTOS_INFO)
	{
		if( [elementName isEqualToString:@"photo"])
		{
			CFlickrImageData* data=[[CFlickrImageData alloc]init];
			data.farm=[ attributeDict objectForKey:@"farm"];
			data.server=[ attributeDict objectForKey:@"server"];
			data.user_id=[ attributeDict objectForKey:@"id"];
			data.secret=[ attributeDict objectForKey:@"secret"];
			data.title=[attributeDict objectForKey:@"title"];
			[tablaFotosInfo addObject:data];
			printf("\nALMACENADO:%s",[data.title UTF8String]);
			[data release];		
		}
	}
	else if( tipoPeticion==RECENT_PHOTOS)
	{
		printf("\nFOTOOOOOSSSSSSSSSSSS!!!");
		//TB TENEMOS EL NOMBRE DE LA FOTO CLAVE: title DEL DICCIONARIO
		NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",[ attributeDict objectForKey:@"farm"],
																										  [ attributeDict objectForKey:@"server"],
																										  [ attributeDict objectForKey:@"id"],
																										  [ attributeDict objectForKey:@"secret"]];
		UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]]] retain];
		if (image != nil) 
		{	
			[tablaFotos addObject:image];
		}
	}
	else if(tipoPeticion==REGISTER_DATA)
	{
	}
	printf("INCIO TAG:%s\n",[elementName UTF8String]);
	NSEnumerator* e=[attributeDict keyEnumerator];
	NSString* k;
	while((k=[e nextObject]))
	{
		NSLog(@" %@ -> %@\n ",k,[ attributeDict objectForKey:k]);
		if( [elementName isEqualToString:@"user"])
		{			
			if([k isEqualToString:@"username"])
			{
				[[NSUserDefaults standardUserDefaults]setObject:[ attributeDict objectForKey:k] forKey:@"FlickrUsername"];
			}
			else if([k isEqualToString:@"nsid"])
			{
				[[NSUserDefaults standardUserDefaults]setObject:[ attributeDict objectForKey:k] forKey:@"FlickrNsid"];
			}
			else if([k isEqualToString:@"fullname"])
			{
				[[NSUserDefaults standardUserDefaults]setObject:[ attributeDict objectForKey:k] forKey:@"FlickrFullname"];
			}	
			 
		}
		if( statValue==nil && [k isEqualToString:@"stat"] )
		{
			statValue=[NSString stringWithString:[ attributeDict objectForKey:k]];
		}
	}
	if (elementName) 
	{
		current = [NSString stringWithString:elementName];
	}	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	printf("FIN TAG:%s\n",[elementName UTF8String]);
	current=NULL;
	[current release];
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	printf("CARACTERS TAG:%s\n",[string UTF8String]);
	if( [statValue isEqualToString:@"ok"] && ([current isEqualToString:@"frob"]||[current isEqualToString:@"token"]))
	{
		frobValue=[NSString stringWithString:string];
		printf("CAPTURADO:%s\n",[frobValue UTF8String]);
	}
	else if([statValue isEqualToString:@"ok"] && ([current isEqualToString:@"photoid"]))
	{
		outstring=[NSString stringWithString:string];
		printf("CAPTURADO:%s\n",[outstring UTF8String]);
	}
}

- (void) dealloc
{
	[current release];
	[outstring release];
	[super dealloc];
}

@end
