//
//  Fault.h
//  EasyFX
//
//  Created by Errol on 2/22/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fault : NSObject {
    NSString *faultcode;
    NSString *faultstring;
    NSString *detail;
}

@property(nonatomic, retain) NSString *faultcode;
@property(nonatomic, retain) NSString *faultstring;
@property(nonatomic, retain) NSString *detail;

@end
