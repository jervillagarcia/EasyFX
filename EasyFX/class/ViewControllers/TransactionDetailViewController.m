//
//  TransactionDetailViewController.m
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "StoredBeneficiaryTableViewController.h"

@implementation TransactionDetailViewController

@synthesize txtCurYouBuy;    
@synthesize txtAmtToBuy;
@synthesize txtCalcRate;
@synthesize txtCurYouSell;
@synthesize txtAmtToSell;
@synthesize priceRec;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil price:(PriceRec*)mPrice
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        priceRec = mPrice;
        // Custom initialization
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
    
    [txtCurYouBuy 	setText:[priceRec getCurrencyYouBuy]];
    [txtCalcRate    setText:[priceRec ask]];
    [txtCurYouSell  setText:[priceRec getCurrencyYouSell]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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

#pragma Action Methods
- (IBAction)next:(id)sender {
    StoredBeneficiaryTableViewController *viewController = [[StoredBeneficiaryTableViewController alloc] initWithNibName:@"StoredBeneficiaryViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
