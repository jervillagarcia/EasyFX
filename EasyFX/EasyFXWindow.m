//
//  CaxtonFXWindow.m
//  CaxtonFX
//
//  Created by Reg on 4/6/10.
//  Copyright 2010 Petra Financial Ltd. All rights reserved.
//

#import "EasyFXWindow.h"
#import "EasyFXAppDelegate.h"

@interface EasyFXWindow (Private)
- (void)resetIdleTimer;
@end

@implementation EasyFXWindow

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        // Custom initialization
		maxIdleTime = 900.00;			
		idleTimer = [[NSTimer alloc] init];
		isTimerOn = NO;
		isKeyboardVisible = NO;
    }
    return self;		
}

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];
	
    // Only want to reset the timer on a Began touch or an Ended touch, to reduce the number of timer resets.
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0) {
        // allTouches count only ever seems to be 1, so anyObject works here.
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan || phase == UITouchPhaseEnded)
            [self resetIdleTimer];
    }
}

#pragma mark -
#pragma mark Utilities
- (void)startTimer {
	EasyFXAppDelegate *appDelegate = (EasyFXAppDelegate*) [[UIApplication sharedApplication] delegate];
	idleTimer = [[NSTimer scheduledTimerWithTimeInterval:maxIdleTime target:appDelegate selector:@selector(btnLogout) userInfo:nil repeats:YES] retain];	
	isTimerOn = YES;
}

- (void)resetIdleTimer {
	if (isTimerOn && !isKeyboardVisible) {
		if (idleTimer) {
			//if ([idleTimer isValid]) 
			[idleTimer invalidate];
			[idleTimer release];	
			idleTimer = nil;
		}
		[self startTimer];
	}
	
}

- (void)stopTimer {
	if (idleTimer) {
		[idleTimer invalidate];
		[idleTimer release];	
	}
	isTimerOn = NO;
}

//- (void) keyboardWillShow {
//	isKeyboardVisible = YES;
//	if (isTimerOn){
//		if (idleTimer) {
//			[idleTimer invalidate];
//			[idleTimer release];	
//			idleTimer = nil;
//		}
//	}
//}
//
//- (void) keyboardWillHide {
//	isKeyboardVisible = NO;
//	if (isTimerOn){
//		[self resetIdleTimer];
//	}
//}

@end
