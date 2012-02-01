//
//  CaxtonFXWindow.h
//  CaxtonFX
//
//  Created by Reg on 4/6/10.
//  Copyright 2010 Petra Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EasyFXWindow : UIWindow {
	bool				isTimerOn;
	bool				isKeyboardVisible;
	NSTimer				*idleTimer;
	NSTimeInterval		maxIdleTime;
}

- (void)startTimer;
- (void)stopTimer;

- (void) keyboardWillShow;
- (void) keyboardWillHide;

@end
