//
//  CameraClass.m
//  SpeciesLog
//
//  Created by Administrador on 14/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "CameraClass.h"
#import "SpeciesLogAppDelegate.h"

#import "CDato.h";
#import "BBDD_admin.h";

@implementation CameraClass


@synthesize lastPhotoIndex;
@synthesize	tookPhoto;
@synthesize miImg;

- (id) init
{
	
	//SUPER CLASE
	if (!(self = [super init])) 
		return self;	
	//CAMARA
	if ([UIImagePickerController isSourceTypeAvailable:SOURCETYPE])	
	{
		self.sourceType = SOURCETYPE;
		self.allowsImageEditing = YES;
		self.delegate = self;
	}	
	//INDICE DE FOTO
	[self loadLastPhotoIndex];
	tookPhoto=NO;	
	
	return self;
}

-(int) loadLastPhotoIndex
{
	NSNumber* numero=[[NSUserDefaults standardUserDefaults]objectForKey:@"lastPhotoIndex"];
	lastPhotoIndex=[numero intValue];
	printf("\nlastPhotoIndex del archivo de datos=%d\n",lastPhotoIndex);	
	return lastPhotoIndex;
}

//METODO PARA CREAR LA INTERFAZ DE LA CAMARA
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{		
	[[self parentViewController] dismissModalViewControllerAnimated:YES];	
	[picker release];
}


//METODO QUE SE EJECUTA AL PULSAR HACER FOTO EN LA CAMARA
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{	
	self.miImg=image;
	miEditInfo=editingInfo;
	miPicker=picker;
	[self showGetInfoPanel];	
}


-(void) showGetInfoPanel
{
	UIAlertView *alert = [[UIAlertView alloc] 
						  initWithTitle: @"" 
						  message:@""
						  delegate:self
						  cancelButtonTitle:@"Save"
						  otherButtonTitles:@"Don't Know Name", @"Cancel",nil];
	
	[alert addTextFieldWithValue:@"" label:@"Enter Name"];
	//Configuracion del campo de texto
	UITextField *tf = [alert textFieldAtIndex:0];	
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	tf.keyboardType = UIKeyboardTypeAlphabet;
	tf.keyboardAppearance = UIKeyboardAppearanceAlert;
	tf.autocapitalizationType = UITextAutocapitalizationTypeWords;
	tf.autocorrectionType = UITextAutocorrectionTypeNo;
	
	[alert show];
	
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	printf("User Pressed Button %d\n", buttonIndex);
	
	// AQUI RECUPERAMOS EL NOMBRE CIENTIFICO QUE HA ESCRITO EL USUARIO (Y COMPROBAMOS QUE NO ES UNA CADENA VACIA)
	printf("Text Field: %s\n", [[[alertView textFieldAtIndex:0] text] cStringUsingEncoding:1]);
	NSString *writtenName = [[alertView textFieldAtIndex:0] text];
	
	if(buttonIndex==1)//Don't know
	{
		// AQUI PONEMOS PASAMOS COMO PARAMETRO UNA CADENA VACIA, Y ASI SABEMOS QUE SCIENTIFICNAMEKNOWN=0
		[self savePhotoToDocuments:self.miImg editingInfo:miEditInfo scientificName: writtenName];
		[self saveToPhotoAlbum:self.miImg];
		self.lastPhotoIndex++;	
		[self	saveToDiskLastPhotoIndex];	
	//	[gps	startLocation];		
	}
	else if(buttonIndex == 0)//save
	{		
		// Y PASAREMOS EL NOMBRECIENTIFICO COMO PARAMETRO DE ESTE METODO
		[self	savePhotoToDocuments:self.miImg editingInfo:miEditInfo scientificName: writtenName];
		[self saveToPhotoAlbum:self.miImg];
		self.lastPhotoIndex++;	
		[self	saveToDiskLastPhotoIndex];	
	//	[gps	startLocation];	
		//[[UIApplication sharedApplication].delegate saludar];
	}
	else //cancel
	{
		
	}	
	//SALIMOS DE LA ALERTA
	[alertView release];	
	//SALIMOS DE LA CLASE CAMARA
	[[self parentViewController] dismissModalViewControllerAnimated:YES];
	[miPicker release];
	
}

-(void) saveToDiskLastPhotoIndex
{	
	NSNumber *numero=[[NSNumber alloc]initWithInt:self.lastPhotoIndex];
	[[NSUserDefaults standardUserDefaults] setObject:numero forKey:@"lastPhotoIndex"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
}

-(void) savePhotoToDocuments:(UIImage *)image editingInfo:(NSDictionary *)editingInfo scientificName:(NSString *)message
{	
		
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	CDato *imgData = [[CDato alloc] initWithPrimaryKey];
	
	NSString* user_id=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrNsid"];
	
	if ([message isEqualToString: @""])
	{
		[imgData setScientificName:@"Unknown"];
		[imgData setScientificNameKnown:  [[NSNumber alloc] initWithInt:0]];
	}
	else 
	{
		[imgData setScientificName:message];
		[imgData setScientificNameKnown:  [[NSNumber alloc] initWithInt:1]];
	}
	[imgData setPending:  [[NSNumber alloc] initWithInt:1]];	
	
	// AÑADO DATO, Y OBTENGO EL ID ASIGNADO EN LA BBDD
	NSNumber *idTemp = [BBDD_admin addData:imgData];
	[imgData setIdData:idTemp];
	
	// AQUI LLAMAR A METODO QUE ME DEVUELVE LOS VALORES DE LAT Y LNG 
	NSNumber* lat=[NSNumber numberWithFloat:appDelegate.gps.lat];
	NSNumber* lon=[NSNumber numberWithFloat:appDelegate.gps.lon];
	printf("\n\n lat:%f,lon:%f",appDelegate.gps.lat,appDelegate.gps.lon);
	[imgData setLat: lat];
	[imgData setLng: lon];
	
	
	//NOMBRE FOTO	 
	imgData.nameData =	[NSString stringWithFormat:@"%@_%@-%d", @"specieslog",user_id,[idTemp intValue]];
	imgData.imageURL =[NSString stringWithFormat:@"%@_%@-%d.%@", @"specieslog",user_id,[idTemp intValue],@"png"];
	
	
	// ESCRIBIR EN BBDD LA LAT/LNG, NAMEDATA Y IMAGEURL
	[BBDD_admin addDataLatLngNames: imgData];		
	
	// ASIGNAR IMAGEN A IMAGEURL RECIEN CREADA
	NSString *uniquePath =  [NSString stringWithFormat:@"%@/%@_%@-%d.%@", DOCSFOLDER, @"specieslog",user_id, /*lastPhotoIndex*/[idTemp intValue], @"png"];	
	[UIImagePNGRepresentation(image)  writeToFile: uniquePath atomically:YES];
	
	//ESCRITURA EN ARRAY GLOBAL
	[appDelegate.arrayCDato addObject:imgData];	

	//HAY Q GUARDAR LA LAST FOTO PARA QUE LA MUESTRE EN PANTALLA DEL CAMARA
	NSString *uniquePath2 = [NSString stringWithFormat:@"%@/%@.%@", DOCSFOLDER, @"LastPhoto", @"png"];
	[UIImagePNGRepresentation(image)  writeToFile: uniquePath2 atomically:YES];
}

-(void) saveToPhotoAlbum:(UIImage*)img
{
	//LA FUNCION RECIBE TB COMO  PARAMETROS FUNCIONES CALLBACK PARA CUANDO HAYA TERMINADO DE GUARDAR LA FOTO
	UIImageWriteToSavedPhotosAlbum(img,nil,nil,nil);
	printf("\nSaved img");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning]; 
}

- (void)dealloc 
{    
	[super dealloc];	
}


@end
