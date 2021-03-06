//
//  LoginViewController.m
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServiceFactory.h"
#import "LogInResult.h"
#import "CurrencyViewController.h"
#import "EasyFXAppDelegate.h"
#import "Utils.h"

@implementation LoginViewController

@synthesize txtClientId, txtPassword, txtUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isFromModal:(BOOL)mIsFromModal
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        isFromModal = mIsFromModal;
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
    
    [preloadView release];
    preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
    preloadView.tag = 1;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    EasyFXAppDelegate *delegate = (EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate];
    delegate.isFromLogin = YES;
    
#if DEBUGGING
    NSLog(@"Default ClientID: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"client_id"]);
    NSLog(@"Default ClientID: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"client_id"]);
#endif
    [txtClientId setText:[[NSUserDefaults standardUserDefaults] objectForKey:@"client_id"]];
    [txtPassword setText:@""];
    
    [txtCliendId becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)loginOnClick:(id)sender{
    [Utils dismissKeyBoard:self.view];
	[self.view addSubview:preloadView];
    //SET DEFAULT VALUE FOR ClientID
    [[NSUserDefaults standardUserDefaults] setValue:[txtClientId text] forKey:@"client_id"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [NSThread detachNewThreadSelector:@selector(loginAction) toTarget:self withObject:nil];
    
}
-(void)loginAction {
    @autoreleasepool {
        WebServiceFactory *wsFactory = [[WebServiceFactory alloc] init];
        [wsFactory logInWithUser:[txtUsername text] password:[txtPassword text] clientId:[txtCliendId text]];
        
        EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        delegate.isFromLogin = NO;
        
        if ([[(LogInResult*)[wsFactory.wsResponse objectAtIndex:0] success] isEqualToString:@"true"]) {
            //Store CCYPAIRS
            [delegate setCcyPairList:[[wsFactory.wsResponse objectAtIndex:0] cCYPairs]];
            [delegate setLimit:[[wsFactory.wsResponse objectAtIndex:0] limit]];
            [delegate setFee:[[wsFactory.wsResponse objectAtIndex:0] fee]];
            [delegate setAddress1:[[wsFactory.wsResponse objectAtIndex:0] address1]];
            [delegate setAddress2:[[wsFactory.wsResponse objectAtIndex:0] address2]];
            [delegate setAddress3:[[wsFactory.wsResponse objectAtIndex:0] address3]];
            [delegate setPostCode:[[wsFactory.wsResponse objectAtIndex:0] postCode]];
            [delegate setCountryCode:[[wsFactory.wsResponse objectAtIndex:0] country]];
            
            if (isFromModal) {
                [self dismissModalViewControllerAnimated:YES];
                isFromModal = NO;
            } else {
                CurrencyViewController *viewController = [[CurrencyViewController alloc] init];
                [self.navigationController pushViewController:viewController animated:YES];
                [self.navigationController setNavigationBarHidden:NO];
                [viewController release];
            }
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:[(LogInResult*)[wsFactory.wsResponse objectAtIndex:0] errorMsg] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
        
        [wsFactory release];
    }
    [preloadView removeFromSuperview];
}
-(IBAction)callHelpdesk:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", @"08003584919"]]];
}
-(IBAction)applyFinancialOnClick:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.applyfinancial.co.uk"]];
}

@end
