//
//  EasyFXCountryCell.h
//  EasyFX
//
//  Created by Errol on 9/5/11.
//  Copyright 2011 ApplyFinancial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"


@interface EasyFXCountryCell : UITableViewCell {
    Country *country;
}

- (void)setMCountry:(Country*)mCountry;

- (Country*)getCountry;

@end
