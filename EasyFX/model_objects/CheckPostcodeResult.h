//
//  CheckPostcodeResult.h
//  EasyFX
//
//  Created by James Errol Villagarcia on 3/12/12.
//  Copyright (c) 2012 TELUS International Philippines. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckPostcodeResult : NSObject {
    NSString        *success;    
    NSString        *premises;
    NSString        *address1;
    NSString        *county;
    NSString        *postCode;
    NSString        *errorMsg;
}

@property(nonatomic,retain) NSString        *success;    
@property(nonatomic,retain) NSString        *premises;
@property(nonatomic,retain) NSString        *address1;
@property(nonatomic,retain) NSString        *county;
@property(nonatomic,retain) NSString        *postCode;
@property(nonatomic,retain) NSString        *errorMsg;

@end
