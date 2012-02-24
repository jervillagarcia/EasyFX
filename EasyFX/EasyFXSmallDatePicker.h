//
//  EasyFXSmallDatePicker.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EasyFXSmallDatePicker : NSObject {
	
}

+(void)showSmallDatePicker:(NSString*)title 
			 delegate:(id)aDelegate 
	   actionDelegate:(id)actionDelegate
				 view:(UIView*)view 
		 currentValue:(NSString*)aValue;
@end
