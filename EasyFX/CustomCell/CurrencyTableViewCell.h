//
//  CurrencyTableViewCell.h
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceRec.h"

@interface CurrencyTableViewCell : UITableViewCell {
    PriceRec *currencyPair;
    IBOutlet UILabel *curFrom;
    IBOutlet UILabel *curTo;
    IBOutlet UIImageView *imgFrom;
    IBOutlet UIImageView *imgTo;
    IBOutlet UILabel *lblPrice;
    IBOutlet UIButton *btnBuy;
    IBOutlet UIButton *btnAdd;
    UIViewController *fromController;
}

@property(nonatomic, retain) UIButton *btnBuy;
@property(nonatomic, retain) UIButton *btnAdd;
@property(nonatomic, retain) UILabel *curFrom;
@property(nonatomic, retain) UILabel *curTo;
@property(nonatomic, retain) UIImageView *imgFrom;
@property(nonatomic, retain) UIImageView *imgTo;
@property(nonatomic, retain) UILabel *lblPrice;

- (void)setCurrencyPair:(PriceRec*)priceRec fromController:(UIViewController*)viewController;
- (IBAction)btnBuyClick:(id)sender;

@end
