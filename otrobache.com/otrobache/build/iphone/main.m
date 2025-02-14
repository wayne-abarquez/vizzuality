//
//  Appcelerator Titanium Mobile
//  WARNING: this is a generated file and should not be modified
//

#import <UIKit/UIKit.h>
#define _QUOTEME(x) #x
#define STRING(x) _QUOTEME(x)

NSString * const TI_APPLICATION_DEPLOYTYPE = @"development";
NSString * const TI_APPLICATION_ID = @"NDA96VM566.com.vizzuality.otrobache";
NSString * const TI_APPLICATION_PUBLISHER = @"Vizzuality";
NSString * const TI_APPLICATION_URL = @"http://www.vizzuality.com";
NSString * const TI_APPLICATION_NAME = @"otrobache";
NSString * const TI_APPLICATION_VERSION = @"1.0";
NSString * const TI_APPLICATION_DESCRIPTION = @"Reporta baches de OtroBache.com";
NSString * const TI_APPLICATION_COPYRIGHT = @"2010 by Vizzuality";
NSString * const TI_APPLICATION_GUID = @"70d07ccc-1d9b-4d0b-9bf6-75b51875aba3";
BOOL const TI_APPLICATION_ANALYTICS = true;

#ifdef DEBUG
NSString * const TI_APPLICATION_RESOURCE_DIR = @"/Users/jatorre/workspace/otrobache.com/otrobache/build/iphone/build/Debug-iphonesimulator/otrobache.app";
#endif

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
