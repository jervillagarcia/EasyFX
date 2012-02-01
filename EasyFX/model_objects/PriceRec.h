//
//  PriceRec.h
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriceRec : NSObject {

    NSString *success;
    NSString *pair;
    NSString *bid;
    NSString *ask;
    NSString *price;
    NSString *lastBid;
    NSString *lastAsk;
    NSString *lastPrice;
    NSString *openPrice;
    
}

@property(nonatomic, retain) NSString *success;
@property(nonatomic, retain) NSString *pair;
@property(nonatomic, retain) NSString *bid;
@property(nonatomic, retain) NSString *ask;
@property(nonatomic, retain) NSString *price;
@property(nonatomic, retain) NSString *lastBid;
@property(nonatomic, retain) NSString *lastAsk;
@property(nonatomic, retain) NSString *lastPrice;
@property(nonatomic, retain) NSString *openPrice;


@end
