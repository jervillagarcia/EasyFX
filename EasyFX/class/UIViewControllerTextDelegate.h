//
//  UIViewControllerTextDelegate.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewControllerTextDelegate : UIViewController <UITextViewDelegate> {

	CGFloat animatedDistance;
	BOOL numberPadShowing;
	UIButton *dot;
	UIToolbar *keyToolbar;
	UITextField *currentTextField;
}

@property (nonatomic, retain) UITextField *currentTextField;

@end
