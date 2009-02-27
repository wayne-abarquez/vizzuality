//
//  PendingController.m
//  SpeciesLog
//
//  Created by Administrador on 22/01/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "PendingController.h"
#import "CDato.h"
#import "BBDD_admin.h"
#import "SpeciesLogAppDelegate.h"
#import "CellFormat.h"
#import "LoadIconClass.h"
#import "XMLParser.h"
#import "MD5Class.h"


@implementation PendingController
@class SpeciesLogAppDelegate;
@synthesize cDatoView;




- (void)viewDidLoad {
    
	// Inicializamos características de la tabla y del NavigationController asociado
	[self.tableView setRowHeight:74];
	self.title=@"Pending";
	self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
	printf(" Inicializamosssss ");
	
	
	
    // Añadimos los botones 
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc]
												initWithTitle:@"Upload " 
												style:UIBarButtonItemStylePlain 
												target:self 
												action:@selector(UploadAllPhotos)] autorelease];
	[self loadApiSignatureData];
}



#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
		printf(" Inicializamos Numbre Of Sections... ");
    return 1;
}


// -- Le indicamos el número de filas que tiene la tabla
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	// Para poder acceder a algún objeto que pertenezca a la clase AppDelegate tenemos que emplear la siguiente construcción:
	printf(" Inicializamos Numbre Of ROws In Section... ");
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegate.arrayCDato.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
   
	printf(" Inicializa la tabla ");
    static NSString *CellIdentifier = @"MyID";	
	
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
    CellFormat *cell = (CellFormat *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		cell = [[[CellFormat alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];		
	}
	
	printf("\n arraycount -> %d",appDelegate.arrayCDato.count);
    CDato *f = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
	[cell setData:f.scientificName date:f.dateTime];	
	
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.hidesAccessoryWhenEditing = YES;     
	NSString *selectedPath = [DOCSFOLDER stringByAppendingPathComponent:f.imageURL];	
	if([[NSFileManager defaultManager] fileExistsAtPath:selectedPath])
	{
		UIImage * imagenOriginal = [UIImage imageWithContentsOfFile:selectedPath];	
		UIImage *img = [imagenOriginal _imageScaledToSize:CGSizeMake(64.0f, 64.0f) interpolationQuality:1];
		cell.image = img;
	}
	else
		printf("\nIMG NO ENCONTRADA*******************************************\n");
	
    return cell;
}

// METODO PARA BORRAR CDATO DE BBDD
- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	printf("he borrado");
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if(editingStyle == UITableViewCellEditingStyleDelete) {
		
		//Get the object to delete from the array.
		CDato *dataObj = [appDelegate.arrayCDato objectAtIndex:indexPath.row];
		
		printf("\n el id del cdato borrado es: %d", [dataObj.idData intValue]);
		
		[BBDD_admin removeData:dataObj];
		 
		
		//Delete the object from the table.
		[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self	showDetailedView:indexPath];
}

-(void) tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath
{
	[self showDetailedView:indexPath];
}

-(void) showDetailedView: (NSIndexPath *)indexPath
{
	printf("FILA PULSADA:%d",indexPath.row);
	//almacenamos el indice de la foto
	indexPhotoUpload=indexPath.row;
	
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
	CDato *imgInfo = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
	
	if (self.cDatoView == nil)
	{		
		PendingDataViewController *viewController = [[PendingDataViewController alloc] initWithNibName:@"PendingViewController" bundle:[NSBundle mainBundle]];
		self.cDatoView = viewController;
		self.cDatoView.idObject = [imgInfo idData];
		[viewController release];
	}
	
	[self.navigationController pushViewController:self.cDatoView animated:YES];	
	self.cDatoView.title = [imgInfo scientificName];	
	UIBarButtonItem *botonUpdatePhoto = [[[UIBarButtonItem alloc]
										  initWithTitle:@"Upload Photo"
										  style:UIBarButtonItemStylePlain
										  target:self
										  action:@selector(uploadOnePhoto)]
										  autorelease];	
	self.cDatoView.navigationItem.rightBarButtonItem = botonUpdatePhoto;	
	// Escribimos los datos en el formulario...	
	//[self.cDatoView.descripcionDetallada setText:[f scientificName]];
	[self.cDatoView.nombre setText:[imgInfo scientificName]];
    [self.cDatoView.date setText:[imgInfo dateTime]];
	[self.cDatoView.location setText: [NSString stringWithFormat:@"Latitude: %3.3f - Longitude: %3.3f",[imgInfo.lat floatValue],[imgInfo.lng floatValue]]];	
	NSString *selectedPath = [DOCSFOLDER stringByAppendingPathComponent:imgInfo.imageURL];
	if([[NSFileManager defaultManager] fileExistsAtPath:selectedPath])
	{
		UIImage * imagenOriginal = [UIImage imageWithContentsOfFile:selectedPath];		
		UIImage *img = [imagenOriginal _imageScaledToSize:CGSizeMake(206.0f, 206.0f) interpolationQuality:1];		
		[self.cDatoView.imagePhoto setImage:img];
	}	
	
}

-(void) DeletePhotosFromFolder:(NSString*)folder FileName:(NSString*)fileName
{
	NSString *selectedPath = [folder stringByAppendingPathComponent:fileName];
	
	printf("\nVerifing acces to file");
	BOOL canWrite = [[NSFileManager defaultManager] isWritableFileAtPath: selectedPath];
	if (! canWrite) 
	{
		NSString *alertMessage = [NSString stringWithFormat: @"Cannot delete %@", fileName];
		UIAlertView *cantWriteAlert =
		[[UIAlertView alloc] initWithTitle:@"Not permitted:" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[cantWriteAlert show];
		[cantWriteAlert release];
		return;
	}		
	printf("\nTry to Delete:%s", [selectedPath	UTF8String]);
	NSError *err = nil;
	if (! [[NSFileManager defaultManager] removeItemAtPath: selectedPath error:&err])
	{
		NSString *alertMessage = (err == noErr) ?
		[NSString stringWithFormat: @"Cannot delete %@", fileName] :
		[NSString stringWithFormat: @"Cannot delete %@, %@", fileName, [err localizedDescription]];
		UIAlertView *cantDeleteAlert =[[UIAlertView alloc] initWithTitle:@"Can't delete:" message:alertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[cantDeleteAlert show];
		[cantDeleteAlert release];
		return;
	}
	printf("\nDelete Succes");	
}


-(int) LoadFileList
{
	fileList = [[[[NSFileManager defaultManager] directoryContentsAtPath:DOCSFOLDER]
				 pathsMatchingExtensions:[NSArray arrayWithObjects:@"png", nil]] retain];	
	return [fileList count];
}

-(void) ShowAlert:(NSString*)tittle Text:(NSString*)text
{
	UIAlertView * alert =[[UIAlertView alloc] initWithTitle:tittle message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

-(void) loadApiSignatureData
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];
	api_key=[info objectForKey: @"FlickrApiKey"];
	secret=[info objectForKey: @"FlikcrSecret"];
	token=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrToken"];	
	
}


- (void) uploadOnePhoto
{
	printf("\nUPLOAD PHOTO:%d",indexPhotoUpload);
	justOnePhoto=YES;
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
	CDato *imgData = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPhotoUpload];
	if(imgData)
	{
		[LoadIconClass startThreadHUD:self.cDatoView.view Text:[NSString stringWithFormat:@"Uploading\n %@",imgData.scientificName]];
		//[LoadIconClass presentHUD:self.view Text:[NSString stringWithFormat:@"Uploading\n %@",imgData.scientificName]];
		[self	UploadData:imgData.imageURL Description:imgData.scientificName];
	}	
}

-(void) UploadAllPhotos
{
	justOnePhoto=NO;
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
	printf("\n PENDIENTES DE ENVIAR -> %d",appDelegate.arrayCDato.count);
	if(appDelegate.arrayCDato.count>0)
	{
		CDato *imgData = (CDato *)[appDelegate.arrayCDato objectAtIndex:0];
		if(imgData)
		{
			[LoadIconClass presentHUD:self.view Text:[NSString stringWithFormat:@"Uploading\n %@",imgData.scientificName]];
			[self	UploadData:imgData.imageURL Description:imgData.scientificName];
		}		
	}
	else
		[self	ShowAlert:@"Upload Info" Text:@"No more photos to upload"];
	   
	
}


-(void) UploadData:(NSString*)imgName Description:(NSString*)desc
{
	
	NSString* imgPath = [DOCSFOLDER stringByAppendingPathComponent:imgName];	
	
		
	//api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@auth_token%@description%@tagsspecieslog:",secret,api_key,token,desc]];
	api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@api_key%@auth_token%@description%@tagsspecieslog:species=%@",secret,api_key,token,desc,desc]];
	
	//creating the url request:
	NSURL *cgiUrl = [NSURL URLWithString:@"http://api.flickr.com/services/upload/"];
	NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:cgiUrl];
	
	//adding header information:
	[postRequest setHTTPMethod:@"POST"];	
	NSString *stringBoundary = [NSString stringWithString:@"---------------------------7d44e178b043a"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",stringBoundary];
	[postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
	[postRequest addValue:@"api.flickr.com" forHTTPHeaderField: @"Host"];		
	
	//setting up the body:
	NSMutableData *postBody = [NSMutableData data];
	[postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"api_key\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"%@",api_key] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"auth_token\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"%@",token] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"description\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"%@",desc] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"tags\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"specieslog:species=%@",desc] dataUsingEncoding:NSUTF8StringEncoding]];
	//[postBody appendData:[[NSString stringWithString:@"specieslog:,specieslog:species="] dataUsingEncoding:NSUTF8StringEncoding]];
		
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Disposition: form-data; name=\"api_sig\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"%@",api_sig] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"%@\"\r\n",imgPath] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[[NSString stringWithString:@"Content-Type: image/jpeg\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	[postBody appendData:[NSData dataWithContentsOfFile:imgPath]];
	[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	//MORE HEADER INFO
	[postRequest addValue:[NSString stringWithFormat:@"%d",[postBody length]] forHTTPHeaderField: @"Content-Length"];	
	[postRequest setHTTPBody:postBody];
	
	
	NSURLConnection *connectionResponse = [[NSURLConnection alloc] initWithRequest:postRequest delegate:self];
	
	if (!connectionResponse)
	{
		NSLog(@"Failed to submit request");
	}
	else
	{
		NSLog(@"--------- Request submitted ---------");
		NSLog(@"connection: %@ method: %@, encoded body: %@:", connectionResponse, [postRequest HTTPMethod]);
		NSLog(@"New connection retain count: %d", [connectionResponse retainCount]);
	}	
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	printf("\nRESPUESTA:\n");	
	NSLog(@"response:",response);
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	printf("\nRECIBI DATA:\n");	
	//NSLog(@"DATA:", data);
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	NSString* res=[[xmlData parseXMLData:data]copy];
	
	if([xmlData.statValue isEqualToString:@"ok"])
	{
		//FOTO SUBIDA CORRECTAMENTE ASI Q ENVIAR LAS COORDENADAS
		printf("ID:%s\n COMIENZO DEL PROCESO DE FIRMA DE LAS COORDENADAS",[res UTF8String]);
				
		SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
		CDato *imgData;
		if(justOnePhoto==YES)
			imgData = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPhotoUpload];	
		else
			imgData = (CDato *)[appDelegate.arrayCDato objectAtIndex:0];		
		
		NSNumber* accuaracy=[NSNumber numberWithInt:16];			
		//FIRMA MAS LLAMADA AL METODO CORRESPONDIENTE
		api_sig = [MD5Class stringToMD5:[NSString stringWithFormat:@"%@accuracy%dapi_key%@auth_token%@lat%flon%fmethodflickr.photos.geo.setLocationphoto_id%@",
												   secret,[accuaracy intValue],api_key,token,[imgData.lat floatValue],[imgData.lng floatValue],res]];		
		NSString* stringUrl=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.geo.setLocation&api_key=%@&photo_id=%@&lat=%f&lon=%f&accuracy=%d&auth_token=%@&api_sig=%@",
							 api_key,res,[imgData.lat floatValue],[imgData.lng floatValue],[accuaracy intValue],token,api_sig];
		 
		NSURL* url=[NSURL URLWithString:stringUrl];
		XMLParser* 	xmlData2=[[XMLParser alloc]init];
		NSString* resCoord=[[xmlData2 parseXMLFile:url] copy];		
		if([xmlData2.statValue isEqualToString:@"ok"])
		{			
			printf("SEND COMPLETED");
			[BBDD_admin sentData:imgData];
			[self DeletePhotosFromFolder:DOCSFOLDER FileName:imgData.imageURL];
			if(justOnePhoto==YES)
			{
				printf("\n Se elimina la fila:%d",indexPhotoUpload);
				[LoadIconClass killHUD];
				justOnePhoto=NO;				
				[self.cDatoView.navigationController popToRootViewControllerAnimated:YES];
				[appDelegate.arrayCDato removeObjectAtIndex:indexPhotoUpload];
				[self.tableView reloadData];
			}
			else
			{
			
				[appDelegate.arrayCDato removeObjectAtIndex:0];
				printf("\n PENDIENTES DE ENVIAR -> %d",appDelegate.arrayCDato.count);			
				if(appDelegate.arrayCDato.count>0)
				{
					[self.tableView reloadData];
					[self UploadAllPhotos];
				}
				else
				{
					[self.tableView reloadData];
					[self	ShowAlert:@"Upload Info" Text:@"Upload Succes"];
					[LoadIconClass killHUD];
				}
			}
		}	
		else
			[LoadIconClass killHUD];
	}
	else
	{
		[self.tableView reloadData];
		[self	ShowAlert:@"Unable to Upload" Text:@"Sorry, the Flickr API service is not currently available"];
		[LoadIconClass killHUD];
	}
	
}

- (void) updatePhoto
{
	printf("Pulsado Botón de UPDATE PHOTO");	
	//TENDREDMOS QUE BUSCAR LA FOTO QUE QUEREMOS ENVIAR 
	//LLAMAR A LA FUNCION DE ENVIAR PERO CON ALGUN PARAMETRO QUE PARE LA EJECUCION EN CICLO.
	//AL TERMINAR DESHABILITAR ESE PARAMETRO
	
}

- (void)viewWillAppear:(BOOL)animated
{ 
	[super viewWillAppear:animated];
	//[(UITextView *)self.view setText:[NSString stringWithFormat:@"\nNumber of photos pending to sent with SpeciesLog:\n%d",num]];
}

- (void)viewDidAppear:(BOOL)animated
{
	printf("VUELVE LA VISTA PENDIIIIING \n");
	[self.tableView reloadData];
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

- (id) initWithTitle: (NSString*)title
{
	if (self = [super init]) 
	{
		self.title = title;		
	}
	return self;
}

- (id) initWithTitle: (NSString*)title iconName:(NSString*)_iconName
{
	if (self = [super init]) 
	{
		self.title = title;	
		self.tabBarItem.image = [UIImage imageNamed:_iconName];
	}
	return self;
}



@end

