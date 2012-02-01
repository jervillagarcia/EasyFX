//
//  CurrencyTableViewCell.m
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CurrencyTableViewCell.h"

@implementation CurrencyTableViewCell

@synthesize curFrom;
@synthesize curTo;
@synthesize imgFrom;
@synthesize imgTo;
@synthesize lblPrice;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCurrencyPair:(PriceRec*)priceRec {
    currencyPair = priceRec;

	[curFrom	setText:[currencyPair.pair substringWithRange:NSMakeRange(0,3)]];
	[imgFrom	setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) curFrom.text]]];
	
	[curTo		setText:[currencyPair.pair substringWithRange:NSMakeRange(3,3)]];
    [imgTo		setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) curTo.text]]];
    
	[lblPrice	setText:[NSString stringWithFormat:@"%.4f",[currencyPair.ask floatValue]]];

}

@end
