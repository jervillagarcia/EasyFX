//
//  TransactionCompleteViewController.h
//  EasyFX
//
//  Created by Errol on 2/15/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransactionCompleteViewController : UIViewController {
    IBOutlet UILabel *lblDealNo;
    NSString *dealNo;
}

@property(nonatomic, retain) UILabel *lblDealNo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dealNo:(NSString*)mDealNo;

@end
