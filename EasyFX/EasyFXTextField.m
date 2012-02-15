//
//  EasyFXTextField.m
//  EasyFX
//
//  Created by Errol Villagarcia on 3/4/10.
//  Copyright 2010 Petra Financial Ltd.. All rights reserved.
//

#import "EasyFXTextField.h"
#import "Utils.h"

@implementation EasyFXTextField

@synthesize keyboardToolbar, dot;

- (id)initWithCoder:(NSCoder *)inCoder {
    if (self = [super initWithCoder:inCoder]) {
		self.borderStyle = UITextBorderStyleNone;
		
		[self setBackground:[UIImage imageNamed:@"textfieldblue.png"]];
		[self setDisabledBackground:[UIImage imageNamed:@"textfieldgrey.png"]];
		
//		if (self.enabled) {
//			[self setTextColor:[UIColor blackColor]];
//		} else {
//			[self setTextColor:[UIColor whiteColor]];
//		}
		
		numberPadShowing = YES;
    }
	return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
	if (!self.textAlignment == UITextAlignmentCenter) {
		CGRect newRect = CGRectMake(bounds.origin.x + 10, bounds.origin.y,bounds.size.width,bounds.size.width);
		return newRect;
	} else {
		return bounds;
	}
}

- (CGRect)editingRectForBounds:(CGRect)bounds { 
	CGRect newRect = CGRectMake(bounds.origin.x + 10, bounds.origin.y,bounds.size.width,bounds.size.width);
	return newRect;
}

- (void)keyboardWillShow:(NSNotification *)notification 
{  
    if (self.keyboardType == UIKeyboardTypeNumberPad) {
        dot = [[UIButton alloc] init];
        dot.frame = CGRectMake(0, 428, 106, 53);
        dot.tag = 123;
        [dot setImage:[UIImage imageNamed:@"dotB.png"] forState:UIControlStateNormal];
        [dot setImage:[UIImage imageNamed:@"dotA.png"] forState:UIControlStateHighlighted];
        [dot addTarget:self action:@selector(decimalButtonClicked)  forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *allWindows = [[UIApplication sharedApplication] windows];
        int topWindow = [allWindows count] - 1;
        
        UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
        [keyboardWindow addSubview:dot];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	[dot removeFromSuperview];
	[keyboardToolbar removeFromSuperview];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
	
}

- (void)decimalButtonClicked {
	[Utils dotOnclick:self];
}

- (void)dismissKeyboard {
	[self resignFirstResponder];
}

- (void)dealloc {
    [super dealloc];
}

@end
