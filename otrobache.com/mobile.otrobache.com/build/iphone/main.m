//
//  Appcelerator Titanium Mobile
//  WARNING: this is a generated file and should not be modified
//

#import <UIKit/UIKit.h>
#define _QUOTEME(x) #x
#define STRING(x) _QUOTEME(x)

NSString * const TI_APPLICATION_DEPLOYTYPE = @"test";
NSString * const TI_APPLICATION_ID = @"com.vizzuality.otrobache";
NSString * const TI_APPLICATION_PUBLISHER = @"Vizzuality";
NSString * const TI_APPLICATION_URL = @"http://www.vizzuality.com";
NSString * const TI_APPLICATION_NAME = @"mobile.otrobache.com";
NSString * const TI_APPLICATION_VERSION = @"1.0";
NSString * const TI_APPLICATION_DESCRIPTION = @"otrobache.com report app";
NSString * const TI_APPLICATION_COPYRIGHT = @"2010 Vizzuality";
NSString * const TI_APPLICATION_GUID = @"ea34ab7b-1833-46c2-b671-b616d2ce1162";
BOOL const TI_APPLICATION_ANALYTICS = false;

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

#ifdef __LOG__ID__
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *logPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%s.log",STRING(__LOG__ID__)]];
	freopen([logPath cStringUsingEncoding:NSUTF8StringEncoding],"w+",stderr);
	fprintf(stderr,"[INFO] Application started\n");
#endif

    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}
