//
//  StoredBeneficiaryTableViewCell.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "StoredBeneficiaryTableViewCell.h"

@implementation StoredBeneficiaryTableViewCell

@synthesize lblBeneficiaryName;
@synthesize lblBeneficiaryAddress;
@synthesize imgCountry;
@synthesize lblCountry;

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

- (void)setBeneficiary:(BeneficiaryRec*)mBeneficiaryRec {
    beneficiaryRec = mBeneficiaryRec;
    
    [lblBeneficiaryName     setText:[mBeneficiaryRec beneficiaryName]];
    [lblBeneficiaryAddress  setText:[mBeneficiaryRec getBankAddress]];
    [imgCountry             setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) [[mBeneficiaryRec countryCode] lowercaseString]]]];
    [lblCountry             setText:[mBeneficiaryRec countryCode]];
    
}


@end
