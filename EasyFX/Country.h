//
//  Country.h
//  EasyFX
//
//  Created by James Errol Villagarcia on 9/2/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Country : NSObject {
    NSString *name;
    NSString *iso;
    NSString *countryCode;
    NSString *ccy;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *iso;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *ccy;

@end
