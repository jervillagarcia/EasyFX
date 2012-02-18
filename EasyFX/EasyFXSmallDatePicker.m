//
//  UIObiSmallDatePicker.m
//  iCG
//
//  Created by James Errol Villagarcia on 6/19/11.
//  Copyright 2011 iCG. All rights reserved.
//

#import "EasyFXSmallDatePicker.h"


@implementation EasyFXSmallDatePicker

+(void)showSmallDatePicker:(NSString*)title 
			 delegate:(id)aDelegate 
	   actionDelegate:(id)actionDelegate
				 view:(UIView*)view 
		 currentValue:(NSString*)aValue
{
	UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:title 
													  delegate:actionDelegate
											 cancelButtonTitle:@"Cancel" 
										destructiveButtonTitle:nil 
											 otherButtonTitles:@"Select",nil];
	// Add the picker
	UIPickerView *pickerView = [[UIPickerView alloc] init];
	pickerView.tag = 1;
	pickerView.delegate = aDelegate;
	pickerView.showsSelectionIndicator = YES;
	[menu addSubview:pickerView];
	[menu showInView:view];
	
	CGRect menuRect = menu.frame;
	CGFloat orgHeight = menuRect.size.height;
	menuRect.origin.y -= 214; //height of picker
	menuRect.size.height = orgHeight+200;
	menu.frame = menuRect;
	
	
	CGRect pickerRect = pickerView.frame;
	pickerRect.origin.y = orgHeight;
	pickerView.frame = pickerRect;
	
	[pickerView release];
	[menu release]; 
	
}

@end
