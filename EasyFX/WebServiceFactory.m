//
//  WebServiceFactory.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "WebServiceFactory.h"
#import "EasyFXAppDelegate.h"
#import "XmlParser.h"
#import "Reachability.h"
#import "LoginParser.h"
#import "PriceRec.h"

@interface WebServiceFactory (Private)
- (NSData*)giveErrorDomainNotFound;
- (NSData*)submitRequestToHost:(NSString*)requestString soapAction:(NSString*)sAction isLogin:(BOOL)isLogin;
//- (NSString*)encryptInputString:(NSString*)inputString;
@end


@implementation WebServiceFactory

@synthesize wsResponse;

#define SOAP_ENV @"http://schemas.xmlsoap.org/soap/envelope/"
#define HOST @"www.voltrexfx.com"
#define URL_STRING @"http://www.voltrexfx.com/easyws/ews.asmx"


- (NSData*)giveErrorDomainNotFound
{
	NSMutableString *sRequest = [[[NSMutableString alloc] init] autorelease]; 	
	
	// Create the SOAP body 
	[sRequest appendFormat:@"%@=\"%@\">",@"<SOAP-ENV:Envelope xmlns:SOAP-ENV", SOAP_ENV];
    [sRequest appendString:@"<SOAP-ENV:Body>"]; 
    [sRequest appendString:@"<SOAP-ENV:Fault>"];
	[sRequest appendString:@"<faultcode>SOAP-ENV:Server</faultcode>"];
	[sRequest appendString:@"<faultstring>Unable to connect to "];
	[sRequest appendString:HOST];
	[sRequest appendString:@"Please check your internet connection."];
	[sRequest appendString:@"</faultstring>"];
	[sRequest appendString:@"</SOAP-ENV:Fault>"];
	[sRequest appendString:@"</SOAP-ENV:Body>"];
	[sRequest appendString:@"</SOAP-ENV:Envelope>"];
	
	return [sRequest dataUsingEncoding: NSASCIIStringEncoding];
}

- (NSData*)giveErrorConfigurationNotFound
{
	NSMutableString *sRequest = [[[NSMutableString alloc] init] autorelease]; 	
	
	// Create the SOAP body 
	[sRequest appendFormat:@"%@=\"%@\">",@"<SOAP-ENV:Envelope xmlns:SOAP-ENV", SOAP_ENV];
    [sRequest appendString:@"<SOAP-ENV:Body>"]; 
    [sRequest appendString:@"<SOAP-ENV:Fault>"];
	[sRequest appendString:@"<faultcode>Server</faultcode>"];
	[sRequest appendString:@"<faultstring>"];
	[sRequest appendString:@"Invalid Host Name \n Please check Settings > EasyFX"];
	[sRequest appendString:@"</faultstring>"];
	[sRequest appendString:@"</SOAP-ENV:Fault>"];
	[sRequest appendString:@"</SOAP-ENV:Body>"];
	[sRequest appendString:@"</SOAP-ENV:Envelope>"];
	
	return [sRequest dataUsingEncoding: NSASCIIStringEncoding];
}

- (NSData*)submitRequestToHost:(NSString*)requestString soapAction:(NSString*)sAction isLogin:(BOOL)isLogin;
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	//----------------------------------------------------------------------
	NSMutableData *mData;
	
    EasyFXAppDelegate *delegate = (EasyFXAppDelegate *) [[UIApplication sharedApplication] delegate];

	if ((URL_STRING == nil) || ([URL_STRING isEqualToString:@""])) {
		mData = [[NSMutableData alloc ] initWithData:[self giveErrorConfigurationNotFound]];
	} else {
		// The URL of the Webserver 
		NSURL *soapURL = [NSURL URLWithString:URL_STRING]; 
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:soapURL]; 
		NSString* soapAction = [[NSString alloc] initWithString:@"http://voltrexfx.com/webservices/"];
		
		
		
		// Add the Required values in the header. 
		[request addValue:@"text/xml;charset=UTF-8" forHTTPHeaderField:@"Content-Type"]; 
		[request addValue:[soapAction stringByAppendingString:sAction] forHTTPHeaderField:@"action"]; 
		[request setHTTPMethod:@"POST"]; 
		[request setHTTPBody:[requestString dataUsingEncoding:NSUTF8StringEncoding]]; 
        if (!isLogin) {
//            NSString *sessionCookie = @"ASP.NET_SessionId=l2ti3yuco1af4kqpjlpj0syi; path=/; HttpOnly";
            NSString *sessionCookie = [delegate sessionCookie];
            
            [request setValue:sessionCookie forHTTPHeaderField:@"Cookie"];
        }
        
		NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
		
#ifdef DEBUGGING
		NSLog(@"soapURL: %@", soapURL);
#endif
		
		// Check the connection object [
		//if(conn) { mData=[[NSMutableData data] retain]; } 
		
		// Make this class the delegate so that the other connection events fire here. 
		[NSURLConnection connectionWithRequest:request delegate:self]; 
		
		NSError *WSerror; 
		NSHTTPURLResponse *WSresponse; 
		mData = [[NSMutableData alloc ] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&WSresponse error:&WSerror]]; 
		
        if (isLogin) {
            NSDictionary *respDict = [WSresponse allHeaderFields];
            
            [delegate setSessionCookie:[respDict objectForKey:@"Set-Cookie"]];
            
#ifdef DEBUGGING
            NSLog(@"Cookie: %@", [delegate sessionCookie]);
#endif
            
        }
        
        if (WSerror && !WSresponse) {
			[mData release];
			mData = [[NSMutableData alloc ] initWithData:[self giveErrorDomainNotFound]];
		}
		[conn release];
		[soapAction release];
		//----------------------------------------------------------------------
		[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	}		
	
	return [mData autorelease];
}

- (void)dealloc {
	[wsResponse release];
	[result release];
    [super dealloc];
}


- (void)logInWithUser:(NSString*)m_user password:(NSString*)m_password clientId:(NSString*)m_clientId
{
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: logInWithUser");
#endif

	if ([self isConnectedToInternet:HOST withMessage:NO]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:LogIn>"];
		[sRequest appendString:@"<sch:parameters>"];
		[sRequest appendString:@"<sch:ClientID>"];
		[sRequest appendString:m_clientId];
		[sRequest appendString:@"</sch:ClientID>"];
		[sRequest appendString:@"<sch:UserID>"];
		[sRequest appendString:m_user];
		[sRequest appendString:@"</sch:UserID>"];
		[sRequest appendString:@"<sch:Password>"];
		[sRequest appendString:m_password];
		[sRequest appendString:@"</sch:Password>"];
		[sRequest appendString:@"</sch:parameters>"];
		[sRequest appendString:@"</sch:LogIn>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif
		
		LoginParser *xmlParser = [[LoginParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"LogIn" isLogin:YES] fromURI:@"LogInResult" toObject:@"LogInResult" parseError:nil];
        
#ifdef DEBUGGING
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif

		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		[sRequest release];
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: logIn");
    NSLog(@"---------------------");
#endif
}

- (void)getDealCurrencies
{

#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: getDealCurrencies");
#endif

	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetCurrencyList/>"];
		[sRequest appendString:[self getEndHeader]];
		

#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif

		
        XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"PriceRec" toObject:@"PriceRec" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: getDealCurrencies");
    NSLog(@"---------------------");
#endif
}

- (void)logOut
{
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: logOut");
#endif
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:LogOut/>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif

		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"LogOut" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"nil" toObject:@"" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif

		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: logOut");
    NSLog(@"---------------------");
#endif
}

- (void)getBeneficiaries{
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: getBeneficiaries");
#endif
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetBeneficiaryList/>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif

		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetBeneficiaryList" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"BeneficiaryRec" toObject:@"BeneficiaryRec" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif

		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: getBeneficiaries");
    NSLog(@"---------------------");
#endif
}

- (void)getCardsList{
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: getCardsList");
#endif
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetCardList/>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif

		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCardList" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"CardRec" toObject:@"CardRec" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: getCardsList");
    NSLog(@"---------------------");
#endif
}

- (void)setCCYList:(NSArray*)ccyList {
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: setCCYList");
#endif
    if ([self isConnectedToInternet:HOST]) {
        
        // Skip Operation when list = 0
        if ([ccyList count] == 0) return;
        
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:SetCurrencyList>"];
		[sRequest appendString:@"<sch:CCYPairs>"];
        for (id ccyPair in ccyList) {
            [sRequest appendString:@"<sch:string>"];
            [sRequest appendString:ccyPair];
            [sRequest appendString:@"</sch:string>"];
        }
        
		[sRequest appendString:@"</sch:CCYPairs>"];
		[sRequest appendString:@"</sch:SetCurrencyList>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif

		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"SetCurrencyList" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"SetCurrencyListResult" toObject:@"Result" parseError:nil];
                
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif

		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: setCCYList");
    NSLog(@"---------------------");
#endif
}

- (void)makeDeal:(Payment*)payment {
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: makeDeal");
#endif
    if ([self isConnectedToInternet:HOST]) {
        
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:MakeADeal>"];
		[sRequest appendString:@"<sch:CardID>"];
		[sRequest appendString:payment.cardRec.iD];
		[sRequest appendString:@"</sch:CardID>"];
		[sRequest appendString:@"<sch:CVV>"];
		[sRequest appendString:payment.cvv];
		[sRequest appendString:@"</sch:CVV>"];
		[sRequest appendString:@"<sch:Rate>"];
		[sRequest appendString:payment.rate];
		[sRequest appendString:@"</sch:Rate>"];
		[sRequest appendString:@"<sch:BuyCCY>"];
		[sRequest appendString:payment.buyCCY];
		[sRequest appendString:@"</sch:BuyCCY>"];
		[sRequest appendString:@"<sch:BuyAmount>"];
		[sRequest appendString:payment.buyAmount];
		[sRequest appendString:@"</sch:BuyAmount>"];
		[sRequest appendString:@"<sch:SellCCY>"];
		[sRequest appendString:payment.sellCCY];
		[sRequest appendString:@"</sch:SellCCY>"];
		[sRequest appendString:@"<sch:SellAmount>"];
		[sRequest appendString:payment.sellAmount];
		[sRequest appendString:@"</sch:SellAmount>"];
		[sRequest appendString:@"<sch:PayeeID>"];
		[sRequest appendString:payment.beneficiaryRec.iD];
		[sRequest appendString:@"</sch:PayeeID>"];
		[sRequest appendString:@"<sch:Reference>"];
		[sRequest appendString:@" "];
		[sRequest appendString:@"</sch:Reference>"];
		[sRequest appendString:@"</sch:MakeADeal>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
        NSLog(@"Request: ----->  %@", sRequest);
#endif
        
		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"MakeADeal" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"MakeADealResult" toObject:@"DealResult" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: MakeDeal");
    NSLog(@"---------------------");
#endif
}

- (void)AddCard:(CardRec*)cardRec {
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: AddCard");
#endif
    if ([self isConnectedToInternet:HOST]) {
        
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:AddCard>"];
		[sRequest appendString:@"<sch:CardNumber>"];
		[sRequest appendString:cardRec.cardNumber];
		[sRequest appendString:@"</sch:CardNumber>"];
		[sRequest appendString:@"<sch:CVV>"];
		[sRequest appendString:cardRec.cvv];
		[sRequest appendString:@"</sch:CVV>"];
		[sRequest appendString:@"<sch:StartDate>"];
		[sRequest appendString:cardRec.startDate];
		[sRequest appendString:@"</sch:StartDate>"];
		[sRequest appendString:@"<sch:IssueNumber>"];
		[sRequest appendString:cardRec.issueNumber];
		[sRequest appendString:@"</sch:IssueNumber>"];
		[sRequest appendString:@"<sch:ExpiryDate>"];
		[sRequest appendString:cardRec.expiryDate];
		[sRequest appendString:@"</sch:ExpiryDate>"];
		[sRequest appendString:@"<sch:Name>"];
		[sRequest appendString:cardRec.name];
		[sRequest appendString:@"</sch:Name>"];
		[sRequest appendString:@"<sch:Address1>"];
		[sRequest appendString:cardRec.address1];
		[sRequest appendString:@"</sch:Address1>"];
		[sRequest appendString:@"<sch:Address2>"];
		[sRequest appendString:cardRec.address2];
		[sRequest appendString:@"</sch:Address2>"];
		[sRequest appendString:@"<sch:Address3>"];
		[sRequest appendString:cardRec.address3];
		[sRequest appendString:@"</sch:Address3>"];
		[sRequest appendString:@"<sch:PostCode>"];
		[sRequest appendString:cardRec.postCode];
		[sRequest appendString:@"</sch:PostCode>"];
		[sRequest appendString:@"<sch:CountryCode>"];
		[sRequest appendString:cardRec.countryCode];
		[sRequest appendString:@"</sch:CountryCode>"];
		[sRequest appendString:@"</sch:AddCard>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
        NSLog(@"Request: ----->  %@", sRequest);
#endif
        
		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"AddCard" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"AddCardResult" toObject:@"Result" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}

#ifdef DEBUGGING
    NSLog(@"END METHOD: AddCard");
    NSLog(@"---------------------");
#endif

}

- (void)checkPostCode:(NSString*)postCode{
#ifdef DEBUGGING
    NSLog(@"-------WEBSERVICE FACTORY--------");
    NSLog(@"START METHOD: checkPostCode");
#endif
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:CheckPostcode>"];
		[sRequest appendString:@"<sch:PostCode>"];
		[sRequest appendString:postCode];
		[sRequest appendString:@"</sch:PostCode>"];
		[sRequest appendString:@"</sch:CheckPostcode>"];
		[sRequest appendString:[self getEndHeader]];
		
#ifdef DEBUGGING
		NSLog(@"Request: %@", sRequest);
#endif
        
		XmlParser *xmlParser = [[XmlParser alloc] init];
        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"CheckPostcode" isLogin:NO];
		[xmlParser parseXMLData:mData fromURI:@"CheckPostcodeResult" toObject:@"CheckPostcodeResult" parseError:nil];
        
#ifdef DEBUGGING
        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
#endif
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
#ifdef DEBUGGING
    NSLog(@"END METHOD: checkPostCode");
    NSLog(@"---------------------");
#endif
}


- (NSString*)getStartHeader {
	return [NSString stringWithFormat:@"%@=\"%@\" xmlns:sch=\"http://voltrexfx.com/webservices/\"> <soapenv:Header/> <soapenv:Body>",@"<soapenv:Envelope xmlns:soapenv", SOAP_ENV];
}

- (NSString*)getEndHeader {
	return @"</soapenv:Body> </soapenv:Envelope>";
}


static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
"abcdefghijklmnopqrstuvwxyz"
"0123456789"
"+/";

int encode(unsigned s_len, char *src, unsigned d_len, char *dst)
{
    unsigned triad;
	
    for (triad = 0; triad < s_len; triad += 3)
    {
		unsigned long int sr;
		unsigned byte;
		
		for (byte = 0; (byte<3)&&(triad+byte<s_len); ++byte)
		{
			sr <<= 8;
			sr |= (*(src+triad+byte) & 0xff);
		}
		
		sr <<= (6-((8*byte)%6))%6; /*shift left to next 6bit alignment*/
		
		if (d_len < 4) return 1; /* error - dest too short */
		
		*(dst+0) = *(dst+1) = *(dst+2) = *(dst+3) = '=';
		switch(byte)
		{
			case 3:
				*(dst+3) = base64[sr&0x3f];
				sr >>= 6;
			case 2:
				*(dst+2) = base64[sr&0x3f];
				sr >>= 6;
			case 1:
				*(dst+1) = base64[sr&0x3f];
				sr >>= 6;
				*(dst+0) = base64[sr&0x3f];
		}
		dst += 4; d_len -= 4;
    }
	
    return 0;
	
}

- (BOOL)isConnectedToInternet:(NSString*)hostName {
	return [self isConnectedToInternet:hostName withMessage:YES];
}

- (BOOL)isConnectedToInternet:(NSString*)hostName withMessage:(BOOL)isWithMessage {
	if ((hostName == nil) || [hostName  isEqualToString:@""]){ 
		[[NSUserDefaults standardUserDefaults] synchronize];
	}

	Reachability* reachability = [Reachability reachabilityWithHostName:hostName];
	
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired= [reachability connectionRequired];
	BOOL isConnected = NO;
    //NSString* statusString= @"";
	
    switch (netStatus)
	
    {
			
        case NotReachable:
			
        {
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to server" 
															message:@"Please check your internet connection"
														   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
			[alert show];	
			[alert release];
			isConnected = NO;
            break;
        }
			
            
			
        case ReachableViaWWAN:
			
        {
			
            //statusString = @"Reachable WWAN";
			if (connectionRequired) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to server" 
																message:@"Please check your internet connection"
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];	
				[alert release];
				isConnected = NO;
			} else {
				isConnected = YES;
			}
            break;
        }
			
        case ReachableViaWiFi:
			
        {
			
			//statusString= @"Reachable WiFi";
			if (connectionRequired) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not connect to server" 
																message:@"Please check your internet connection"
															   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
				[alert show];	
				[alert release];
				isConnected = NO;
			} else {
				isConnected = YES;
			}
            break;
			
		}
			
    }
	
	return isConnected;
}

@end