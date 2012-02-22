//
//  CardDetailViewController.h
//  EasyFX
//
//  Created by Errol on 2/14/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTextDelegate.h"
#import "CardRec.h"


@interface CardDetailViewController : UIViewControllerTextDelegate {
    
    IBOutlet UITextField            *txtCardMemberName;
    IBOutlet UITextField            *txtAddressLine1;
    IBOutlet UITextField            *txtPostCode;
    IBOutlet UITextField            *txtCardNumber;
    IBOutlet UITextField            *txtExpiryDate;
    IBOutlet UITextField            *txtStartDate;
    IBOutlet UITextField            *txtCVV;
    IBOutlet UITextField            *txtRef;
    
    CardRec                         *cardRec;
}

@property(nonatomic,retain) UITextField            *txtCardMemberName;
@property(nonatomic,retain) UITextField            *txtAddressLine1;
@property(nonatomic,retain) UITextField            *txtPostCode;
@property(nonatomic,retain) UITextField            *txtCardNumber;
@property(nonatomic,retain) UITextField            *txtExpiryDate;
@property(nonatomic,retain) UITextField            *txtStartDate;
@property(nonatomic,retain) UITextField            *txtCVV;
@property(nonatomic,retain) UITextField            *txtRef;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cardRec:(CardRec*)mCardRec;

@end
