//
//  EasyFXLookupTextFieldDelegate.m
//  EasyFX
//
//  Created by James Errol Villagarcia on 2/18/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "EasyFXLookupTextFieldDelegate.h"
#import "CountryLookupViewController.h"

@implementation EasyFXLookupTextFieldDelegate
@synthesize delegate, view, curTxtField;

-(id)initDelegate:(id)aDelegate view:(UIView*)aView viewController:(UIViewController*)mViewController
{
	[self init];
	self.delegate = aDelegate;
	self.view = aView;
	
	isEditing = YES;
    
    fromController = mViewController;
	
	return self;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
	isEditing = NO;
	
	return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField { 
	if (isEditing) {
		curTxtField = textField;
		
        CountryLookupViewController *viewController = [[CountryLookupViewController alloc] initWithNibName:@"CountryLookupViewController" bundle:nil delegate:fromController];
        [fromController presentModalViewController:viewController animated:YES];
        [viewController.searchBar setText:[textField text]];
        [viewController searchBar:viewController.searchBar textDidChange:[textField text]];
        [viewController release];
        
    } else {
		isEditing = YES;
	}
    
    [textField resignFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(NSString*)getPickerValue:(UIPickerView*)pickerView {
	NSInteger slctdRow	= [pickerView selectedRowInComponent:0];
	NSInteger slctdRow2 = [pickerView selectedRowInComponent:1];
	NSString *choice	= [col1Arr objectAtIndex:slctdRow];
	NSString *choice1	= [col2Arr objectAtIndex:slctdRow2];
	
	return [NSString stringWithFormat:@"%@/%@", choice,choice1];
	
}

-(void)dealloc {
	[col1Arr release];
	[col2Arr release];
	
	[super dealloc];
}

@end
