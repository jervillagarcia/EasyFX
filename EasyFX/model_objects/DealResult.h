//
//  DealResult.h
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DealResult : NSObject {
    
    NSString    *success;
    NSString    *errorID;
    NSString    *errorMsg;
    NSString    *dealNumber;
    NSString    *limit;
    NSString    *bankLimit;
    
}

@property(nonatomic, retain) NSString    *success;
@property(nonatomic, retain) NSString    *errorID;
@property(nonatomic, retain) NSString    *errorMsg;
@property(nonatomic, retain) NSString    *dealNumber;
@property(nonatomic, retain) NSString    *limit;
@property(nonatomic, retain) NSString    *bankLimit;

@end
