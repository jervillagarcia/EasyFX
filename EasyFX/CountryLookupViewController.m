//
//  CountryLookupViewController.m
//  Swift
//
//  Created by James Errol Villagarcia on 9/3/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "CountryLookupViewController.h"
#import "EasyFXAppDelegate.h"
#import "CountryParser.h"
#import "Country.h"
#import "EasyFXCountryCell.h"
#import "AddCardViewController.h"

@implementation CountryLookupViewController

@synthesize countryList;
@synthesize countryTable;
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)mDelegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        filePath = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"xml"];
        myData = [NSData dataWithContentsOfFile:filePath];

        NSError *parseErr;
        CountryParser *parser = [[CountryParser alloc] init];
        [parser parseXMLData:myData fromURI:@"country" toObject:@"Country" parseError:&parseErr];
        
        [countryList release];
        countryList = [[NSMutableArray alloc] initWithArray:[parser items]];
        
        aDelegate = mDelegate;
        
        isSearching = NO;
    }
    return self;
}

- (void)dealloc
{
//    [filePath release];
//    [myData release];
    [filteredList release];
    [countryList release]; 
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    filteredList = [[NSMutableArray alloc] init];
    tempList = [[NSMutableArray alloc] init];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma TableView Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    [tempList release];
    tempList = isSearching ? [filteredList retain] : [(NSMutableArray*) countryList retain];
    
    return [tempList count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tempList release];
    tempList = isSearching ? [filteredList retain] : [(NSMutableArray*) countryList retain];

    static NSString *cellIdentifier = @"cell";
    
    EasyFXCountryCell *cell = (EasyFXCountryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[EasyFXCountryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier country:(Country*)[tempList objectAtIndex:[indexPath row]]];
    } else {
        [(EasyFXCountryCell*)cell setMCountry:(Country*)[tempList objectAtIndex:[indexPath row]]];
    }
     
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isSearching) {
        [searchBar resignFirstResponder];
        isSearching = NO;
    }
    
//    [(AddCardViewController*)[[self.navigationController viewControllers] objectAtIndex:[self.navigationController.viewControllers count] - 1] setCountry:[(EasyFXCountryCell*)[tableView cellForRowAtIndexPath:indexPath] country]];
    
    
    [(AddCardViewController*)aDelegate setCountry:[(EasyFXCountryCell*)[tableView cellForRowAtIndexPath:indexPath] country]];
    [self dismissModalViewControllerAnimated:YES];
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        isSearching = NO;
    } else {
        isSearching = YES;
    }
    if (isSearching) {
        [filteredList removeAllObjects];
        isSearching = YES;
        for (Country *model in countryList)
        {
            NSRange titleResultsRange = [[NSString stringWithFormat:@"%@ %@", [model countryCode], [model name]] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResultsRange.length > 0)
                [filteredList addObject:model];
        }
        
    }
    [countryTable reloadData];
}

@end
