//
//  UIProgressHUD.h
//  SpeciesLog
//
//  Created by Administrador on 03/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadIconClass : NSObject
{
}

//METODOS PARA LANZAR LA INFOWINDOW EN UN SEGUNDO HILO
+(void) startThreadHUD:(UIView*)vista  Text:(NSString*)text;
+(void) killThreadHud;
//METODOS PARA EL MISMO HILO, UNICAMENTE UTILES SI LO METEMOS EN CALLBACK ASOCIADAS A PROTOCOLOS
+ (void) killHUD;
+ (void) updateHUDText:(NSString*)text;
+ (void) presentHUD:(UIView*)vista Text:(NSString*)text;
+ (void) presentHUD:(UIView*)vista Text:(NSString*)text Delay:(float)delay;
+ (BOOL) isLoading;

@end

@interface UIProgressHUD : NSObject
- (void) show: (BOOL) yesOrNo;
- (UIProgressHUD *) initWithWindow: (UIView *) window;


@end

static id miHUD=nil;
static NSThread* miThread=nil;
static NSString* HUDInfoText=nil;
static NSAutoreleasePool* HUDpool;
static BOOL loading=NO;



