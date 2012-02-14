//
//  CardDetailViewController.m
//  EasyFX
//
//  Created by Errol on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CardDetailViewController.h"
#import "Utils.h"

@implementation CardDetailViewController

@synthesize txtCardMemberName;
@synthesize txtAddressLine1;
@synthesize txtPostCode;
@synthesize txtCardNumber;
@synthesize txtExpiryDate;
@synthesize txtStartDate;
@synthesize txtCVV;


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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
