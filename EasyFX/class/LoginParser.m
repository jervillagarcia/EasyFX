//
//  LoginParser.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "LoginParser.h"
#import "LogInResult.h"
@implementation LoginParser

@synthesize className;
@synthesize uri;
@synthesize items;
@synthesize item;
@synthesize currentNodeName;
@synthesize currentNodeContent;
@synthesize arr;

- (NSArray *)getItems
{
	return items;
}

/*
 - (id)parseXMLData:(NSData *)data toObject:(NSString *)aClassName parseError:(NSError **)error
 {
 [items release];
 items = [[NSMutableArray alloc] init];
 
 [className release];
 className = [aClassName copy];//[[NSString alloc] initWithString:aClassName];
 
 NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
 [parser setDelegate:self];
 [parser setShouldProcessNamespaces:YES];
 [parser setShouldReportNamespacePrefixes:YES];
 [parser setShouldResolveExternalEntities:YES];
 
 [parser parse];
 [parser release];
 
 return self;
 }
 */

- (id)parseXMLData:(NSData *)data fromURI:(NSString*)fromURI toObject:(NSString *)aClassName parseError:(NSError **)error
{
	
	[items release];
	items = [[NSMutableArray alloc] init];

	[arr release];
	arr = [[NSMutableArray alloc] init];
	
	[className release];
	className = [aClassName copy];//[[NSString alloc] initWithString:aClassName];
	
	[uri release];
	uri = [fromURI copy];
	
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:YES];
	[parser setShouldReportNamespacePrefixes:YES];
	[parser setShouldResolveExternalEntities:YES];
	
	[parser parse];
	[parser release];
	/*
	 if([parser parserError] &&error) {
	 *error = [parser parserError];
	 }
	 */
//	return [self retain];
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqualToString:uri] || [elementName isEqualToString:@"Fault"]) {
        [item release];
		item = [[NSClassFromString([elementName isEqualToString:uri]?className:@"Fault") alloc] init];
        isCCYPair = NO;
	}else if ([elementName isEqualToString:@"CCYPairs"]) {
        //SKIP
        isCCYPair = YES;
//        [(LogInResult*)item ccyPairs] = [[NSMutableArray alloc] init];
//        currentNodeContent = [[NSMutableString alloc] init];
    }else {
		if (![elementName isEqualToString:@"NULL"]){
            [currentNodeContent release];
            [currentNodeName release];
			currentNodeName = [elementName copy];
			currentNodeContent = [[NSMutableString alloc] init];
		}
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"CCYPairs"]) {
        //SKIP
        isCCYPair = NO;
        [(LogInResult*)item setCCYPairs:arr];
    }
    
    if (isCCYPair) {
        [arr addObject:currentNodeContent];

        [currentNodeContent release];
        currentNodeContent = nil;
    }else {
        if([elementName isEqualToString:uri] || [elementName isEqualToString:@"Fault"]) {
            
            [items addObject:item];
            [item release];
            item = nil;
        }else if([elementName isEqualToString:currentNodeName] && [elementName isEqualToString:@"Header"] == NO) {
            
            if (![elementName isEqualToString:@"NULL"]){
                [item setValue:currentNodeContent forKey:elementName];
                
                [currentNodeContent release];
                currentNodeContent = nil;
                
                [currentNodeName release];
                currentNodeName = nil;
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{   
	[currentNodeContent appendString:string];
}

- (void)dealloc
{
	[className release];
	[item release];
	[currentNodeName release];
	[currentNodeContent release];
	[items release];
    [arr release];
    [uri release];
	[super dealloc];
}

@end
