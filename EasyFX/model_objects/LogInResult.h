//
//  LogInResult.h
//  EasyFX
//
//  Created by Errol on 1/31/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInResult : NSObject {
    NSString *success;
    NSString *errorID;
    NSString *errorMsg;
    NSString *limit;
    NSString *bankLimit;
    NSString *fee;
    NSString *count;
    NSArray *cCYPairs;
    NSString *address1;
    NSString *address2;
    NSString *address3;
    NSString *postCode;
    NSString *country;
}


@property(nonatomic, retain) NSString *success;
@property(nonatomic, retain) NSString *errorID;
@property(nonatomic, retain) NSString *errorMsg;
@property(nonatomic, retain) NSString *limit;
@property(nonatomic, retain) NSString *bankLimit;
@property(nonatomic, retain) NSString *fee;
@property(nonatomic, retain) NSString *count;
@property(nonatomic, retain) NSArray *cCYPairs;
@property(nonatomic, retain) NSString *address1;
@property(nonatomic, retain) NSString *address2;
@property(nonatomic, retain) NSString *address3;
@property(nonatomic, retain) NSString *postCode;
@property(nonatomic, retain) NSString *country;

@end
