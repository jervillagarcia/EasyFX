//
//  CurrencyTableViewCell.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceRec.h"
#import "EasyFXPreloader.h"

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
    UIColor *blueGradient;

    NSArray *beneficiaryList;
    NSMutableArray *filteredBenList;
    
    EasyFXPreloader *preloadView;
    NSMutableArray *selCountryList;
    NSArray *tempList;

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
