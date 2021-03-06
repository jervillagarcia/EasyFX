//
//  EasyFXSmallDateFieldDelegate.h
//  EasyFX
//
//  Created by James Errol Villagarcia on 6/19/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EasyFXSmallDateFieldDelegate : NSObject<UITextFieldDelegate> {
	id				delegate;
	NSString		*title;
	UIView			*view;
	BOOL			isEditing;
	NSArray			*col1Arr;
	NSArray			*col2Arr;
	UITextField		*curTxtField;
	
}

@property(nonatomic, retain) UITextField *curTxtField;
@property(nonatomic, retain) id delegate;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) UIView *view;
@property(nonatomic, retain) NSArray *col1Arr;
@property(nonatomic, retain) NSArray *col2Arr;

-(id)initDelegate:(id)aDelegate view:(UIView*)aView;
-(id)initDelegateWithTitle:(NSString*)title delegate:(id)aDelegate view:(UIView*)aView;
-(BOOL)textFieldShouldClear:(UITextField *)textField;
-(void)textFieldDidBeginEditing:(UITextField *)textField;

-(void)goToNextField:(int)aTag;

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *) pickerView;
-(NSString*)getPickerValue:(UIPickerView*)pickerView;
-(NSString*)getPickerValue:(UIPickerView*)pickerView withFormat:(NSString*)format;
-(void)dealloc;

@end
