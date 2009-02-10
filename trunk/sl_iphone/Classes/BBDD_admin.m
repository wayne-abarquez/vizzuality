//
//  BBDD_admin.m
//  SQL
//
//  Created by Alfonso on 26/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BBDD_admin.h"
#import "CDato.h"
#import "SpeciesLogAppDelegate.h"



@implementation BBDD_admin



+ (void) copyDatabaseIfNeeded {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	NSString *dbPath = [self getDBPath];
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"SpeciesLog_v1.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
		if (!success) 
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}	
}

+ (NSString *) getDBPath {
	
	//Search for standard documents using NSSearchPathForDirectoriesInDomains
	//First Param = Searching the documents directory
	//Second Param = Searching the Users directory and not the System
	//Expand any tildes and identify home directories.
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return [documentsDir stringByAppendingPathComponent:@"SpeciesLog_v1.sqlite"];
}

+ (void) removeData:(CDato *)DatoObj {
	
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//Delete it from the database.
	[DatoObj deleteCDato];
	
	//Remove it from the array.
	[appDelegate.arrayCDato removeObject:DatoObj];
}

+ (NSNumber *) addData:(CDato *)DatoObj {
	
	//SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	//Add it to the database.
	NSNumber *idTemp = [DatoObj addCDato];
	
	//Add it to the coffee array.
	//[appDelegate.arrayCDato addObject:DatoObj];
	
	return idTemp;
}

+ (void) addDataLatLngNames:(CDato *)DatoObj{
	
	[DatoObj addCDatoLatLngNames];
	
}

+ (void) modifyData:(CDato *)DatoObj{
	
	[DatoObj modifyCDato];
	
}

+ (void) sentData:(CDato *)DatoObj{
	
	[DatoObj CDatoSent];
	
}

@end
