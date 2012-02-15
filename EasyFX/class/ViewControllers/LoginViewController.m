//
//  LoginViewController.m
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "WebServiceFactory.h"
#import "LogInResult.h"
#import "CurrencyViewController.h"
#import "EasyFXAppDelegate.h"

@implementation LoginViewController

@synthesize txtClientId, txtPassword, txtUsername;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    [self.navigationController setNavigationBarHidden:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)loginOnClick:(id)sender{
	[self.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(loginAction) toTarget:self withObject:nil];
    
}
-(void)loginAction {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	WebServiceFactory *wsFactory = [[WebServiceFactory alloc] init];
    [wsFactory logInWithUser:[txtUsername text] password:[txtPassword text] clientId:[txtCliendId text]];
    
    if ([[(LogInResult*)[wsFactory.wsResponse objectAtIndex:0] success] isEqualToString:@"true"]) {
        //Store CCYPAIRS
        EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate setCcyPairList:[[wsFactory.wsResponse objectAtIndex:0] cCYPairs]];
        [delegate setLimit:[[wsFactory.wsResponse objectAtIndex:0] limit]];
        
        CurrencyViewController *viewController = [[CurrencyViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
        [self.navigationController setNavigationBarHidden:NO];
        [viewController release];
    }
    
    [wsFactory release];
    [pool release];
    [preloadView removeFromSuperview];
}
-(void)callHelpdesk:(id)sender{}
-(void)applyFinancialOnClick:(id)sender{}

@end
