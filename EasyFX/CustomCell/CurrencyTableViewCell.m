//
//  CurrencyTableViewCell.m
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CurrencyTableViewCell.h"
#import "TransactionDetailViewController.h"

@implementation CurrencyTableViewCell

@synthesize curFrom;
@synthesize curTo;
@synthesize imgFrom;
@synthesize imgTo;
@synthesize lblPrice;
@synthesize btnBuy;
@synthesize btnAdd;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)mSelected animated:(BOOL)animated
{
    [super setSelected:mSelected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    if (state == UITableViewCellStateEditingMask) {
        [btnBuy setHidden:YES];
        [btnAdd setHidden:NO];
        if (currencyPair.isSelected) {
            [btnAdd setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        } else {
            [btnAdd setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        
    }else if (state == UITableViewCellStateDefaultMask) {
        [btnBuy setHidden:NO];
        [btnAdd setHidden:YES];
    }
}

- (void)setCurrencyPair:(PriceRec*)priceRec fromController:(UIViewController*)viewController{
    currencyPair = priceRec;
    
	fromController = viewController;

	[curFrom	setText:[currencyPair.pair substringWithRange:NSMakeRange(0,3)]];
	[imgFrom	setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) curFrom.text]]];
	
	[curTo		setText:[currencyPair.pair substringWithRange:NSMakeRange(3,3)]];
    [imgTo		setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) curTo.text]]];
    
	[lblPrice	setText:[NSString stringWithFormat:@"%.4f",[currencyPair.ask floatValue]]];

}

- (IBAction)btnBuyClick:(id)sender {
    if ([self isEditing]) {
        return;
    }
    TransactionDetailViewController *viewController = [[TransactionDetailViewController alloc] initWithNibName:@"TransactionDetailViewController" bundle:nil price:currencyPair];
    [fromController.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)btnAdd:(id)sender {
    if ([self isEditing]) {
        if(currencyPair.isSelected){
            [btnAdd setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [currencyPair setSelected:NO];
        } else {
            [btnAdd setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [currencyPair setSelected:YES];
        }
    }
}

@end
