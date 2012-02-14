//
//  WebServiceFactory.m
//  CaxtonFX
//
//  Created by Reg on 11/20/09.
//  Copyright 2009 Petra Financial Ltd. All rights reserved.
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
		
		NSLog(@"soapURL: %@", soapURL);
		
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
            
            NSLog(@"Cookie: %@", [delegate sessionCookie]);
            
            //        for (id key in respDict) {
            //            id anObject = [respDict objectForKey:key];
            //            
            //            NSLog(@"KEY: %@   VALUE:%@", key, anObject);
            //            
            //            /* Do something with anObject. */
            //        }
            
            
            //        NSLog(@"Cookie Session: %@", cookie);
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
		
		NSLog(@"Request: %@", sRequest);
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"ValidateUser"] fromURI:@"Table" toObject:@"UserDetail" parseError:nil];
		LoginParser *xmlParser = [[LoginParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"LogIn" isLogin:YES] fromURI:@"LogInResult" toObject:@"LogInResult" parseError:nil];
        
//        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"LogIn" isLogin:YES];
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);

		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		[sRequest release];
		[xmlParser release];
	}
}

- (void)getDealCurrencies
{
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetCurrencyList/>"];
		[sRequest appendString:[self getEndHeader]];
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetDealCurrencies"] fromURI:@"DealCurrency" toObject:@"DealCurrency" parseError:nil];
		XmlParser *xmlParser = [[XmlParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO] fromURI:@"PriceRec" toObject:@"PriceRec" parseError:nil];
        
        //        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        //        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
}

- (void)logOut
{
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:LogOut/>"];
		[sRequest appendString:[self getEndHeader]];
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetDealCurrencies"] fromURI:@"DealCurrency" toObject:@"DealCurrency" parseError:nil];
		XmlParser *xmlParser = [[XmlParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"LogOut" isLogin:NO] fromURI:@"nil" toObject:@"" parseError:nil];
        
        //        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        //        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
}

- (void)getBeneficiaries{
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetBeneficiaryList/>"];
		[sRequest appendString:[self getEndHeader]];
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetDealCurrencies"] fromURI:@"DealCurrency" toObject:@"DealCurrency" parseError:nil];
		XmlParser *xmlParser = [[XmlParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetBeneficiaryList" isLogin:NO] fromURI:@"BeneficiaryRec" toObject:@"BeneficiaryRec" parseError:nil];
        
        //        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        //        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
}

- (void)getCardsList{
	if ([self isConnectedToInternet:HOST]) {
		NSMutableString *sRequest = [[NSMutableString alloc] init]; 
		// Create the SOAP body 
		[sRequest appendFormat:[self getStartHeader]];
		[sRequest appendString:@"<sch:GetCardList/>"];
		[sRequest appendString:[self getEndHeader]];
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetDealCurrencies"] fromURI:@"DealCurrency" toObject:@"DealCurrency" parseError:nil];
		XmlParser *xmlParser = [[XmlParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetCardList" isLogin:NO] fromURI:@"CardRec" toObject:@"CardRec" parseError:nil];
        
        //        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        //        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
}

- (void)setCCYList:(NSArray*)ccyList {
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
            [sRequest appendString:[(PriceRec*)ccyPair pair]];
            [sRequest appendString:@"<sch:string/>"];
        }
        
		[sRequest appendString:@"<sch:CCYPairs/>"];
		[sRequest appendString:@"<sch:SetCurrencyList/>"];
		[sRequest appendString:[self getEndHeader]];
		
		//** MEMORY LEAK--> XmlParser *xmlParser = [[XmlParser alloc] parseXMLData:[self submitRequestToHost:sRequest soapAction:@"GetDealCurrencies"] fromURI:@"DealCurrency" toObject:@"DealCurrency" parseError:nil];
		XmlParser *xmlParser = [[XmlParser alloc] init];
		[xmlParser parseXMLData:[self submitRequestToHost:sRequest soapAction:@"SetCurrencyList" isLogin:NO] fromURI:@"SetCurrencyListResult" toObject:@"SetCurrencyListResult" parseError:nil];
        
        //        NSData *mData = [self submitRequestToHost:sRequest soapAction:@"GetCurrencyList" isLogin:NO];
        //        NSLog(@"Response: %@", [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]);
        
		[self.wsResponse release];
		self.wsResponse = [[[NSMutableArray alloc] initWithArray:[xmlParser items]] autorelease];
		
		[sRequest release];	
		[xmlParser release];
	}
    
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