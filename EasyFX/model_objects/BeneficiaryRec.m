//
//  BeneficiaryRec.m
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BeneficiaryRec.h"

@implementation BeneficiaryRec

@synthesize iD;
@synthesize beneficiaryName;
@synthesize currencyCode;
@synthesize countryCode;
@synthesize bankName;
@synthesize bankAddress1;
@synthesize bankAddress2;
@synthesize bankAddress3;
@synthesize bankCode;
@synthesize accountNumber;
@synthesize sWIFTBIC;
@synthesize iBAN;
@synthesize reference1;
@synthesize reference2;
@synthesize reference3;

- (NSString*)getBankAddress {
    return [NSString stringWithFormat:@"%@ %@", bankAddress1, bankAddress2];
    
}

@end
