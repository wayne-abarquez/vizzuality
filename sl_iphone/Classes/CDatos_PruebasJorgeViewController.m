//
//  CDatos_PruebasJorgeViewController.m
//  SpeciesLog
//
//  Created by Alfonso on 28/01/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CDatos_PruebasJorgeViewController.h"
#import "CDato.h"
#import "SpeciesLogAppDelegate.h"
#import "BBDD_admin.h"

@implementation CDatos_PruebasJorgeViewController

@synthesize descripcionDetallada, nombre,date,location,imagePhoto,idObject;



- (IBAction)doneButtonOnKeyboardPressed: (id)sender
{
   	printf("Veeete Retunnn");
}


- (IBAction)upDatePhoto:(id)sender {
	
	printf("Pulsado el botón!!");
	printf("Pulsado el botón!!");
	
	
	// con el id busco el objeto
	
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	int longArray = appDelegate.arrayCDato.count;
	CDato *objetoDato = [[CDato alloc] initWithPrimaryKey];
	
	for (int i=0; i<longArray; i++) {
		objetoDato = (CDato *)[appDelegate.arrayCDato objectAtIndex: i];
		if ([objetoDato.idData intValue] == [idObject intValue])
			break;
	}
	
	objetoDato.scientificName =  nombre.text;
	
	
	//Miguel aquí habría que poner el método de la BBDD para ACTUALIZAR los datos de la Foto 
	[BBDD_admin modifyData:objetoDato];	
	
	
	
	//lblMessage.text = [NSString stringWithFormat:@"First was: %@. Last was: %@", txtFirst.text, txtLast.text];
}

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

- (void)viewDidLoad {
	scrollView.contentSize = CGSizeMake(0, 600);
	[super viewDidLoad];
}


// Implement viewDidLoad to do additional setup after loading the view.
/*
- (void)viewDidLoad {
	 scrollView.contentSize = CGSizeMake(0, 600);
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}






@end
