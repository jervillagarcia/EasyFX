//
//  LoginViewController.h
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginViewController : UIViewController {
    IBOutlet UITextField        *txtCliendId;
    IBOutlet UITextField        *txtUsername;
    IBOutlet UITextField        *txtPassword;
}

@property (nonatomic, retain) UITextField *txtClientId;
@property (nonatomic, retain) UITextField *txtUsername;
@property (nonatomic, retain) UITextField *txtPassword;

-(IBAction)loginOnClick:(id)sender;
-(void)callHelpdesk:(id)sender;
-(void)applyFinancialOnClick:(id)sender;

@end
