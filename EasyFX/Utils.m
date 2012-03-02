//
//  Utils.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
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

+ (void)dismissKeyBoard:(UIView*)view {
    for (id subView in view.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *txtField = subView;
            [txtField resignFirstResponder];
        }
    }
}
    
+ (void)setNavTitleImage:(id)mDelegate {

    UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_logo.png"]] autorelease];
    
    //set contentMode to scale aspect to fit
    imageView.contentMode = UIViewContentModeCenter;
    
    [(UIViewController*)mDelegate navigationController].navigationBar.topItem.titleView = imageView;
    
}


@end
