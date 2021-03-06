//
//  CountryLookupViewController.h
//  EasyFX
//
//  Created by James Errol Villagarcia on 9/3/11.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CountryLookupViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UISearchBarDelegate> {
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITableView *countryTable;

    NSArray *list;
    NSMutableArray *filteredList;
    NSArray *tempList;
    
    BOOL isSearching;
    
    id aDelegate;
}

@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *countryTable;
@property (nonatomic, retain) NSArray *list;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)mDelegate;

@end
