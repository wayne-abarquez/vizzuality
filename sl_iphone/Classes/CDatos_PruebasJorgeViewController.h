//
//  CDatos_PruebasJorgeViewController.h
//  SpeciesLog
//
//  Created by Alfonso on 28/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CDatos_PruebasJorgeViewController : UIViewController {
	
	IBOutlet UITextView *descripcionDetallada;
	IBOutlet UITextField *nombre;
	IBOutlet UITextField *date;
	IBOutlet UITextField *location;
	IBOutlet UIImageView *imagePhoto;
	IBOutlet UIScrollView *scrollView;
	NSNumber *idObject;
	
}

@property(nonatomic,retain) IBOutlet UITextView *descripcionDetallada;
@property(nonatomic,retain) IBOutlet UITextField *nombre;
@property(nonatomic,retain) IBOutlet UITextField *date;
@property(nonatomic,retain) IBOutlet UITextField *location;
@property(nonatomic,retain) IBOutlet UIImageView *imagePhoto;
@property(nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain) NSNumber *idObject;

- (IBAction)upDatePhoto:(id)sender;
- (IBAction)doneButtonOnKeyboardPressed: (id)sender;

@end
