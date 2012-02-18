//
//  EasyFXLookupTextFieldDelegate.h
//  EasyFX
//
//  Created by James Errol Villagarcia on 2/18/12.
//  Copyright 2012 TELUS International Philippines. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EasyFXLookupTextFieldDelegate : NSObject <UITextFieldDelegate> {
	id				delegate;
	NSString		*title;
	UIView			*view;
	BOOL			isEditing;
	NSArray			*col1Arr;
	NSArray			*col2Arr;
	UITextField		*curTxtField;
	UIViewController *fromController;
}

@property(nonatomic, retain) UITextField *curTxtField;
@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) UIView *view;

-(id)initDelegate:(id)aDelegate view:(UIView*)aView viewController:(UIViewController*)mViewController;
-(BOOL)textFieldShouldClear:(UITextField *)textField;
-(void)textFieldDidBeginEditing:(UITextField *)textField;

-(void)dealloc;

@end
