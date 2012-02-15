//
//  CardListViewController.h
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EasyFXPreloader.h"

@interface CardListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    NSArray *cardsList;
    
    EasyFXPreloader *preloadView;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *cardsList;

-(void)loadData;
-(void)fetchCards;

@end
