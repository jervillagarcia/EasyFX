//
//  Utils.h
//  CaxtonFX
//
//  Created by Errol Villagarcia on 3/2/10.
//  Copyright 2010 Petra Financial Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Utils : NSObject {

}

+ (void)dotOnclick:(UITextField*)txtField;
+ (void)getExpectedLabelSize:(UILabel*)label;
+ (void)setLabelSize:(UILabel*)previousLabelValue nextLabelValue:(UILabel*)nextLabelValue nextLabelName:(UILabel*)nextLabelName;

@end
