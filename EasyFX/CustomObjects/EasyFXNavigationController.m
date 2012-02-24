//
//  EasyFXNavigationController.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "EasyFXNavigationController.h"

@implementation EasyFXNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController {
    [super initWithRootViewController:rootViewController];
    
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
    return self;
}


@end
