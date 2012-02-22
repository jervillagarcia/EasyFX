//
//  CurrencyPair.h
//  EasyFX
//
//  Created by Errol on 11/16/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CurrencyPair : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * row;
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * currencyFrom;
@property (nonatomic, retain) NSString * currencyTo;

@end
