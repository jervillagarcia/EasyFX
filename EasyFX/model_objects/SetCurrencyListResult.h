//
//  SetCurrencyListResult.h
//  EasyFX
//
//  Created by Errol on 2/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SetCurrencyListResult : NSObject {
    
    NSString    *success;
    NSString    *errorID;
    NSString    *errorMsg;
    
}

@property(nonatomic, retain) NSString    *success;
@property(nonatomic, retain) NSString    *errorID;
@property(nonatomic, retain) NSString    *errorMsg;

@end
