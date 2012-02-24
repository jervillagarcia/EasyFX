//
//  EasyFXWindow.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
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

//- (void) keyboardWillShow;
//- (void) keyboardWillHide;

@end
