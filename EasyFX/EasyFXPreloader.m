//
//  EasyFXPreloader.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "EasyFXPreloader.h"
#import <QuartzCore/QuartzCore.h>

@implementation EasyFXPreloader

#define ROUNDED_VIEW_HEIGHT		150
#define ROUNDED_VIEW_WIDTH		290

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:CGRectMake(0, 50, frame.size.width, frame.size.height-130)]) {
        // Initialization code
		//self.alpha = 0.4;
		
		//self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];;
		self.backgroundColor = [UIColor clearColor];
		
		UIView *roundedView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - (ROUNDED_VIEW_WIDTH / 2) , CGRectGetMidY(self.frame) - (ROUNDED_VIEW_HEIGHT / 2) - 55, ROUNDED_VIEW_WIDTH, ROUNDED_VIEW_HEIGHT)];
		roundedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
		[roundedView.layer setCornerRadius:10.0];
		[roundedView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
		[roundedView.layer setBorderWidth:2.0];
	
		UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		indicatorView.frame = CGRectMake((roundedView.frame.size.width / 2) - (indicatorView.frame.size.width / 2), 
										 (roundedView.frame.size.height / 2) - (indicatorView.frame.size.height / 2) - 20,	
										 indicatorView.frame.size.width, 
										 indicatorView.frame.size.height);
		
		UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(0, indicatorView.frame.origin.y + indicatorView.frame.size.height + 5, 
																		ROUNDED_VIEW_WIDTH, 
																		25)];
		[lblLoading setFont:[UIFont systemFontOfSize:20]];
		[lblLoading setTextAlignment:UITextAlignmentCenter];
		[lblLoading setText:@"Loading..."];
		[lblLoading setTextColor:[UIColor whiteColor]];
		[lblLoading setBackgroundColor:[UIColor clearColor]];
		[lblLoading setTag:2];
		
		[indicatorView startAnimating];
		[roundedView addSubview:indicatorView];
		[roundedView addSubview:lblLoading];
		
		[self addSubview:roundedView];
		
		[lblLoading release];
		[indicatorView release];
		[roundedView release];
		
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame message:(NSString*)message {
    if (self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)]) {
        // Initialization code
		//self.alpha = 0.4;
		
		//self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];;
		self.backgroundColor = [UIColor clearColor];
		
		UIView *roundedView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - (ROUNDED_VIEW_WIDTH / 2) , CGRectGetMidY(self.frame) - (ROUNDED_VIEW_HEIGHT / 2) - 75 , ROUNDED_VIEW_WIDTH, ROUNDED_VIEW_HEIGHT)];
		roundedView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
		[roundedView.layer setCornerRadius:10.0];
		[roundedView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
		[roundedView.layer setBorderWidth:2.0];
		
		UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		indicatorView.frame = CGRectMake((roundedView.frame.size.width / 2) - (indicatorView.frame.size.width / 2), 
										 (roundedView.frame.size.height / 2) - (indicatorView.frame.size.height / 2) - 20,	
										 indicatorView.frame.size.width, 
										 indicatorView.frame.size.height);
		
		UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake(0, indicatorView.frame.origin.y + indicatorView.frame.size.height + 5, 
																		ROUNDED_VIEW_WIDTH, 
																		25)];
		[lblLoading setFont:[UIFont systemFontOfSize:20]];
		[lblLoading setTextAlignment:UITextAlignmentCenter];
		[lblLoading setText:message];
		[lblLoading setTextColor:[UIColor whiteColor]];
		[lblLoading setBackgroundColor:[UIColor clearColor]];
		[lblLoading setTag:2];
		
		[indicatorView startAnimating];
		[roundedView addSubview:indicatorView];
		[roundedView addSubview:lblLoading];
		
		[self addSubview:roundedView];
		
		[lblLoading release];
		[indicatorView release];
		[roundedView release];
		
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)setMessage:(NSString*)message {
	[(UILabel*)[self viewWithTag:2] setText:message];
}

- (void)dealloc {
    [super dealloc];
}


@end
