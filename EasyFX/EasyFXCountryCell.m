    //
//  EasyFXCountryCell.m
//  EasyFX
//
//  Created by Errol on 9/5/11.
//  Copyright 2011 ApplyFinancial. All rights reserved.
//

#import "EasyFXCountryCell.h"


@implementation EasyFXCountryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMCountry:(Country*)mCountry {
    country = mCountry;
    
    [self.textLabel         setText:[country name]];
    [self.detailTextLabel   setText:[country countryCode]];
}

- (Country*)getCountry {
    return country;
}


@end
