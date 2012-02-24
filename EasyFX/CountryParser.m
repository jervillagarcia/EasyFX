//
//  CountryParser.m
//  EasyFX
//
//  Created by James Errol Villagarcia on 9/2/11.
//  Copyright 2011 ApplyFinancial. All rights reserved.
//

#import "CountryParser.h"


@implementation CountryParser

@synthesize className;
@synthesize uri;
@synthesize items;
@synthesize item;
@synthesize currentNodeName;
@synthesize currentNodeContent;

- (NSArray *)getItems
{
	return items;
}

- (id)parseXMLData:(NSData *)data fromURI:(NSString*)fromURI toObject:(NSString *)aClassName parseError:(NSError **)error
{
	
	[items release];
	items = [[NSMutableArray alloc] init];
	
	[className release];
	className = [aClassName copy];
	
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
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{

    if([[elementName uppercaseString] isEqualToString:[uri uppercaseString]] || [elementName isEqualToString:@"Fault"]) {
        
        if (item)
            [item release], item = nil;
        item = [[NSClassFromString([[elementName uppercaseString] isEqualToString:[uri uppercaseString]]?className:@"Fault") alloc] init];
                
        [item setValue:[attributeDict objectForKey:@"iso"] forKey:@"iso"];
        [item setValue:[attributeDict objectForKey:@"code"] forKey:@"countryCode"];
        [item setValue:[attributeDict objectForKey:@"ccy"] forKey:@"ccy"];
        
        if (currentNodeName)
            [currentNodeName release], currentNodeName = nil;
        currentNodeName = [elementName copy];
        
        if (currentNodeName)
            [currentNodeContent release], currentNodeContent = nil;
        currentNodeContent = [NSMutableString string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:uri] || [elementName isEqualToString:@"Fault"]) {
        
        [item setValue:currentNodeContent forKey:@"name"];
        
        [currentNodeContent release];
        currentNodeContent = nil;
        [currentNodeName release];
        currentNodeName = nil;
        
        [items addObject:item];
        
    }
    else if([elementName isEqualToString:currentNodeName] && [elementName isEqualToString:@"Header"] == NO && item) {
        if (![elementName isEqualToString:@"NULL"]){
            if ([elementName isEqualToString:@"country"]) {
                [item setValue:currentNodeContent forKey:@"name"];
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{   
    if (currentNodeName)
        [currentNodeContent appendString:[[string copy] autorelease]];
    
}

- (void)dealloc
{
    [currentNodeContent release];
    [currentNodeName release];
	[className release];
//    int cnt = [item retainCount];
//    for (int i = 0; i < cnt -1; i++) {
        [item release];
//    }

	
    [items release];
    [uri release];
	[super dealloc];
}

@end
