#import "CellFormat.h"

@implementation CellFormat

@synthesize nameLabel, dateLabel;


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		
		// Necesitamos un objeto del tipo UIView para colocar nuestras Labels... Podrí por tanto hacerse con el IBuilder ;-)
		UIView *myContentView = self.contentView;
		
		/*
		 Inicializamos la etiqueta,
		 seleccionamos la alineación por dfecto a la izquierda,
		 añadimos la etiqueta a la vista creada (que será realmente una subView)
		 */
		
		self.nameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:YES];
		self.nameLabel.textAlignment = UITextAlignmentLeft; // por defecto
		[myContentView addSubview:self.nameLabel];
		[self.nameLabel release];
		
		/*
		 Inicializamos aquí la segunda etiqueta (aquí vemos la diferencia de COLOR, y FUENTE...)
		*/
        self.dateLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.dateLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.dateLabel];
		[self.dateLabel release];
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	
	[super setSelected:selected animated:animated];
	

}

/*
 Esta función l empleamos para cargar la información en las etiquetas
 pasándole los parámetros necesarios (tantos como etiquetas tengamos )
 */

-(void)setData:(NSString *)name date: (NSString*)_dateLabel
{
	self.nameLabel.text = name;
	self.dateLabel.text = _dateLabel;
} 

/*
Esta función se encargará de cargar el "layout" de las subviews para la CELL
 Si la CELL no está en modo de EDICION (lo normal...), la posicionamos...
 */
- (void)layoutSubviews {
	
    [super layoutSubviews];
	
	// Obtenemos el tamaño de la CELDA
    CGRect contentRect = self.contentView.bounds;
	

    if (!self.editing)
	{
		
		// Obtenemos el pixel X de origen
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
        /*
		 Colocamos las etiquetas:
		 lo colocamos en la coordenada de la current X + 100 pixels para desplazarlo al centro
		 la colocamos 4 pixels from the top
		 y seteamos el ancho a 200 pixels
		 y la altura de 20 pixels
		 */
		frame = CGRectMake(boundsX + 100, 4, 200, 20);
		self.nameLabel.frame = frame;
		
	
		frame = CGRectMake(boundsX + 100, 24, 200, 14);
		self.dateLabel.frame = frame;
	}
}

/*
  Funcion para aplicar el ESTILO de FUENTE y TAMAÑO
 */
- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	/*
	 Creamos y configuramos la FONT
	 */
	
    UIFont *font;
    if (bold) {
        font = [UIFont boldSystemFontOfSize:fontSize];
    } else {
        font = [UIFont systemFontOfSize:fontSize];
    }
	

	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (void)dealloc {
	// Liberamos la memoria...
	[nameLabel dealloc];
	[dateLabel dealloc];
	[super dealloc];
}

@end
