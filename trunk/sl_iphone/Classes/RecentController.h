//
//  RecentController.h
//  SpeciesLog
//
//  Created by Administrador on 04/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CDato.h"
#import "RecentInfoItemViewController.h"

@interface RecentController : UITableViewController
{
	NSMutableArray* tablaFotosInfo;
	NSMutableDictionary* tablaFotos;
	NSString* userName;
	BOOL dataReady;
	RecentInfoItemViewController *cDatoView;
}
@property(nonatomic,retain) RecentInfoItemViewController *cDatoView;
- (id) initWithTitle: (NSString*)title;
- (id) initWithTitle: (NSString*)title iconName:(NSString*)_iconName;
- (void) loadRecentPhotos;


@end
