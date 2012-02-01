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
}

@property(nonatomic, retain) UILabel *curFrom;
@property(nonatomic, retain) UILabel *curTo;
@property(nonatomic, retain) UIImageView *imgFrom;
@property(nonatomic, retain) UIImageView *imgTo;
@property(nonatomic, retain) UILabel *lblPrice;

- (void)setCurrencyPair:(PriceRec*)priceRec;

@end
