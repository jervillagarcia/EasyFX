//
//  ConfirmPaymentViewController.h
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"

@interface ConfirmPaymentViewController : UIViewController<UIAlertViewDelegate>{
    IBOutlet UILabel *lblAccountName;
    IBOutlet UILabel *lblAccountNumber;
    IBOutlet UILabel *lblCurrencyFrom;
    IBOutlet UILabel *lblDebit;
    IBOutlet UILabel *lblBeneficiaryName;
    IBOutlet UILabel *lblBeneficiaryBank;
    IBOutlet UILabel *lblBeneficiaryAccountNo;
    IBOutlet UILabel *lblExchangeRate;
    IBOutlet UILabel *lblCurrencyTo;
    IBOutlet UILabel *lblPaymentAmount;
    
    EasyFXPreloader *preloadView;
}
    
@property(nonatomic, retain) UILabel *lblAccountName;
@property(nonatomic, retain) UILabel *lblAccountNumber;
@property(nonatomic, retain) UILabel *lblCurrencyFrom;
@property(nonatomic, retain) UILabel *lblDebit;
@property(nonatomic, retain) UILabel *lblBeneficiaryName;
@property(nonatomic, retain) UILabel *lblBeneficiaryBank;
@property(nonatomic, retain) UILabel *lblBeneficiaryAccountNo;
@property(nonatomic, retain) UILabel *lblExchangeRate;
@property(nonatomic, retain) UILabel *lblCurrencyTo;
@property(nonatomic, retain) UILabel *lblPaymentAmount;

- (void)confirmAction;

@end
