//
//  CardRec.h
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardRec : NSObject {
    NSString *iD;
    NSString *cardNumber;
    NSString *startDate;
    NSString *issueNumber;
    NSString *expiryDate;
    NSString *name;
    NSString *address1;
    NSString *address2;
    NSString *address3;
    NSString *postCode;
    NSString *countryCode;
    NSString *cvv;
}

@property(nonatomic, retain) NSString *iD;
@property(nonatomic, retain) NSString *cardNumber;
@property(nonatomic, retain) NSString *startDate;
@property(nonatomic, retain) NSString *issueNumber;
@property(nonatomic, retain) NSString *expiryDate;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *address1;
@property(nonatomic, retain) NSString *address2;
@property(nonatomic, retain) NSString *address3;
@property(nonatomic, retain) NSString *postCode;
@property(nonatomic, retain) NSString *countryCode;
@property(nonatomic, retain) NSString *cvv;

@end
