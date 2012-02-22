//
//  TransactionCompleteViewController.m
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "TransactionCompleteViewController.h"
#import "Utils.h"
#import "WebServiceFactory.h"

@implementation TransactionCompleteViewController

@synthesize lblDealNo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dealNo:(NSString*)mDealNo
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dealNo = mDealNo;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [lblDealNo setText:dealNo];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.navigationController setNavigationBarHidden:YES];
    
    [Utils setNavTitleImage:self];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)newPayment:(id)sender {
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}

- (IBAction)logOut:(id)sender {
	@autoreleasepool {
        WebServiceFactory *ws = [[WebServiceFactory alloc] init];
        
        [ws logOut];
        
        [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:0] animated:YES];

        [ws release];
    }
}



@end
