//
//  EasyFXNavigationController.m
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EasyFXNavigationController.h"

@implementation EasyFXNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    [super initWithRootViewController:rootViewController];
    
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    return self;
}


@end
