//
//  LoginViewController.m
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServiceFactory.h"

@implementation LoginViewController

@synthesize txtClientId, txtPassword, txtUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)loginOnClick:(id)sender{
    WebServiceFactory *wsFactory = [[WebServiceFactory alloc] init];
//    [wsFactory logInWithUser:[txtUsername text] password:[txtPassword text] clientId:[txtCliendId text]];
    [wsFactory getDealCurrencies];
    [wsFactory release];
}
-(void)callHelpdesk:(id)sender{}
-(void)applyFinancialOnClick:(id)sender{}

@end
