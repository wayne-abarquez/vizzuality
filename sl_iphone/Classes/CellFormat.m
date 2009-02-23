#import "CellFormat.h"

@implementation CellFormat

@synthesize nameLabel, dateLabel;
@synthesize urlImgString;
@synthesize table;


- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier 
{
	
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])
	{
		
		contentLoaded=NO;
		
		UIView *myContentView = self.contentView;		
		
		self.nameLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor whiteColor] fontSize:14.0 bold:YES];
		self.nameLabel.textAlignment = UITextAlignmentLeft; // por defecto
		[myContentView addSubview:self.nameLabel];
		[self.nameLabel release];
		
        self.dateLabel = [self newLabelWithPrimaryColor:[UIColor blackColor] selectedColor:[UIColor lightGrayColor] fontSize:10.0 bold:NO];
		self.dateLabel.textAlignment = UITextAlignmentLeft; 
		[myContentView addSubview:self.dateLabel];
		[self.dateLabel release];
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{	
	[super setSelected:selected animated:animated];
}


-(void)setData:(NSString *)name date: (NSString*)_dateLabel
{
	self.nameLabel.text = name;
	self.dateLabel.text = _dateLabel;
} 

- (void)layoutSubviews 
{	
    [super layoutSubviews];
	
	CGRect contentRect = self.contentView.bounds;	

    if (!self.editing)
	{		
        CGFloat boundsX = contentRect.origin.x;
		CGRect frame;
		
		frame = CGRectMake(boundsX + 100, 4, 200, 20);
		self.nameLabel.frame = frame;	
		frame = CGRectMake(boundsX + 100, 24, 200, 14);
		self.dateLabel.frame = frame;
	}
}

- (UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold
{
	UIFont *font;
    if (bold) 	
		font = [UIFont boldSystemFontOfSize:fontSize];
    else 
		font = [UIFont systemFontOfSize:fontSize];
	

	UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	newLabel.backgroundColor = [UIColor whiteColor];
	newLabel.opaque = YES;
	newLabel.textColor = primaryColor;
	newLabel.highlightedTextColor = selectedColor;
	newLabel.font = font;
	
	return newLabel;
}

- (void)dealloc 
{
	[nameLabel dealloc];
	[dateLabel dealloc];
	[super dealloc];
}

-(void) updateTableWithCell
{
	[self.table reloadData];
} 

- (void)loadContentThreaded;
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];	
	printf("\nURL:%s",[self.urlImgString UTF8String ]); 
	
	self.image = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString:urlImgString]]];	
	contentLoaded=YES;
	[self performSelectorOnMainThread:@selector(updateTableWithCell) withObject:nil waitUntilDone:YES];
	printf("\nIMAGEN LOADED");	
    [ pool release ];
		
}


- (void)loadContent
{
    if ( contentLoaded==NO )
	{ 	
        [ NSThread detachNewThreadSelector: @selector(loadContentThreaded) toTarget: self withObject: nil ];
    }
}

@end
