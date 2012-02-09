//
//  CardListViewController.h
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *table;
    NSArray *cardsList;
}

@property (nonatomic, retain) UITableView *table;
@property (nonatomic, retain) NSArray *cardsList;


-(void)fetchCards;

@end
