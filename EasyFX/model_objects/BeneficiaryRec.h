//
//  BeneficiaryRec.h
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeneficiaryRec : NSObject {
    NSString *iD;
    NSString *beneficiaryName;
    NSString *currencyCode;
    NSString *countryCode;
    NSString *bankName;
    NSString *bankAddress1;
    NSString *bankAddress2;
    NSString *bankAddress3;
    NSString *bankCode;
    NSString *accountNumber;
    NSString *sWIFTBIC;
    NSString *iBAN;
    NSString *reference1;
    NSString *reference2;
    NSString *reference3;
}

@property(nonatomic, retain) NSString *iD;
@property(nonatomic, retain) NSString *beneficiaryName;
@property(nonatomic, retain) NSString *currencyCode;
@property(nonatomic, retain) NSString *countryCode;
@property(nonatomic, retain) NSString *bankName;
@property(nonatomic, retain) NSString *bankAddress1;
@property(nonatomic, retain) NSString *bankAddress2;
@property(nonatomic, retain) NSString *bankAddress3;
@property(nonatomic, retain) NSString *bankCode;
@property(nonatomic, retain) NSString *accountNumber;
@property(nonatomic, retain) NSString *sWIFTBIC;
@property(nonatomic, retain) NSString *iBAN;
@property(nonatomic, retain) NSString *reference1;
@property(nonatomic, retain) NSString *reference2;
@property(nonatomic, retain) NSString *reference3;

- (NSString*)getBankAddress;

@end
