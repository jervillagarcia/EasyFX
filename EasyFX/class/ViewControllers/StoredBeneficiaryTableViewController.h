//
//  StoreBeneficiaryTableViewController.h
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoredBeneficiaryTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    NSArray *beneficiaryList;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *beneficiaryList;


-(void)fetchBeneficiaries;

@end
