//
//  CardDetailViewController.m
//  EasyFX
//
//  Created by Errol on 2/14/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "CardDetailViewController.h"
#import "Utils.h"
#import "ConfirmPaymentViewController.h"
#import "EasyFXAppDelegate.h"

@implementation CardDetailViewController

@synthesize txtCardMemberName;
@synthesize txtAddressLine1;
@synthesize txtPostCode;
@synthesize txtCardNumber;
@synthesize txtExpiryDate;
@synthesize txtStartDate;
@synthesize txtCVV;
@synthesize txtRef;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cardRec:(CardRec*)mCardRec
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        cardRec = mCardRec;
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
    
    [txtCardMemberName      setText:cardRec.name];
    [txtAddressLine1        setText:cardRec.address1];
    [txtCardNumber          setText:cardRec.cardNumber];
    [txtExpiryDate          setText:cardRec.expiryDate];
    [txtStartDate           setText:cardRec.startDate];
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

- (void)viewWillDisappear:(BOOL)animated {
    [txtCVV resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)nextClick:(id)sender {
    if ([txtCVV.text length] > 0) {
        EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate.payment setCardRec:cardRec];
        [delegate.payment setCvv:[txtCVV text]];
        [delegate.payment setReference:[txtRef text]];
        
        
        ConfirmPaymentViewController *viewController = [[ConfirmPaymentViewController alloc] initWithNibName:@"ConfirmPaymentViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    } else {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Invalid CVV value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alerView show];
        [alerView release];
    }
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
