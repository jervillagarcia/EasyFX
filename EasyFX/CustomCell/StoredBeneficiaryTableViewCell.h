//
//  StoredBeneficiaryTableViewCell.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeneficiaryRec.h"

@interface StoredBeneficiaryTableViewCell : UITableViewCell {
    IBOutlet UILabel *lblBeneficiaryName;
    IBOutlet UILabel *lblBeneficiaryAddress;
    IBOutlet UIImageView *imgCountry;
    IBOutlet UILabel *lblCountry;
    BeneficiaryRec *beneficiaryRec;
}

@property(nonatomic, retain) UILabel *lblBeneficiaryName;
@property(nonatomic, retain) UILabel *lblBeneficiaryAddress;
@property(nonatomic, retain) UIImageView *imgCountry;
@property(nonatomic, retain) UILabel *lblCountry;

- (void)setBeneficiary:(BeneficiaryRec*)mBeneficiaryRec;

@end
