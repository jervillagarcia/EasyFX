//
//  Utils.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject {

}

+ (void)dotOnclick:(UITextField*)txtField;
+ (void)getExpectedLabelSize:(UILabel*)label;
+ (void)setLabelSize:(UILabel*)previousLabelValue nextLabelValue:(UILabel*)nextLabelValue nextLabelName:(UILabel*)nextLabelName;
+ (void)setNavTitleImage:(id)mDelegate;
+ (void)dismissKeyBoard:(UIView*)view;

@end
