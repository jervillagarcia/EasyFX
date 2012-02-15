//
//  PriceRec.m
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PriceRec.h"

@implementation PriceRec 
    
@synthesize success;
@synthesize pair;
@synthesize bid;
@synthesize ask;
@synthesize price;
@synthesize lastBid;
@synthesize lastAsk;
@synthesize lastPrice;
@synthesize openPrice;
@synthesize selected;
    

- (NSString*)getCurrencyYouBuy{
	return [pair substringWithRange:NSMakeRange(3,3)];
}

- (NSString*)getCurrencyYouSell{
	return [pair substringWithRange:NSMakeRange(0,3)];
}


@end
