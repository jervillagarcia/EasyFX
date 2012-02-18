//
//  UIObiSmallDateFieldDelegate.m
//  iCG
//
//  Created by James Errol Villagarcia on 6/19/11.
//  Copyright 2011 iCG. All rights reserved.
//

#import "EasyFXSmallDateFieldDelegate.h"
#import "EasyFXSmallDatePicker.h"


@implementation EasyFXSmallDateFieldDelegate
@synthesize delegate, title, view, col1Arr, col2Arr, curTxtField;

-(id)initDelegate:(id)aDelegate view:(UIView*)aView
{
	[self init];
	self.delegate = aDelegate;
	self.view = aView;
	self.title = @"Date Picker";
	
	isEditing = YES;
	
	col1Arr = [[NSArray alloc] initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
	
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	[temp addObject:@"00"];
	NSString *toAdd;
	for (int i = 1; i < 100; i++) {
		if (i < 10) {
			toAdd = [NSString stringWithFormat:@"0%d", i];
		}else {
			toAdd = [NSString stringWithFormat:@"%d", i];
		}
		[temp addObject:toAdd];
	}
	
	
	col2Arr = [[NSArray alloc] initWithArray:temp];
	[temp release];
	
	return self;
}

-(id)initDelegateWithTitle:(NSString*)aTitle delegate:(id)aDelegate view:(UIView*)aView
{
	[self init];
	self.delegate = aDelegate;
	self.view = aView;
	self.title = aTitle;
	
	isEditing = YES;
	
	col1Arr = [[NSArray alloc] initWithObjects:@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", nil];
	
	NSMutableArray *temp = [[NSMutableArray alloc] init];
	[temp addObject:@"00"];
	NSString *toAdd;
	for (int i = 1; i < 100; i++) {
		if (i < 10) {
			toAdd = [NSString stringWithFormat:@"0%d", i];
		}else {
			toAdd = [NSString stringWithFormat:@"%d", i];
		}
		[temp addObject:toAdd];
	}
	
	
	col2Arr = [[NSArray alloc] initWithArray:temp];
	[temp release];
	
	return self;
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView{
	return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger) component{
	if(component == 0){
		return [col1Arr count];
	}else{
		return [col2Arr count];
	}
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger) component{
	if(component == 0){
		return [col1Arr objectAtIndex:row];
	}else{
		return [col2Arr objectAtIndex:row];
	}
}


-(BOOL)textFieldShouldClear:(UITextField *)textField {
	isEditing = NO;
    
    [textField resignFirstResponder];
	
	return YES;
}

-(void)goToNextField:(int)aTag {
	// Proceed to next field
    [(UITextField*)[self.view viewWithTag:aTag+1] becomeFirstResponder];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField { 
	if (isEditing) {
		curTxtField = textField;
		[EasyFXSmallDatePicker showSmallDatePicker:title 
							   delegate:self 
						 actionDelegate:self.delegate
								   view:self.view 
						   currentValue:[textField text]] ;	
		
    } else {
		isEditing = YES;
        [textField resignFirstResponder];
	}
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
