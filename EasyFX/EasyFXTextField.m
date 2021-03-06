//
//  EasyFXTextField.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "EasyFXTextField.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>

@implementation EasyFXTextField

@synthesize keyboardToolbar, dot;

- (id)initWithCoder:(NSCoder *)inCoder {
    if (self = [super initWithCoder:inCoder]) {
		self.borderStyle = UITextBorderStyleNone;
		
		[self setBackground:[UIImage imageNamed:@"textfieldblue.png"]];
		[self setDisabledBackground:[UIImage imageNamed:@"textfieldgrey.png"]];
		
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
        [dot release];
        dot = [[UIButton alloc] init];
        dot.frame = CGRectMake(0, 428, 106, 53);
        dot.tag = 123;
        [dot setImage:[UIImage imageNamed:@"dotB.png"] forState:UIControlStateNormal];
        [dot setImage:[UIImage imageNamed:@"dotA.png"] forState:UIControlStateHighlighted];
        [dot addTarget:self action:@selector(decimalButtonClicked)  forControlEvents:UIControlEventTouchUpInside];
        
        NSArray *allWindows = [[UIApplication sharedApplication] windows];
        int topWindow = [allWindows count] - 1;
        
        UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
        
        //Fixes Decimal Button Transition
        CATransition *applicationLoadViewIn =[CATransition animation];
        [applicationLoadViewIn setDuration:1.5];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [[dot layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
        [keyboardWindow addSubview:dot];
        
    } else {
        [dot removeFromSuperview];
        [dot release];
        dot = nil;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillShowNotification
												  object:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
	[dot removeFromSuperview];
    [dot release];
    dot = nil;
	[keyboardToolbar removeFromSuperview];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIKeyboardWillHideNotification
												  object:nil];
	
}

- (void)decimalButtonClicked {
	[Utils dotOnclick:self];
}

- (void)removeDecimal {
	[dot removeFromSuperview];
    [dot release];
    dot = nil;
}

- (void)addDecimal {
    [dot release];
    dot = [[UIButton alloc] init];
    dot.frame = CGRectMake(0, 428, 106, 53);
    dot.tag = 123;
    [dot setImage:[UIImage imageNamed:@"dotB.png"] forState:UIControlStateNormal];
    [dot setImage:[UIImage imageNamed:@"dotA.png"] forState:UIControlStateHighlighted];
    [dot addTarget:self action:@selector(decimalButtonClicked)  forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *allWindows = [[UIApplication sharedApplication] windows];
    int topWindow = 0;
    if ([allWindows count] > 1) {
        topWindow = [allWindows count] - 1;
    }

    
    UIWindow *keyboardWindow = [allWindows objectAtIndex:topWindow];
    
    //Fixes Decimal Button Transition
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [[dot layer]addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
    [keyboardWindow addSubview:dot];
    
}

- (void)dismissKeyboard {
	[self resignFirstResponder];
}

- (void)dealloc {
    [dot release];
    [super dealloc];
}

@end
