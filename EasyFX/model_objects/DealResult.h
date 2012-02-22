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
    
}

@property(nonatomic, retain) NSString    *success;
@property(nonatomic, retain) NSString    *errorID;
@property(nonatomic, retain) NSString    *errorMsg;
@property(nonatomic, retain) NSString    *dealNumber;

@end
