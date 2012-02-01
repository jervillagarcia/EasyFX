//
//  LogInResult.h
//  EasyFX
//
//  Created by Errol on 1/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInResult : NSObject {
    NSString *success;
    NSString *errorId;
    NSString *errorMsg;
    NSString *limit;
    NSString *fee;
    NSString *count;
    NSArray *ccyPairs;
}


@property(nonatomic, retain) NSString *success;
@property(nonatomic, retain) NSString *errorId;
@property(nonatomic, retain) NSString *errorMsg;
@property(nonatomic, retain) NSString *limit;
@property(nonatomic, retain) NSString *fee;
@property(nonatomic, retain) NSString *count;
@property(nonatomic, retain) NSArray *ccyPairs;

@end
