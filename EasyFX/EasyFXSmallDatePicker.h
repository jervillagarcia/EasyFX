//
//  UIObiSmallDatePicker.h
//  iCG
//
//  Created by James Errol Villagarcia on 6/19/11.
//  Copyright 2011 iCG. All rights reserved.
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
