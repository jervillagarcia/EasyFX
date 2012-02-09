//
//  ExistingBeneficiaryViewController.h
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeneficiaryRec.h"

@interface ExistingBeneficiaryViewController : UIViewController {
    IBOutlet UILabel        *lblBeneficiaryName;
    IBOutlet UILabel        *lblBeneficiaryAddress;
    IBOutlet UILabel        *lblCountry;
    IBOutlet UIImageView    *imgCountry;
    IBOutlet UILabel        *lblAcctNo;
    IBOutlet UILabel        *lblBankName;
    IBOutlet UILabel        *lblSwift;
    IBOutlet UILabel        *lblIban;
    
    BeneficiaryRec          *beneficiaryRec;
    
}

@property(nonatomic, retain) UILabel *lblBeneficiaryName;
@property(nonatomic, retain) UILabel *lblBeneficiaryAddress;
@property(nonatomic, retain) UILabel *lblCountry;
@property(nonatomic, retain) UIImageView *imgCountry;
@property(nonatomic, retain) UILabel *lblAcctNo;
@property(nonatomic, retain) UILabel *lblBankName;
@property(nonatomic, retain) UILabel *lblSwift;
@property(nonatomic, retain) UILabel *lblIban;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil beneficiaryRec:(BeneficiaryRec*)mBeneficiaryRec;
- (IBAction)next:(id)sender;

@end
