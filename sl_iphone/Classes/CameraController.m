//
//  CameraController.m
//  SpeciesLog
//
//  Created by Administrador on 14/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "CameraController.h"


@implementation CameraController
@synthesize firstFoto;

- (void) loadView
{
	/*CODIGO PARA CARGAR UNA IMAGEN NEGRA DE FONDO*/
	[super loadView];
	[self loadText];
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]
											   initWithTitle:@"Retake Photo" 
											   style:UIBarButtonItemStylePlain 
											   target:self 
											   action:@selector(snap)] autorelease];
	firstFoto=YES;
}

-(void)takePhoto:(id)sender
{	
	[(UITextView *)self.view setText:[NSString stringWithFormat:@"\nLoading Camera. Please Wait."]];
	//[self snap];
}

-(void) loadText
{
	textView = [[UITextView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	
	textView.editable = NO;
	textView.textAlignment = UITextAlignmentCenter;
	//textView.font = [UIFont fontWithName:@"American Typewriter" size:20];
	textView.font = [UIFont  boldSystemFontOfSize:20];
	textView.textColor=[UIColor whiteColor];	
	textView.autoresizesSubviews = YES;
	textView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);	
	textView.backgroundColor = [UIColor blackColor];	
	self.view = textView;		
	
	lastPhoto=[[UIImageView alloc]initWithFrame:CGRectMake(94.0f,128+0.0f,128.0f,128.0f)];
	
	NSString *uniquePath = [DOCSFOLDER stringByAppendingPathComponent:@"selectedImage.png"];
	uniquePath = [NSString stringWithFormat:@"%@/%@.%@", DOCSFOLDER, @"LastPhoto", @"png"];
	
	[lastPhoto setImage:[UIImage imageWithContentsOfFile:uniquePath]];
	[textView addSubview:lastPhoto];
	
}

- (void) snap
{		
	[self presentModalViewController:[[CameraClass alloc] init] animated:YES];	
}


- (void)viewDidDisappear:(BOOL)animated
{
	printf("SE VA LA VISTA!!!\n");
}

- (void)viewWillAppear:(BOOL)animated
{ 	
	printf("VUELVE LA VISTA\n");
	NSNumber* numero=[[NSUserDefaults standardUserDefaults]objectForKey:@"lastPhotoIndex"];	
	int num=[numero intValue];
	[(UITextView *)self.view setText:[NSString stringWithFormat:@"\nNumber of photos taken with SpeciesLog:\n%d",num]];
}
- (void)viewDidAppear:(BOOL)animated 
{
	if(firstFoto==YES)
	{
		[super viewDidAppear:animated];
		[self snap];	
		firstFoto=NO;
	}
	else
	{
		NSString *uniquePath = [DOCSFOLDER stringByAppendingPathComponent:@"selectedImage.png"];
		uniquePath = [NSString stringWithFormat:@"%@/%@.%@", DOCSFOLDER, @"LastPhoto", @"png"];		
		[lastPhoto setImage:[UIImage imageWithContentsOfFile:uniquePath]];
	}
}


- (void)dealloc
{
    [super dealloc];
}


@end
