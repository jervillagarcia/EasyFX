//
//  EasyFXTextField.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utils.h"

@interface EasyFXTextField : UITextField {
	BOOL numberPadShowing;
	UIButton *dot;
	UIToolbar *keyboardToolbar;
}

@property (nonatomic, retain)	UIToolbar	*keyboardToolbar;
@property (nonatomic, retain)	UIButton	*dot;

- (void)keyboardWillShow:(NSNotification *)note;
- (void)keyboardWillHide:(NSNotification *)notification;
- (void)dismissKeyboard;
- (void)decimalButtonClicked;
- (void)removeDecimal;
- (void)addDecimal;

@end
