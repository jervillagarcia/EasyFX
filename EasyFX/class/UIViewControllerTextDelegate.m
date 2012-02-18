//
//  UIViewControllerTextDelegate.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "UIViewControllerTextDelegate.h"
#import "Constants.h"
#import "Utils.h"
#import "EasyFXAppDelegate.h"
#import "EasyFXWindow.h"
#import "EasyFXTextField.h"

@implementation UIViewControllerTextDelegate

@synthesize currentTextField;
@synthesize keyToolbar;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark UITextViewDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
	[self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
	[self.view.window convertRect:self.view.bounds fromView:self.view];
	
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
	midline - viewRect.origin.y
	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
	* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;	
	
	if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }	
	
	UIInterfaceOrientation orientation =
	[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }	
	
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];	

	[textField setInputAccessoryView:keyToolbar];
	currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	currentTextField = textField;
    
    if (textField.keyboardType == UIKeyboardTypeNumberPad)
        [(EasyFXTextField*)textField addDecimal];
    
//	[[NSNotificationCenter defaultCenter] addObserver:textField selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    [(EasyFXTextField*)textField removeDecimal];
//    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:UIKeyboardWillHideNotification object:textField]];
//    [(EasyFXTextField*)textField removeDecimal];
//	[[NSNotificationCenter defaultCenter] addObserver:textField selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	return YES;
}

-(IBAction)nextField:(id)sender{
    UITextField *txtField = currentTextField;
    [currentTextField resignFirstResponder];
    [[[txtField superview] viewWithTag:[txtField tag] + 1] becomeFirstResponder];
    currentTextField = (UITextField*)[[txtField superview] viewWithTag:[txtField tag] + 1];
}


-(IBAction)prevField:(id)sender{
    UITextField *txtField = currentTextField;
    if (txtField.tag > 1) {
        [currentTextField resignFirstResponder];
        [[[txtField superview] viewWithTag:[txtField tag] - 1] becomeFirstResponder];
    }
}

-(IBAction)done:(id)sender{
    [currentTextField resignFirstResponder];
}

@end
