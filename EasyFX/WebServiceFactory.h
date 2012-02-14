//
//  WebServiceFactory.h
//  CaxtonFX
//
//  Created by Reg on 11/20/09.
//  Copyright 2009 Petra Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


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

- (NSString*)getStartHeader;
- (NSString*)getEndHeader;


int encode(unsigned s_len, char *src, unsigned d_len, char *dst);
- (BOOL)isConnectedToInternet:(NSString*)hostName;
- (BOOL)isConnectedToInternet:(NSString*)hostName withMessage:(BOOL)isWithMessage;
@end
