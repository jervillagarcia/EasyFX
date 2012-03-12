//
//  EasyFXAppDelegate.h
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Payment.h"
#import "CountryParser.h"

@interface EasyFXAppDelegate : NSObject <UIApplicationDelegate> {
    NSString    *sessionCookie;
    NSArray     *ccyPairList;
    NSString    *limit;
    NSString    *fee;
    NSString    *address1;
    NSString    *address2;
    NSString    *address3;
    NSString    *postCode;
    NSString    *countryCode;
    Payment     *payment;

    CountryParser *countryParser;
    
    NSArray     *countries;
    
    BOOL        isFromLogin;
    BOOL        isLastPage;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSString *sessionCookie;
@property (nonatomic, retain) NSArray *ccyPairList;
@property (nonatomic, retain) NSArray *countries;
@property (nonatomic, retain) NSString *limit;
@property (nonatomic, retain) NSString *fee;
@property (nonatomic, retain) NSString *address1;
@property (nonatomic, retain) NSString *address2;
@property (nonatomic, retain) NSString *address3;
@property (nonatomic, retain) NSString *postCode;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) Payment *payment;
@property (nonatomic) BOOL        isFromLogin;
@property (nonatomic) BOOL        isLastPage;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
