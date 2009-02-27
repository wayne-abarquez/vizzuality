//
//  CDato.h
//  SpeciesLog
//
//  Created by Administrador on 25/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface CDato : NSObject 
{
	int Id;
	NSString*	name;
	bool		KnowName;
	CLLocation* locationInfo;
	
	NSNumber* idData;
	NSString *nameData;
	NSString *scientificName;
	NSString *imageURL;
	NSNumber* scientificNameKnown;
	NSNumber* pending;
	NSNumber *lat;
	NSNumber *lng;
	NSString *dateTime;
	
	//Intrnal variables to keep track of the state of the object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;
	
}

@property int Id;
@property bool KnowName;
@property (retain) NSString*	name;
@property (retain) CLLocation* locationInfo;

@property (nonatomic, copy) NSNumber* idData;
@property (nonatomic, retain) NSString *nameData;
@property (nonatomic, copy) NSString *scientificName;
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, copy) NSNumber* scientificNameKnown;
@property (nonatomic, copy) NSNumber* pending;
@property (nonatomic, copy) NSNumber *lat;
@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSString *dateTime;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//Static methods.
+ (void) getInitialDataToDisplay:(NSString *)dbPath;
+ (void) finalizeStatements;

//Instance methods.
- (id) initWithPrimaryKey:(NSInteger)pk;
- (id) initWithPrimaryKey;
- (void) deleteCDato;
- (NSNumber *) addCDato;
- (void) addCDatoLatLngNames;
- (void) modifyCDato;
- (void) CDatoSent;

- (void) hydrateDetailViewData;
- (void) saveAllData;


@end
