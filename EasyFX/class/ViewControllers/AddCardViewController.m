//
//  AddCardViewController.m
//  EasyFX
//
//  Created by Errol on 2/16/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "AddCardViewController.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>
#import "EasyFXAppDelegate.h"
#import "WebServiceFactory.h"
#import "Result.h"

@implementation AddCardViewController

@synthesize smallDateFieldDelegate;
@synthesize countryFieldDelegate;
@synthesize txtCardNo;
@synthesize txtCVV;
@synthesize txtName;
@synthesize txtAddress1;
@synthesize txtAddress2;
@synthesize txtAddress3;
@synthesize txtPostalCode;
@synthesize txtStartDate;
@synthesize txtExpiryDate;
@synthesize txtCountry;
@synthesize txtIssueNo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [preloadView release];
        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
        [preloadView setMessage:@"saving new card..."];
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
    smallDateFieldDelegate = [[EasyFXSmallDateFieldDelegate alloc] initDelegate:self view:self.view];
    countryFieldDelegate = [[EasyFXLookupTextFieldDelegate alloc] initDelegate:self view:self.view viewController:self];
    [txtExpiryDate setDelegate:smallDateFieldDelegate];
    [txtStartDate setDelegate:smallDateFieldDelegate];
    [txtCountry setDelegate:countryFieldDelegate];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Logout Button
    backItem1 = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    [self.navigationController.navigationBar.topItem     setLeftBarButtonItem:backItem1];
    
    backItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(save)];
    [self.navigationController.navigationBar.topItem     setRightBarButtonItem:backItem2];

    [Utils setNavTitleImage:self];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) dealloc {
    [country release];
    [preloadView release];
    [super dealloc];
}

#pragma mark Action
- (void)cancel {
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.5;
	animation.fillMode = kCAFillModeBoth;
    [[self.navigationController.view layer] addAnimation:animation forKey:kCATransition];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)save {
    [Utils dismissKeyBoard:self.view];
    [self.view addSubview:preloadView];
    
    CardRec *cardRec = [[CardRec alloc] init];
    [cardRec        setCardNumber:[txtCardNo text]];
    [cardRec        setCountryCode:countryCode];
    [cardRec        setAddress1:[txtAddress1 text]];
    [cardRec        setAddress2:[txtAddress2 text]];
    [cardRec        setAddress3:[txtAddress3 text]];
    [cardRec        setCvv:[txtCVV text]];
    [cardRec        setExpiryDate:[txtExpiryDate text]];
    [cardRec        setIssueNumber:[txtIssueNo text]];
    [cardRec        setName:[txtName text]];
    [cardRec        setPostCode:[txtPostalCode text]];
    [cardRec        setStartDate:[txtStartDate text]];
    
    [NSThread detachNewThreadSelector:@selector(saveRecord:) toTarget:self withObject:cardRec];
}

- (void)saveRecord:(CardRec*)cardRec {
	@autoreleasepool {
        WebServiceFactory *wsFactory = [[WebServiceFactory alloc] init];
        [wsFactory AddCard:cardRec];
        Result *result = (Result*)[wsFactory.wsResponse objectAtIndex:0];
        if ([[result success] isEqualToString:@"true"]) {
            [preloadView removeFromSuperview];
            [self cancel];
        } else {
            [preloadView removeFromSuperview];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:[result errorMsg] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];	
            [alert release];
        }
        
        [wsFactory release];
    }
}
# pragma mark Action Sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0 :
		{
			for (id subview in actionSheet.subviews) {
				if ([subview isKindOfClass:[UIPickerView class]]){
					id aDelegate = [(UIPickerView*)subview delegate];
					UITextField *txtField = [aDelegate curTxtField];
					int fieldTag = [txtField tag];
					[((UITextField*)[self.view viewWithTag:fieldTag]) setText:[aDelegate getPickerValue:(UIPickerView*)subview]];
//					[self goToNextField:fieldTag];
				}
			}
			break;
		}
        case 1 :
        {
			for (id subview in actionSheet.subviews) {
				if ([subview isKindOfClass:[UIPickerView class]]){
                    id aDelegate = [(UIPickerView*)subview delegate];
                    UITextField *txtField = [aDelegate curTxtField];
                    [txtField resignFirstResponder];
                }
            }
            
        }
		default:
			break;
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
	for (id subview in actionSheet.subviews) {
		if ([subview isKindOfClass:[UIPickerView class]]){
			id aDelegate = [(UIPickerView*)subview delegate];
			[[aDelegate curTxtField] resignFirstResponder];
		}
	}
}

-(void)setCountry:(Country *)mCountry {
    countryCode = [mCountry countryCode];
    [txtCountry setText:[mCountry name]];
    [txtCountry resignFirstResponder];
    [txtName becomeFirstResponder];
    [txtName resignFirstResponder];
}

@end
