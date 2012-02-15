//
//  TransactionDetailViewController.h
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceRec.h"
#import "UIViewControllerTextDelegate.h"
#import "EasyFXTextFieldDelegate.h"

@interface TransactionDetailViewController : UIViewControllerTextDelegate {
    IBOutlet UITextField *txtCurYouBuy;    
    IBOutlet UITextField *txtAmtToBuy;
    IBOutlet UITextField *txtCalcRate;
    IBOutlet UITextField *txtCurYouSell;
    IBOutlet UITextField *txtAmtToSell;
    
    PriceRec *priceRec;
 
}

@property(nonatomic, retain) PriceRec *priceRec;
@property(nonatomic, retain) IBOutlet UITextField *txtCurYouBuy;    
@property(nonatomic, retain) IBOutlet UITextField *txtAmtToBuy;
@property(nonatomic, retain) IBOutlet UITextField *txtCalcRate;
@property(nonatomic, retain) IBOutlet UITextField *txtCurYouSell;
@property(nonatomic, retain) IBOutlet UITextField *txtAmtToSell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil price:(PriceRec*)mPrice;
- (IBAction)next:(id)sender;

@end
