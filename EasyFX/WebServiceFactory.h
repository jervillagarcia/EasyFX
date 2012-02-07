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
- (void)getBeneficiaryDetails:(NSString*)beneficiaryId;
- (void)makeDeal:(NSString*)contactId 
 strVendorTxCode:(NSString*)vendorTxCode
paymentDetailsId:(NSString*)paymentDetailsId
		  strCV2:(NSString*)cvv
	 sExpiryDate:(NSString*)expiryDate
	  sStartDate:(NSString*)startDate
	sIssueNumber:(NSString*)issueNo
	  clientRate:(NSString*)clientRate
	  sCurBought:(NSString*)currBought
	   amtBought:(NSString*)amtBought
		sCurSold:(NSString*)currSold
		 amtSold:(NSString*)amtSold
   beneficiaryId:(NSString*)beneficiaryId
  sYourReference:(NSString*)youReference
 sFurtherDetails:(NSString*)furtherDetails;
- (void)getPaymentDetail:(NSString*)contactId;
- (void)getContactDetail:(NSString*)accountId;

//- (NSString*)giveHostDomain;
- (NSString*)getStartHeader;
- (NSString*)getEndHeader;


int encode(unsigned s_len, char *src, unsigned d_len, char *dst);
- (BOOL)isConnectedToInternet:(NSString*)hostName;
- (BOOL)isConnectedToInternet:(NSString*)hostName withMessage:(BOOL)isWithMessage;
@end
