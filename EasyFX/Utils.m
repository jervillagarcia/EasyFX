//
//  Utils.m
//  CaxtonFX
//
//  Created by Errol Villagarcia on 3/2/10.
//  Copyright 2010 Petra Financial Ltd.. All rights reserved.
//

#import "Utils.h"


@implementation Utils

+ (void)dotOnclick:(UITextField*)txtField {
	NSRange resultsRange = [[txtField text] rangeOfString:@"." options:NSCaseInsensitiveSearch];
	if (resultsRange.length == 0) {
		NSMutableString *newText = [[[NSMutableString alloc] initWithString:[txtField text]] autorelease];
		[newText appendString:@"."];
		[txtField setText:newText];
		
	}
}

+ (void)getExpectedLabelSize:(UILabel*)label {
	CGSize maximumLabelSize = CGSizeMake(label.frame.size.width, 9999);
	
	CGSize expectedLabelSize = [label.text sizeWithFont:label.font 
								constrainedToSize:maximumLabelSize 
								lineBreakMode:label.lineBreakMode]; 
	
	CGRect newFrame = label.frame;
	newFrame.size.height = expectedLabelSize.height > label.frame.size.height ? expectedLabelSize.height : label.frame.size.height;
	label.frame = newFrame;
}

+ (void)setLabelSize:(UILabel*)previousLabelValue nextLabelValue:(UILabel*)nextLabelValue nextLabelName:(UILabel*)nextLabelName {
	CGFloat newY = previousLabelValue.frame.origin.y + previousLabelValue.frame.size.height + 3.0; 
	
	nextLabelValue.frame = CGRectMake(nextLabelValue.frame.origin.x, newY, nextLabelValue.frame.size.width , nextLabelValue.frame.size.height); 
	nextLabelName.frame = CGRectMake(nextLabelName.frame.origin.x, newY, nextLabelName.frame.size.width , nextLabelName.frame.size.height);
}

@end
