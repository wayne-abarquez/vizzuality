//
//  RecentInfoItemViewController.h
//  SpeciesLog
//
//  Created by Alfonso on 09/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RecentInfoItemViewController : UIViewController {

	IBOutlet UILabel *nombre;
	IBOutlet UILabel *autor;
	IBOutlet UIImageView *imagePhoto;
}

@property(nonatomic,retain) IBOutlet UILabel *nombre;
@property(nonatomic,retain) IBOutlet UILabel *autor;
@property(nonatomic,retain) IBOutlet UIImageView *imagePhoto;

@end
