//
//  AddCardViewController.h
//  EasyFX
//
//  Created by Errol on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"
#import "UIViewControllerTextDelegate.h"
#import "EasyFXSmallDateFieldDelegate.h"

@interface AddCardViewController : UIViewControllerTextDelegate <UIActionSheetDelegate>{
    EasyFXPreloader *preloadView;
    UIBarButtonItem *backItem1;
    UIBarButtonItem *backItem2;    
    
    IBOutlet UITextField *txtStartDate;
    IBOutlet UITextField *txtExpiryDate;
    
    EasyFXSmallDateFieldDelegate *smallDateFieldDelegate;
}

@property(nonatomic, retain) EasyFXSmallDateFieldDelegate *smallDateFieldDelegate;
@property(nonatomic, retain) UITextField *txtStartDate;
@property(nonatomic, retain) UITextField *txtExpiryDate;
    

@end
