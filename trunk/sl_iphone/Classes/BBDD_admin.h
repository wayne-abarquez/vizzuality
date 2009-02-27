//
//  BBDD_admin.h
//  SQL
//
//  Created by Alfonso on 26/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDato.h"


@interface BBDD_admin : NSObject {
	
}


+ (void) copyDatabaseIfNeeded;
+ (NSString *) getDBPath;

+ (void) removeData:(CDato *)DatoObj;
+ (NSNumber *) addData:(CDato *)DatoObj;
+ (void) addDataLatLngNames:(CDato *)DatoObj;
+ (void) modifyData:(CDato *)DatoObj;
+ (void) sentData:(CDato *)DatoObj;

@end

