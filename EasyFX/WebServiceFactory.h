//
//  WebServiceFactory.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Payment.h"

@interface WebServiceFactory : NSObject {
	
	NSMutableArray *result;
	NSArray		   *wsResponse;
}

@property(nonatomic,retain) NSArray* wsResponse;

- (void)logInWithUser:(NSString*)m_user password:(NSString*)m_password clientId:(NSString*)m_clientId;
- (void)getDealCurrencies;
- (void)logOut;
- (void)getBeneficiaries;
- (void)getCardsList;
- (void)setCCYList:(NSArray*)ccyList;
- (void)makeDeal:(Payment*)payment;
- (void)AddCard:(CardRec*)cardRec;
- (void)checkPostCode:(NSString*)postCode;

- (NSString*)getStartHeader;
- (NSString*)getEndHeader;


int encode(unsigned s_len, char *src, unsigned d_len, char *dst);
- (BOOL)isConnectedToInternet:(NSString*)hostName;
- (BOOL)isConnectedToInternet:(NSString*)hostName withMessage:(BOOL)isWithMessage;
@end
