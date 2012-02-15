//
//  Payment.h
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceRec.h"
#import "CardRec.h"
#import "BeneficiaryRec.h"

@interface Payment : NSObject {
    BeneficiaryRec  *beneficiaryRec;
    CardRec         *cardRec;
    NSString        *cvv;
    NSString        *rate;
    NSString        *buyCCY;
    NSString        *buyAmount;
    NSString        *sellCCY;
    NSString        *sellAmount;
    NSString        *reference;
}

@property(nonatomic, retain) BeneficiaryRec  *beneficiaryRec;
@property(nonatomic, retain) CardRec         *cardRec;
@property(nonatomic, retain) NSString        *cvv;
@property(nonatomic, retain) NSString        *rate;
@property(nonatomic, retain) NSString        *buyCCY;
@property(nonatomic, retain) NSString        *buyAmount;
@property(nonatomic, retain) NSString        *sellCCY;
@property(nonatomic, retain) NSString        *sellAmount;
@property(nonatomic, retain) NSString        *reference;


@end
