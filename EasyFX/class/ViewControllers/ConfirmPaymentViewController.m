//
//  ConfirmPaymentViewController.m
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "ConfirmPaymentViewController.h"
#import "Utils.h"
#import "EasyFXAppDelegate.h"
#import "WebServiceFactory.h"
#import "DealResult.h"
#import "TransactionCompleteViewController.h"
#import "Fault.h"

@implementation ConfirmPaymentViewController

@synthesize lblAccountName;
@synthesize lblAccountNumber;
@synthesize lblCurrencyFrom;
@synthesize lblDebit;
@synthesize lblBeneficiaryName;
@synthesize lblBeneficiaryBank;
@synthesize lblBeneficiaryAccountNo;
@synthesize lblExchangeRate;
@synthesize lblCurrencyTo;
@synthesize lblPaymentAmount;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [preloadView release];
        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
        [preloadView setMessage:@"processing payment..."];
        preloadView.tag = 1;
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

    EasyFXAppDelegate *delegate = (EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate];

    NSNumber *sellAmount = [[NSNumber alloc] initWithFloat:[delegate.payment.sellAmount floatValue]];
    NSNumber *buyAmount = [[NSNumber alloc] initWithFloat:[delegate.payment.buyCCY floatValue]];

    NSNumberFormatter *_currencyFormatter = [[NSNumberFormatter alloc] init];
    [_currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [_currencyFormatter setNegativeFormat:@"-¤#,##0.00"];
    
    
    [lblAccountName         setText:[delegate.payment.cardRec name]];
    [lblAccountNumber       setText:[delegate.payment.cardRec cardNumber]];
    [lblCurrencyFrom        setText:[delegate.payment sellCCY]];
    [_currencyFormatter     setCurrencyCode:[delegate.payment sellCCY]];
    [lblDebit               setText:[_currencyFormatter stringFromNumber:sellAmount]];
    [lblBeneficiaryName     setText:[delegate.payment.beneficiaryRec beneficiaryName]];
    [lblBeneficiaryBank     setText:[delegate.payment.beneficiaryRec bankName]];
    [lblBeneficiaryAccountNo setText:[delegate.payment.beneficiaryRec accountNumber]];
    [lblExchangeRate        setText:[delegate.payment rate]];
    [lblCurrencyTo          setText:[delegate.payment buyCCY]];
    [_currencyFormatter     setCurrencyCode:[delegate.payment buyCCY]];
    [lblPaymentAmount       setText:[_currencyFormatter stringFromNumber:buyAmount]];
    
    [sellAmount release];
    [buyAmount release];
    [_currencyFormatter release];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [Utils setNavTitleImage:self];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [preloadView release];
    [super dealloc];
}

- (IBAction)confirmClick:(id)sender {
    [self.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(confirmAction) toTarget:self withObject:nil];
}

- (void)confirmAction {
    @autoreleasepool {
        EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        WebServiceFactory *wsFactory = [[WebServiceFactory alloc] init];
        [wsFactory makeDeal:[delegate payment]];
        
        if ([[wsFactory.wsResponse objectAtIndex:0] isKindOfClass:[Fault class]]) {
            [preloadView removeFromSuperview];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:[(Fault*)[wsFactory.wsResponse objectAtIndex:0] faultstring] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];	
            [alert release];
        } else {
            DealResult *dealResult = (DealResult*)[wsFactory.wsResponse objectAtIndex:0];
            if ([[dealResult success] isEqualToString:@"true"]) {
                [delegate setLimit:dealResult.limit];
                TransactionCompleteViewController *viewController = [[TransactionCompleteViewController alloc] initWithNibName:@"TransactionCompleteViewController" bundle:nil dealNo:[dealResult dealNumber]];
                [self.navigationController pushViewController:viewController animated:YES];
                [self.navigationController setNavigationBarHidden:NO];
                [viewController release];
                [preloadView removeFromSuperview];
            } else {
                [preloadView removeFromSuperview];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:[dealResult errorMsg] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];	
                [alert release];
            }
        }    
        
        [wsFactory release];
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
