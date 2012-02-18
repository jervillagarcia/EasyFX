//
//  AddCardViewController.m
//  EasyFX
//
//  Created by Errol on 2/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddCardViewController.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddCardViewController

@synthesize smallDateFieldDelegate;
@synthesize txtStartDate;
@synthesize txtExpiryDate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [preloadView release];
//        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
//        [preloadView setMessage:@"processing payment..."];
//        preloadView.tag = 1;
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
    [txtExpiryDate setDelegate:smallDateFieldDelegate];
    [txtStartDate setDelegate:smallDateFieldDelegate];
    
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
    [preloadView release];
    [super dealloc];
}

#pragma mark Action
- (void)cancel {
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFade;
	animation.duration = 0.5;  //Or whatever
    //	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //Or whatever
    //	animation.startProgress = 0;  //Set this as needed
    //	animation.endProgress = 0.66;  //Set this as needed
	animation.fillMode = kCAFillModeBoth;
    [[self.navigationController.view layer] addAnimation:animation forKey:kCATransition];
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

- (void)save {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Not yet available." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
    [alertView release];
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


@end
