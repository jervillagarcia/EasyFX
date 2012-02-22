//
//  ExistingBeneficiaryViewController.m
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "ExistingBeneficiaryViewController.h"
#import "Utils.h"
#import "CardListViewController.h"
#import "EasyFXAppDelegate.h"

@implementation ExistingBeneficiaryViewController

@synthesize lblBeneficiaryName;
@synthesize lblBeneficiaryAddress;
@synthesize lblCountry;
@synthesize imgCountry;
@synthesize lblAcctNo;
@synthesize lblBankName;
@synthesize lblSwift;
@synthesize lblIban;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil beneficiaryRec:(BeneficiaryRec*)mBeneficiaryRec
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        beneficiaryRec = mBeneficiaryRec;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [Utils setNavTitleImage:self];

    [lblBeneficiaryName         setText:beneficiaryRec.beneficiaryName];
    [lblBeneficiaryAddress      setText:beneficiaryRec.getBankAddress];
    [imgCountry                 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) [[beneficiaryRec countryCode] lowercaseString]]]];
    [lblCountry                 setText:beneficiaryRec.countryCode];
    [lblAcctNo                  setText:beneficiaryRec.accountNumber];
    [lblBankName                setText:beneficiaryRec.bankName];
    [lblSwift                   setText:beneficiaryRec.sWIFTBIC];
    [lblIban                    setText:beneficiaryRec.iBAN];

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

- (IBAction)next:(id)sender {
    EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.payment setBeneficiaryRec:beneficiaryRec];
    
    CardListViewController *viewController = [[CardListViewController alloc] initWithNibName:@"CardListViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
