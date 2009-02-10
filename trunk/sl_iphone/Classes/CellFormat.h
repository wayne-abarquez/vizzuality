//
//  CellFormat.h
//  SpeciesLog
//
//  Created by Alfonso on 03/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CellFormat : UITableViewCell {
	
	
	UILabel *nameLabel;
	UILabel *dateLabel;
	
}

// Función para introducir los datos a la CELDA
-(void)setData:(NSString *)name date: (NSString*)_dateLabel; 


// Función de asociación de COLORES, FONTS, TAMAÑOS...
-(UILabel *)newLabelWithPrimaryColor:(UIColor *)primaryColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize bold:(BOOL)bold;


@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *dateLabel;


@end
