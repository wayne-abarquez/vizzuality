//
//  CDato.m
//  SpeciesLog
//
//  Created by Administrador on 25/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "CDato.h"
#import "SpeciesLogAppDelegate.h"

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;
static sqlite3_stmt *detailStmt = nil;
static sqlite3_stmt *updateStmt = nil;

@implementation CDato

@synthesize Id;
@synthesize KnowName;
@synthesize name;
@synthesize locationInfo;

@synthesize idData, nameData, scientificName, imageURL, pending, scientificNameKnown, lat, lng,dateTime, isDirty, isDetailViewHydrated;

// MOSTRAMOS TODOS LAS FOTOS PENDING DE BBDD
+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	printf("RUTA BBDD:%s",[dbPath UTF8String]);
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "SELECT * FROM prueba1 WHERE pending=1";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
				// CREO LOS CDATO'S PONIENDO SUS ATRIBUTOS SEGUN BBDD
				NSInteger primaryKey = sqlite3_column_int(selectstmt, 0);
				CDato *objetoDato = [[CDato alloc] initWithPrimaryKey:primaryKey];
				objetoDato.nameData = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				objetoDato.scientificName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt,2)];
				objetoDato.imageURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt,3)];																				 				objetoDato.scientificNameKnown = [NSNumber numberWithInt:sqlite3_column_int(selectstmt, 4)];
				objetoDato.pending = [NSNumber numberWithInt:sqlite3_column_int(selectstmt, 5)];
				objetoDato.lat = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 6)];
				objetoDato.lng = [NSNumber numberWithDouble:sqlite3_column_double(selectstmt, 7)];
				objetoDato.dateTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 8)];
				
				objetoDato.isDirty = NO;
				
				printf("\n AÑADO UN CDATO AL ARRAY!");
				[appDelegate.arrayCDato addObject:objetoDato];
				
				[objetoDato release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

+ (void) finalizeStatements {
	
	if (database) sqlite3_close(database);
	if (deleteStmt) sqlite3_finalize(deleteStmt);
	if (addStmt) sqlite3_finalize(addStmt);
	if (detailStmt) sqlite3_finalize(detailStmt);
	if (updateStmt) sqlite3_finalize(updateStmt);
}

- (id) initWithPrimaryKey:(NSInteger)pk {
	
	[super init];
	
	NSNumber *ident = [NSNumber numberWithInteger: pk];
	
	self.idData = ident;
		
	isDetailViewHydrated = NO;
	
	return self;
}

- (id) initWithPrimaryKey {
	
	[super init];
	
	
	isDetailViewHydrated = NO;
	
	return self;
}

- (void) deleteCDato {
	
	if(deleteStmt == nil) {
		const char *sql = "DELETE FROM prueba1 WHERE idData = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &deleteStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating delete statement. '%s'", sqlite3_errmsg(database));
	}
	
	//When binding parameters, index starts from 1 and not zero.
	sqlite3_bind_int(deleteStmt, 1, [idData intValue]);
	
	if (SQLITE_DONE != sqlite3_step(deleteStmt)) 
		NSAssert1(0, @"Error while deleting. '%s'", sqlite3_errmsg(database));
	
	sqlite3_reset(deleteStmt);
}


/* ESTE METODO SE UTILIZA PARA AÑADIR UN REGISTRO EN LA BBBDD
	Lo hacemos en 2 partes:
		1. añadir scientificName, y los 2 booleanos
		2. obtener id de reg.añadido, crear nameData y imageURL, y añadirlos a este registro
		3. añadir lat y lng a este registro
 ANTES DE LLAMAR AL METODO, DEBEREMOS TENER TODA LA INFO (EXCEPTO LA Q REQUIERA EL ID), Y PASARLA COMO PARAMETROS
 DEL METODO (O MEJOR COMO PROPIEDADES DEL OBJETO CDATO)
*/ 
 - (NSNumber *) addCDato {
	 
	
	 // 1. -------------
	if(addStmt == nil) {
		printf("\n1");
		printf("\n BBDD: ");
		//printf(database);
		
		const char *sql = "insert into prueba1(scientificName, scientificNameKnown,pending) Values(?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK){
			printf("\n 2");
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		}	
	}
	
	 // aqui meto los parametros en la consulta - PERO DONDE LE DOY VALOR A ESTOS PARAMETROS???
	sqlite3_bind_text(addStmt, 1, [self.scientificName UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(addStmt, 2, [self.scientificNameKnown intValue]);
	sqlite3_bind_int(addStmt, 3, [self.pending intValue]);
	 
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else {
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		
		int yy = sqlite3_last_insert_rowid(database);
		printf(" \n --> %d", yy);
	 
		self.idData = [[NSNumber alloc] initWithInt: yy];
	}
	 
	//Reset the add statement.
	sqlite3_reset(addStmt);
	
	 
	 
	 //2. --------------
		 
	 // Y ASIGNO LA DATETIME AL OBJETO CDATO
	 if(detailStmt == nil) {
		 const char *sql = "SELECT dataDateTime FROM prueba1 WHERE idData = ?";
		 if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			 NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	 }
	 
	 sqlite3_bind_int(detailStmt, 1, [self.idData intValue]);
	 
	 while(sqlite3_step(detailStmt) == SQLITE_ROW) {
		 self.dateTime = [NSString stringWithUTF8String:(char *)sqlite3_column_text(detailStmt, 0)];
	 }
	 
	 //Reset the statement.
	 detailStmt = nil;
	 
	 return self.idData;

}


// ESTE METODO SE UTILIZA PARA AÑADIR LA LAT/LNG A UN REGISTRO EN LA BBBDD
 
 - (void) addCDatoLatLngNames {
	 
	 // AQUI METEMOS EN BBDD EL IMAGEURL Y EL NAMEDATA
	 if(updateStmt == nil) {
		 const char *sql = "UPDATE prueba1 SET nameData = ?, imageURL = ? WHERE idData = ?";
		 if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
			 NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	 }
	 
	 sqlite3_bind_text(updateStmt, 1, [self.nameData UTF8String], -1, SQLITE_TRANSIENT);
	 sqlite3_bind_text(updateStmt, 2, [self.imageURL UTF8String], -1, SQLITE_TRANSIENT);
	 sqlite3_bind_int(updateStmt, 3, [self.idData intValue]);
	 
	 if(SQLITE_DONE != sqlite3_step(updateStmt))
		 NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	 
	 //Reset the add statement.
	 //sqlite3_reset(updateStmt);
	 updateStmt = nil;
	 
	 
	 // Y AQUI LA PARTE DE LAT/LNG
	 
	if(updateStmt == nil) {
		const char *sql = "UPDATE prueba1 SET lat = ?, lng = ? WHERE idData = ?";
	if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
		NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
 
	 sqlite3_bind_double(updateStmt, 1, [self.lat doubleValue]);
	 sqlite3_bind_double(updateStmt, 2, [self.lng doubleValue]);
	 sqlite3_bind_int(updateStmt, 3, [self.idData intValue]);
 
	 if(SQLITE_DONE != sqlite3_step(updateStmt))
		 NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
 
	 //Reset the add statement.
	 sqlite3_reset(updateStmt);
	 updateStmt = nil;
	 
 } 

// MODIFICA SCIENTIFICNAME Y SCIENTIFICNAMEKNOWN
- (void) modifyCDato {
	
	if(updateStmt == nil) {
		const char *sql = "UPDATE prueba1 SET scientificName = ?, scientificNameKnown = ? WHERE idData = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	// AQUI ASIGNAR LOS VALORES (SCIENTIFICNAME - SEGUN SI USUARIO LO SABE O NO)
	if ([self.scientificName isEqualToString: @""])
	{
		[self setScientificName:@"Unknown"];
	}
	
	if ([self.scientificName isEqualToString: @"Unknown"])
		[self setScientificNameKnown:  [[NSNumber alloc] initWithInt:0]];
	else
		[self setScientificNameKnown:  [[NSNumber alloc] initWithInt:1]];
	
	
	sqlite3_bind_text(updateStmt, 1, [self.scientificName UTF8String],-1, SQLITE_TRANSIENT);
	sqlite3_bind_int(updateStmt, 2, [self.scientificNameKnown intValue]);
	sqlite3_bind_int(updateStmt, 3, [self.idData intValue]);
	
	if(SQLITE_DONE != sqlite3_step(updateStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	
	//Reset the add statement.
	sqlite3_reset(updateStmt);
	updateStmt = nil;
	
}

- (void) CDatoSent {
	
	if(updateStmt == nil) 
	{
		printf("\n entro en cdatosent");
		const char *sql = "UPDATE prueba1 SET pending = 0 WHERE idData = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_int(updateStmt, 1, [self.idData intValue]);
	
	printf("\n idData sent: %d", [self.idData intValue]);
	if(SQLITE_DONE != sqlite3_step(updateStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	
	//Reset the add statement.
	sqlite3_reset(updateStmt);
	updateStmt = nil;
	
	
	
}


- (void) hydrateDetailViewData {
	
	//If the detail view is hydrated then do not get it from the database.
	if(isDetailViewHydrated) return;
	
	if(detailStmt == nil) {
		const char *sql = "Select price from Coffee Where CoffeeID = ?";
		if(sqlite3_prepare_v2(database, sql, -1, &detailStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating detail view statement. '%s'", sqlite3_errmsg(database));
	}
	
	sqlite3_bind_int(detailStmt, 1, [idData intValue]);
	
	if(SQLITE_DONE != sqlite3_step(detailStmt)) {
		
		//Get the price in a temporary variable.
		NSDecimalNumber *priceDN = [[NSDecimalNumber alloc] initWithDouble:sqlite3_column_double(detailStmt, 0)];
		
		//Assign the price. The price value will be copied, since the property is declared with "copy" attribute.
		self.lat = priceDN;
		
		//Release the temporary variable. Since we created it using alloc, we have own it.
		[priceDN release];
	}
	else
		NSAssert1(0, @"Error while getting the price of coffee. '%s'", sqlite3_errmsg(database));
	
	//Reset the detail statement.
	sqlite3_reset(detailStmt);
	
	//Set isDetailViewHydrated as YES, so we do not get it again from the database.
	isDetailViewHydrated = YES;
}

- (void) saveAllData {
	
	if(isDirty) {
		
		if(updateStmt == nil) {
			const char *sql = "update Coffee Set CoffeeName = ?, Price = ? Where CoffeeID = ?";
			if(sqlite3_prepare_v2(database, sql, -1, &updateStmt, NULL) != SQLITE_OK) 
				NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
		}
		
		sqlite3_bind_text(updateStmt, 1, [nameData UTF8String], -1, SQLITE_TRANSIENT);
		sqlite3_bind_double(updateStmt, 2, [lat doubleValue]);
		sqlite3_bind_int(updateStmt, 3, [idData intValue]);
		
		if(SQLITE_DONE != sqlite3_step(updateStmt))
			NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
		
		sqlite3_reset(updateStmt);
		
		isDirty = NO;
	}
	
	//Reclaim all memory here.
	[nameData release];
	nameData = nil;
	[lat release];
	lat = nil;
	
	isDetailViewHydrated = NO;
}


- (void) dealloc {
	
	[lat release];
	[nameData release];
	[super dealloc];
}




@end
