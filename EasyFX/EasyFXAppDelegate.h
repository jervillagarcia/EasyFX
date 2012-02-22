//
//  EasyFXAppDelegate.h
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Payment.h"

@interface EasyFXAppDelegate : NSObject <UIApplicationDelegate> {
    NSString    *sessionCookie;
    NSArray     *ccyPairList;
    NSString    *limit;
    Payment     *payment;
    
    BOOL        isFromLogin;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) NSString *sessionCookie;
@property (nonatomic, retain) NSArray *ccyPairList;
@property (nonatomic, retain) NSString *limit;
@property (nonatomic, retain) Payment *payment;
@property (nonatomic) BOOL        isFromLogin;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
