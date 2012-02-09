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
    for (UIWindow *keyboardWindow in [[UIApplication sharedApplication] windows]) {
		
        // Now iterating over each subview of the available windows
        for (UIView *keyboard in [keyboardWindow subviews]) {
			
            // Check to see if the description of the view we have referenced is UIKeyboard.
            // If so then we found the keyboard view that we were looking for.
            NSLog(@"Keyboard Description: %@",[keyboard description]);
            if([[keyboard description] hasPrefix:@"<UIKeyboard"] == YES) {
				NSValue *v = [[notification userInfo] valueForKey:UIKeyboardFrameBeginUserInfoKey];
				CGRect kbBounds = [v CGRectValue];

				if(keyboardToolbar != nil) {
					[keyboardToolbar release];
					keyboardToolbar = nil;
				}
				
				if(keyboardToolbar == nil) {
					keyboardToolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
					keyboardToolbar.barStyle = UIBarStyleBlackTranslucent;
					keyboardToolbar.translucent = YES;
					keyboardToolbar.tag = 123;
					UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
					UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
					NSArray *items = [[NSArray alloc] initWithObjects:flex, barButtonItem, nil];
					[keyboardToolbar setItems:items];  
					[items release];  
					[barButtonItem release];
					[flex release];
					
				}        

				
				if (self.keyboardType == UIKeyboardTypeNumberPad) {
					
					if(dot != nil) {
						[dot release];
						dot = nil;
					}

					if(dot == nil) {
						dot = [[UIButton alloc] init];
						dot.frame = CGRectMake(0, 193, 106, 53);
						dot.tag = 123;
						[dot setImage:[UIImage imageNamed:@"dotB.png"] forState:UIControlStateNormal];
						[dot setImage:[UIImage imageNamed:@"dotA.png"] forState:UIControlStateHighlighted];
						[dot addTarget:self action:@selector(decimalButtonClicked)  forControlEvents:UIControlEventTouchUpInside];
					}
					[keyboard addSubview:dot];
				}				
				
				[keyboardToolbar removeFromSuperview];
				keyboardToolbar.frame = CGRectMake(0, 0, kbBounds.size.width, 30);
				[keyboard addSubview:keyboardToolbar];
				keyboard.bounds = CGRectMake(kbBounds.origin.x, kbBounds.origin.y, kbBounds.size.width, kbBounds.size.height + 60);
				
				for(UIView* subKeyboard in [keyboard subviews]) {
					if([[subKeyboard description] hasPrefix:@"<UIKeyboardImpl"] == YES) {
						subKeyboard.bounds = CGRectMake(kbBounds.origin.x, kbBounds.origin.y - 30, kbBounds.size.width, kbBounds.size.height);  
					}            
				}
            }
        }
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
