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
    
    EasyFXPreloader *preloadView;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *beneficiaryList;

-(void)loadData;
-(void)fetchBeneficiaries;

@end
