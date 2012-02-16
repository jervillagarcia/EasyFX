//
//  TransactionDetailViewController.m
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TransactionDetailViewController.h"
#import "StoredBeneficiaryTableViewController.h"
#import "Utils.h"
#import "EasyFXAppDelegate.h"

@implementation TransactionDetailViewController

@synthesize txtCurYouBuy;    
@synthesize txtAmtToBuy;
@synthesize txtCalcRate;
@synthesize txtCurYouSell;
@synthesize txtAmtToSell;
@synthesize priceRec;

float amount = 0.00;

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
    
    [Utils setNavTitleImage:self];
    
}

- (void)viewDidUnload
{
    [self performSelector:@selector(dismissKeyboard)];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self performSelector:@selector(dismissKeyboard)];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dismissKeyboard {
    [txtAmtToBuy resignFirstResponder];
    [txtAmtToSell resignFirstResponder];
}

#pragma Action Methods
- (IBAction)next:(id)sender {
    EasyFXAppDelegate *delegate = (EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate.payment setBuyCCY:[txtCurYouBuy text]];
    [delegate.payment setBuyAmount:[txtAmtToBuy text]];
    [delegate.payment setRate:[txtCalcRate text]];
    [delegate.payment setSellCCY:[txtCurYouSell text]];
    [delegate.payment setSellAmount:[txtAmtToSell text]];
    
    StoredBeneficiaryTableViewController *viewController = [[StoredBeneficiaryTableViewController alloc] initWithNibName:@"StoredBeneficiaryViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)calculate:(id)sender {
    
	if (priceRec.ask > 0) {
		if ([sender isEqual:txtAmtToBuy]) {
			amount = [[txtAmtToBuy text] floatValue] / [priceRec.ask floatValue];
			[txtAmtToSell	setText:[NSString stringWithFormat:@"%.2f", amount]];
			[txtAmtToBuy		setText:[@"" stringByAppendingFormat:@"%.2f", [txtAmtToBuy.text floatValue]]];
		} else {
			amount = [[txtAmtToSell text] floatValue] * [priceRec.ask floatValue];
			[txtAmtToBuy		setText:[NSString stringWithFormat:@"%.2f", amount]];
			[txtAmtToSell	setText:[@"" stringByAppendingFormat:@"%.2f", [txtAmtToSell.text floatValue]]];
		}
	}
}

- (IBAction)clearAction:(id)sender {
    [txtAmtToSell setText:@""];
    [txtAmtToBuy setText:@""];
}

@end
