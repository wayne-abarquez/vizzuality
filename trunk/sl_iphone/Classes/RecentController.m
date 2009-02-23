//
//  RecentController.m
//  SpeciesLog
//
//  Created by Administrador on 04/02/09.
//  Copyright 2009 Alfortel Telecomunicaciones. All rights reserved.
//

#import "RecentController.h"
#import "LoadIconClass.h"
#import "XMLParser.h"
#import "CellFormat.h"
#import "SpeciesLogAppDelegate.h"
#import "RecentCell.h"

@implementation RecentController

@synthesize cDatoView;

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
	printf("\n METODO INIT");
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{
	[super loadView];
	self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;		
	[self.tableView setRowHeight:80];	
	[LoadIconClass presentHUD:self.view	Text:@"Accessing Flickr"];//VERIFICAR LA FORMA DE MOSTRAR EL CARGANDO
	userName=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrUsername"];
	
	self.navigationItem.rightBarButtonItem  = [[[UIBarButtonItem alloc]
												initWithTitle:@"Reload " 
												style:UIBarButtonItemStylePlain 
												target:self 
												action:@selector(reloadAll)] autorelease];
}
-(void) reloadAll
{
	[LoadIconClass startThreadHUD:self.view Text:@"Reload Photos"];
	[self loadRecentPhotos];
	[self.tableView reloadData];	
	dataReady=YES;
	[LoadIconClass killThreadHud];
}
-(void) loadRecentPhotos
{
	NSBundle *bundle = [NSBundle mainBundle];
	NSDictionary *info = [bundle infoDictionary];
	NSString* api_key=[info objectForKey: @"FlickrApiKey"];	
	NSString* user_id=[[NSUserDefaults standardUserDefaults]objectForKey:@"FlickrNsid"];	
	NSString* stringUrl=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&user_id=%@&tags=specieslog:&per_page=20&page=1",api_key,user_id];
	printf("\nURL TOKEN:%s",[stringUrl UTF8String]);
	NSURL* url=[NSURL URLWithString:stringUrl];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	tablaFotosInfo=[[xmlData getRecentPhotosInfo:url]copy];
	dataReady=NO;
	printf("Numero de datos a cargar:%d",[tablaFotosInfo count]);
}


- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
}

- (void)loadContentForCells:(NSArray *)cells
{
	printf("\nHOLA CELDAS!!!");
    [cells retain];
    for (int i = 0; i < [cells count]; i++)
	{ 
		printf("\nEN CADA UNA DE LAS CELDAS");		
        CellFormat *cell = [[ cells objectAtIndex: i] retain];		
        if ([cell respondsToSelector: @selector(loadContent)])
            [cell loadContent];
        [cell release];
        cell = nil;
    }
    [cells release];
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView // Method is called when the decelerating comes to a stop.
{
	//printf("FIN MOVIMENTO");
	//[self.tableView reloadData];
 }


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	//printf("FIN DEL DRAG");
	//[self.tableView reloadData];	 
}

 
- (void)viewDidAppear:(BOOL)animated 
 {
	 if(dataReady==NO)
	 {
		 [super viewDidAppear:animated];
		 [self	loadRecentPhotos]; 
		 dataReady=YES;	 	 
		 [self.tableView reloadData];
		 [LoadIconClass killHUD];
	 }
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	printf("\nNUMERO DE SECCIONES");
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{	
    return [tablaFotosInfo count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	CFlickrImageData* aux=[tablaFotosInfo objectAtIndex:[indexPath row]];
    NSString *CellIdentifier = aux.title; 	
	CellFormat *cell = (CellFormat *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];	
	if (cell == nil)
	{
		printf("\nCREANDO CELDA");
		cell = [[[CellFormat alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];		
		cell.table=tableView;
	}
	if(dataReady==YES)
	{			
			
		printf("\nINDICE:%d",[indexPath row]);
		[cell setData:[NSString stringWithFormat:@"Photo: %@",aux.title] date:[NSString stringWithFormat:@"Author: %@",userName]];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;		
		NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",aux.farm,aux.server,aux.user_id,aux.secret];
		cell.urlImgString=urlString;			
		[cell loadContent];//img load in an NSThread
	}	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	printf("\nPULSADO FILA");printf(" -- \nHola Accesory Button\n");
	
	//SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
	//CDato *f = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
	
	if (self.cDatoView == nil)
	{	
		//Cargo la Vista desde el NIB en lugar de utilizar el método loadView
		printf("-- Crgo la vista\n");
		RecentInfoItemViewController *viewController = [[RecentInfoItemViewController alloc] initWithNibName:@"RecentViewController" bundle:[NSBundle mainBundle]];
		self.cDatoView = viewController;
		[viewController release];
	}
	printf(" Siguiente paso...\n");
	// Añadimos el título y un botón a la barra de navegación...
	[self.navigationController pushViewController:self.cDatoView animated:YES];
	
	CFlickrImageData* aux=[tablaFotosInfo objectAtIndex:[indexPath row]];
	//NOMBRE DE LA FOTO
	self.cDatoView.title =@"Image Info";	
	// Escribimos los datos en el formulario...	
	[self.cDatoView.autor setText:userName];
	[self.cDatoView.nombre setText:aux.title];
	
	NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",aux.farm,aux.server,aux.user_id,aux.secret];
	[ NSThread detachNewThreadSelector: @selector(loadBigImgThreaded:) toTarget: self withObject: urlString ];
	
	[self.navigationController pushViewController:self.cDatoView animated:YES];	
}

-(void) tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath
{
	printf(" -- \nHola Accesory Button\n");
	
	//SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];	
	//CDato *f = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
	
	if (self.cDatoView == nil)
	{	
		//Cargo la Vista desde el NIB en lugar de utilizar el método loadView
		printf("-- Crgo la vista\n");
		RecentInfoItemViewController *viewController = [[RecentInfoItemViewController alloc] initWithNibName:@"RecentViewController" bundle:[NSBundle mainBundle]];
		self.cDatoView = viewController;
		[viewController release];
	}
	printf(" Siguiente paso...\n");
	// Añadimos el título y un botón a la barra de navegación...
	[self.navigationController pushViewController:self.cDatoView animated:YES];
	
	CFlickrImageData* aux=[tablaFotosInfo objectAtIndex:[indexPath row]];
	//NOMBRE DE LA FOTO
	self.cDatoView.title =@"Image Info";	
	// Escribimos los datos en el formulario...	
	[self.cDatoView.autor setText:userName];
	[self.cDatoView.nombre setText:aux.title];
	
	NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",aux.farm,aux.server,aux.user_id,aux.secret];
	[ NSThread detachNewThreadSelector: @selector(loadBigImgThreaded:) toTarget: self withObject: urlString ];
			
	[self.navigationController pushViewController:self.cDatoView animated:YES];
}

- (void)loadBigImgThreaded:(NSString*) urlString
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//[LoadIconClass startThreadHUD:self.view	Text:@"Loading"];
	UIImage *imageMedium = [[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]]] retain];
	if(imageMedium!=nil)
		[self.cDatoView.imagePhoto setImage:imageMedium];
	//[LoadIconClass killThreadHud];
    [ pool release ];	
}

- (void)dealloc 
{
    [super dealloc];
}


@end

/*
CellFormat *cell = (CellFormat *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

if (cell == nil)
{
	cell = [[[CellFormat alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	
}

CDato_PruebasJorge *f = (CDato_PruebasJorge *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
[cell setData:f.nombre date:f.nombre];

cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
cell.hidesAccessoryWhenEditing = YES;    


//***** Gestión de las imágenes en las celdas
fileList = [[[[NSFileManager defaultManager] directoryContentsAtPath:DOCSFOLDER]
			 pathsMatchingExtensions:[NSArray arrayWithObjects:@"png", nil]] retain];



printf("imagen:%s\n",[[fileList objectAtIndex:1] UTF8String]);

NSString *selectedPath = [DOCSFOLDER stringByAppendingPathComponent:f.pathImagen];
printf("--------------- imagen:%s\n",[selectedPath UTF8String]);

if([[NSFileManager defaultManager] fileExistsAtPath:selectedPath])
{
	UIImage * imagenOriginal = [UIImage imageWithContentsOfFile:selectedPath];
	
	UIImage *img = [imagenOriginal _imageScaledToSize:CGSizeMake(64.0f, 64.0f) interpolationQuality:1];
	cell.image = img;
}
*/
