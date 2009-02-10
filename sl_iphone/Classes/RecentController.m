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
	NSString* stringUrl=[NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&user_id=%@&per_page=20&page=1",api_key,user_id];
	printf("\nURL TOKEN:%s",[stringUrl UTF8String]);
	NSURL* url=[NSURL URLWithString:stringUrl];
	XMLParser* 	xmlData=[[XMLParser alloc]init];
	tablaFotosInfo=[[xmlData getRecentPhotosInfo:url]copy];
	dataReady=NO;
	printf("Numero de descripciones:%d",[tablaFotosInfo count]);	
	tablaFotos=[[NSMutableDictionary alloc]initWithCapacity:0];
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated 
 {
	 [super viewDidAppear:animated];
	 if(dataReady==NO)
	 {	
		 [self	loadRecentPhotos];	
		 dataReady=YES;
		 [self.tableView reloadData];	 
		 [LoadIconClass killHUD];
	 }	
}

/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
    static NSString *CellIdentifier = @"Cell";  
	
	CellFormat *cell = (CellFormat *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];	
	if (cell == nil)
	{
		cell = [[[CellFormat alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];		
	}
	if(dataReady==YES)
	{		
		CFlickrImageData* aux=[tablaFotosInfo objectAtIndex:[indexPath row]];	
		
		[cell setData:[NSString stringWithFormat:@"Photo: %@",aux.title] date:[NSString stringWithFormat:@"Author: %@",userName]];
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		UIImage* imgAux=[tablaFotos objectForKey:[NSNumber numberWithInt:[indexPath row]]];
		if(imgAux==nil)
		{		
			[LoadIconClass startThreadHUD:self.view	Text:[NSString stringWithFormat:@"Loading %@",aux.title]];
			NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",aux.farm,aux.server,aux.user_id,aux.secret];			
			UIImage *image = [[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]]] retain];
			if (image != nil) 
			{	
				cell.image=image;			
				[tablaFotos setObject:image forKey:[NSNumber numberWithInt:[indexPath row]]];
				[image release];
				[LoadIconClass killThreadHud];
			}	
		}
		else
		{
			cell.image=imgAux;			
		}
	}	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	printf("\nPULSADO FILA");
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

-(void) tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath
{
	printf(" -- \nHola Accesory Button\n");
	SpeciesLogAppDelegate *appDelegate = (SpeciesLogAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	
	//CDato *f = (CDato *)[appDelegate.arrayCDato objectAtIndex:indexPath.row];
	
	if (self.cDatoView == nil){
		
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
	//[self.cDatoView.imagePhoto setImage:[tablaFotos objectForKey:[NSNumber numberWithInt:[indexPath row]]]];
	
	
	//PEDIMOS LA IMAGEN GRANDE
	[LoadIconClass startThreadHUD:self.view	Text:[NSString stringWithFormat:@"Loading %@",aux.title]];
	NSString* urlString=[NSString stringWithFormat:	@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",aux.farm,aux.server,aux.user_id,aux.secret];
	UIImage *imageMedium = [[UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlString]]] retain];
	if(imageMedium!=nil)
		[self.cDatoView.imagePhoto setImage:imageMedium];
	else
		[self.cDatoView.imagePhoto setImage:[tablaFotos objectForKey:[NSNumber numberWithInt:[indexPath row]]]];
	[LoadIconClass killThreadHud];
	
	[self.navigationController pushViewController:self.cDatoView animated:YES];
	
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
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
