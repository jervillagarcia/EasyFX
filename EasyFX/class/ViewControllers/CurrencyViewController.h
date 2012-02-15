//
//  CurrencyViewController.h
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"

@interface CurrencyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    NSArray *currencyList;
    NSMutableArray *filteredList;
    EasyFXPreloader             *preloadView;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *currencyList;


-(void)fetchCurrencies;
-(void)logoutAction;

-(IBAction) backAction:(id)sender;

@end
