//
//  CountryLookupViewController.m
//  EasyFX
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

@synthesize list;
@synthesize countryTable;
@synthesize searchBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)mDelegate
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        aDelegate = mDelegate;        
        
        isSearching = NO;
    }
    return self;
}

- (void)dealloc
{
    [filteredList release];
    [tempList release];
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
    tempList = [[NSArray  alloc] init];

    EasyFXAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
//    [list release];
//    list = nil;
    list = [[NSArray alloc] initWithArray:[delegate countries]];
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
    tempList = isSearching ? [filteredList retain] : [list retain];
    
    return [tempList count];
}

- (UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [tempList release];
    tempList = isSearching ? [filteredList retain] : [list retain];
    
    static NSString *cellIdentifier = @"cell";
    
    EasyFXCountryCell *cell = (EasyFXCountryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[EasyFXCountryCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }   
    
    [(EasyFXCountryCell*)cell setMCountry:(Country*)[tempList objectAtIndex:[indexPath row]]];
     
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
    
    [(AddCardViewController*)aDelegate setCountry:[(EasyFXCountryCell*)[tableView cellForRowAtIndexPath:indexPath] getCountry]];
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
        for (Country *model in list)
        {
            NSRange titleResultsRange = [[NSString stringWithFormat:@"%@ %@", [model countryCode], [model name]] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleResultsRange.length > 0)
                [filteredList addObject:model];
        }
        
    }
    [countryTable reloadData];
}

@end
