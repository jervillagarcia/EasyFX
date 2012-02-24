//
//  StoreBeneficiaryTableViewController.h
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"

@interface StoredBeneficiaryTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    NSArray *beneficiaryList;
    NSMutableArray *filteredBenList;
    
    EasyFXPreloader *preloadView;
    NSArray *countryList;
    NSArray *testList;
    NSMutableArray *selCountryList;
    NSArray *tempList;
    
    BOOL isSearching;
    
    NSData *myData;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *beneficiaryList;
@property (nonatomic, retain) NSArray *countryList;
@property (nonatomic, retain) NSArray *testList;
@property (nonatomic, retain) NSString *filePath;
@property (nonatomic, retain) NSData *myData;

-(void)loadData;
-(void)fetchBeneficiaries;

@end
