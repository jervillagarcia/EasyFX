//
//  CaxtonPreloader.h
//  CaxtonFX
//
//  Created by Errol Villagarcia on 4/6/10.
//  Copyright 2010 Petra Financial Ltd.. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EasyFXPreloader : UIView {

}

- (id)initWithFrame:(CGRect)frame message:(NSString*)message;
- (void)setMessage:(NSString*)message;

@end
