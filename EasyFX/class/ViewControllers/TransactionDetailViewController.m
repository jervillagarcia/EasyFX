//
//  TransactionDetailViewController.m
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
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
    [txtCurYouBuy becomeFirstResponder];
    [txtCurYouBuy resignFirstResponder];
    [txtCurYouBuy 	setText:[priceRec getCurrencyYouBuy]];
    [txtCalcRate    setText:[priceRec bid]];
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
    [Utils dismissKeyBoard:self.view];
    EasyFXAppDelegate *delegate = (EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ([txtAmtToSell.text floatValue] > [delegate.limit floatValue]) {
        NSNumber *_amount = [[NSNumber alloc] initWithFloat:[delegate.limit floatValue]];
        NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
        [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [_currencyFormatter setCurrencyCode:txtCurYouSell.text];
        [_currencyFormatter setNegativeFormat:@"-¤#,##0.00"];

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Amount" message:[NSString stringWithFormat:@"Sell amount must not exceed %@ ",[_currencyFormatter stringFromNumber:_amount]] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        
        [_amount release];
        [_currencyFormatter release];
        return;
    }
        
    if ([txtAmtToBuy.text floatValue] > 0 || [txtAmtToSell.text floatValue]) {
        [delegate.payment setBuyCCY:[txtCurYouBuy text]];
        [delegate.payment setBuyAmount:[txtAmtToBuy text]];
        [delegate.payment setRate:[priceRec bid]];
        [delegate.payment setSellCCY:[txtCurYouSell text]];
        [delegate.payment setSellAmount:[txtAmtToSell text]];
        
        StoredBeneficiaryTableViewController *viewController = [[StoredBeneficiaryTableViewController alloc] initWithNibName:@"StoredBeneficiaryViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Amount" message:@"Amount to buy and amount to sell must be greater than 0." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (IBAction)calculate:(id)sender {
    
	if (priceRec.bid > 0) {
		if ([sender isEqual:txtAmtToBuy]) {
			amount = [[txtAmtToBuy text] floatValue] / [priceRec.bid floatValue];
			[txtAmtToSell	setText:[NSString stringWithFormat:@"%.2f", amount]];
			[txtAmtToBuy		setText:[@"" stringByAppendingFormat:@"%.2f", [txtAmtToBuy.text floatValue]]];
		} else {
			amount = [[txtAmtToSell text] floatValue] * [priceRec.bid floatValue];
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
