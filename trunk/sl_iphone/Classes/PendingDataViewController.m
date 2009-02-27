//
//  CDatos_PruebasJorgeViewController.m
//  SpeciesLog
//
//  Created by Alfonso on 28/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
#import "PendingDataViewController.h"
#import "CDato.h"
#import "SpeciesLogAppDelegate.h"
#import "BBDD_admin.h"

@implementation PendingDataViewController

@synthesize descripcionDetallada, nombre,date,location,imagePhoto,idObject;


- (IBAction)doneButtonOnKeyboardPressed: (id)sender
{
   	printf("Veeete Retunnn");
}


- (IBAction)upDatePhoto:(id)sender 
{
	
	printf("Pulsado el botón!!");
	printf("Pulsado el botón!!");	
	
	// con el id busco el objeto
	
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	int longArray = appDelegate.arrayCDato.count;
	CDato *objetoDato = [[CDato alloc] initWithPrimaryKey];
	
	for (int i=0; i<longArray; i++) 
	{
		objetoDato = (CDato *)[appDelegate.arrayCDato objectAtIndex: i];
		if ([objetoDato.idData intValue] == [idObject intValue])
			break;
	}	
	objetoDato.scientificName =  nombre.text;
	
	[BBDD_admin modifyData:objetoDato];	
	[self.navigationController popViewControllerAnimated:YES];
	
}


- (void)viewDidLoad
{
	scrollView.contentSize = CGSizeMake(0, 600);
	[super viewDidLoad];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
