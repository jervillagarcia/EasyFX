//
//  AddCardViewController.h
//  EasyFX
//
//  Created by Errol on 2/16/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"
#import "UIViewControllerTextDelegate.h"
#import "EasyFXSmallDateFieldDelegate.h"
#import "EasyFXLookupTextFieldDelegate.h"
#import "Country.h"
#import "CardRec.h"


@interface AddCardViewController : UIViewControllerTextDelegate <UIActionSheetDelegate>{
    EasyFXPreloader *preloadView;
    UIBarButtonItem *backItem1;
    UIBarButtonItem *backItem2;    
    
    IBOutlet UITextField *txtCardNo;
    IBOutlet UITextField *txtCVV;
    IBOutlet UITextField *txtName;
    IBOutlet UITextField *txtAddress1;
    IBOutlet UITextField *txtAddress2;
    IBOutlet UITextField *txtAddress3;
    IBOutlet UITextField *txtPostalCode;
    IBOutlet UITextField *txtStartDate;
    IBOutlet UITextField *txtExpiryDate;
    IBOutlet UITextField *txtCountry;
    IBOutlet UITextField *txtIssueNo;
    
    EasyFXSmallDateFieldDelegate    *smallDateFieldDelegate;
    EasyFXLookupTextFieldDelegate   *countryFieldDelegate;
    
    Country *country;
    NSString *countryCode;
}

@property(nonatomic, retain) EasyFXSmallDateFieldDelegate   *smallDateFieldDelegate;
@property(nonatomic, retain) EasyFXLookupTextFieldDelegate  *countryFieldDelegate;
@property(nonatomic, retain) UITextField *txtCardNo;
@property(nonatomic, retain) UITextField *txtCVV;
@property(nonatomic, retain) UITextField *txtName;
@property(nonatomic, retain) UITextField *txtAddress1;
@property(nonatomic, retain) UITextField *txtAddress2;
@property(nonatomic, retain) UITextField *txtAddress3;
@property(nonatomic, retain) UITextField *txtPostalCode;
@property(nonatomic, retain) UITextField *txtStartDate;
@property(nonatomic, retain) UITextField *txtExpiryDate;
@property(nonatomic, retain) UITextField *txtCountry;
@property(nonatomic, retain) UITextField *txtIssueNo;
    
-(void)setCountry:(Country *)mCountry;
- (void)saveRecord:(CardRec*)cardRec;

@end
