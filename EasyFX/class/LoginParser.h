//
//  LoginParser.h
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "XmlParser.h"

@interface LoginParser : NSObject<NSXMLParserDelegate> {

    NSString *className;
    NSString *uri;
    NSMutableArray *items;
    NSObject *item;
    NSString *currentNodeName;
    NSMutableString *currentNodeContent;
    NSMutableArray *arr;
    BOOL isCCYPair;
}

@property (retain) NSString *className;
@property (retain) NSString *uri;
@property (retain) NSMutableArray *items;
@property (retain) NSObject *item;
@property (retain) NSString *currentNodeName;
@property (retain) NSMutableString *currentNodeContent;
@property (retain) NSMutableArray *arr;

- (NSArray *)getItems;
//- (id)parseXMLData:(NSData *)data toObject:(NSString *)aClassName parseError:(NSError **)error;
- (id)parseXMLData:(NSData *)data fromURI:(NSString*)fromURI toObject:(NSString *)aClassName parseError:(NSError **)error;

@end
