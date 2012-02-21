//
//  LoginViewController.h
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewControllerTextDelegate.h"
#import "EasyFXPreloader.h"

@interface LoginViewController : UIViewControllerTextDelegate {
    IBOutlet UITextField        *txtCliendId;
    IBOutlet UITextField        *txtUsername;
    IBOutlet UITextField        *txtPassword;
    EasyFXPreloader             *preloadView;
    BOOL                        isFromModal;
}

@property (nonatomic, retain) UITextField *txtClientId;
@property (nonatomic, retain) UITextField *txtUsername;
@property (nonatomic, retain) UITextField *txtPassword;

-(IBAction)loginOnClick:(id)sender;
-(void)loginAction;
-(IBAction)applyFinancialOnClick:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isFromModal:(BOOL)isFromModal;


@end
