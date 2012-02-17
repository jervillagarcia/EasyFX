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

+ (void)setNavTitleImage:(id)mDelegate {
//    UIImage  *buttonImage = [UIImage imageNamed:@"back_button.png"];
//    UIImage  *editImage = [UIImage imageNamed:@"edit_currency_icon.png"];
//    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setImage:buttonImage forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    [button1 setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];    
//    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setImage:editImage forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
//    [button2 setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];    
//    
//    //Logout Button
//    UIBarButtonItem *backItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
//    [mDelegate.navigationController.navigationBar.topItem     setLeftBarButtonItem:backItem1];
//    
//    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
//    [mDelegate.navigationController.navigationBar.topItem     setRightBarButtonItem:backItem2];
    
    [(UIViewController*)mDelegate navigationController].navigationBar.topItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_logo.png"]] autorelease];
}

+ (CGGradientRef*)createNormalGradient
{
    CGFloat locations[3];
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:3];
    UIColor *color = [UIColor colorWithRed:0.283 green:0.32 blue:0.414 alpha:1.0];
    [colors addObject:(id)[color CGColor]];
    locations[0] = 0.0;
    color = [UIColor colorWithRed:0.82 green:0.834 blue:0.87 alpha:1.0];
    [colors addObject:(id)[color CGColor]];
    locations[1] = 1.0;
    color = [UIColor colorWithRed:0.186 green:0.223 blue:0.326 alpha:1.0];
    [colors addObject:(id)[color CGColor]];
    locations[2] = 0.483;  
    
    CGGradientRef ret = CGGradientCreateWithColors(space, (CFArrayRef)colors, locations);
    CGColorSpaceRelease(space);
    return ret;
}

@end
