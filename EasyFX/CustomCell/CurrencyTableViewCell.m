//
//  CurrencyTableViewCell.m
//  EasyFX
//
//  Created by Errol Villagarcia on 11/16.
//  Copyright 2011 Apply Financial, Ltd. All rights reserved.
//

#import "CurrencyTableViewCell.h"
#import "TransactionDetailViewController.h"
#import "Utils.h"
#import "WebServiceFactory.h"
#import "EasyFXAppDelegate.h"
#import "Country.h"

@implementation CurrencyTableViewCell

@synthesize curFrom;
@synthesize curTo;
@synthesize imgFrom;
@synthesize imgTo;
@synthesize lblPrice;
@synthesize btnBuy;
@synthesize btnAdd;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)mSelected animated:(BOOL)animated
{
    [super setSelected:mSelected animated:animated];

    // Configure the view for the selected state
}

- (void)willTransitionToState:(UITableViewCellStateMask)state {
    if (state == UITableViewCellStateEditingMask) {
        [btnBuy setHidden:YES];
        [btnAdd setHidden:NO];
        if (currencyPair.isSelected) {
            [btnAdd setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [self setOpaque:YES];
            [self setBackgroundColor:[UIColor darkGrayColor]];
        } else {
            [self setOpaque:NO];
            [self setBackgroundColor:[UIColor clearColor]];
            [btnAdd setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
        }
        
    }else if (state == UITableViewCellStateDefaultMask) {
        [btnBuy setHidden:NO];
        [btnAdd setHidden:YES];
        [self setOpaque:NO];
        [self setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setCurrencyPair:(PriceRec*)priceRec fromController:(UIViewController*)viewController{
    currencyPair = priceRec;
    
	fromController = viewController;

	[curFrom	setText:[currencyPair.pair substringWithRange:NSMakeRange(0,3)]];
    [imgFrom setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) [curFrom.text lowercaseString]]]];
	[curTo		setText:[currencyPair.pair substringWithRange:NSMakeRange(3,3)]];
    [imgTo		setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", (NSString*) [curTo.text lowercaseString]]]];
    
	[lblPrice	setText:[NSString stringWithFormat:@"%.4f",[currencyPair.bid floatValue]]];

}

- (IBAction)btnBuyClick:(id)sender {
    if ([self isEditing]) {
        return;
    }

    [preloadView release];
    preloadView = [[EasyFXPreloader alloc] initWithFrame:[fromController.view frame]];
    [preloadView setMessage:@"Loading..."];
    preloadView.tag = 1;

    [selCountryList release];
    selCountryList = [[NSMutableArray alloc] init];
    
    [filteredBenList release];
    filteredBenList = [[NSMutableArray alloc] init];
    
    [fromController.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(fetchBeneficiaries) toTarget:self withObject:nil];
    
}

- (IBAction)btnAdd:(id)sender {
    if ([self isEditing]) {
        if(currencyPair.isSelected){
            [self setOpaque:NO];
            [self setBackgroundColor:[UIColor clearColor]];
            [btnAdd setImage:[UIImage imageNamed:@"uncheck.png"] forState:UIControlStateNormal];
            [currencyPair setSelected:NO];
        } else {
            [self setOpaque:YES];
            [self setBackgroundColor:[UIColor darkGrayColor]];
            [btnAdd setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
            [currencyPair setSelected:YES];
        }
    }
}

-(void)fetchBeneficiaries {
    @autoreleasepool {
        WebServiceFactory *ws = [[WebServiceFactory alloc] init];
        
        [ws getBeneficiaries];
        
        [tempList release];
        tempList = [[NSArray alloc] initWithArray:ws.wsResponse];
        
        [ws release];
    }
    [preloadView removeFromSuperview];
    
    EasyFXAppDelegate *delegate = (EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *ccy = [curTo text];
    
    [selCountryList release];
    selCountryList = [[NSMutableArray alloc] init];
    for (Country *country in [delegate countries]) {
        if ([country.ccy isEqualToString:ccy]) {
            [selCountryList addObject:country];
        }
    }
    
    [filteredBenList release];
    filteredBenList = [[NSMutableArray alloc] init];
    for(BeneficiaryRec *benRec in tempList){
        for (Country *country in selCountryList) {
            if ([benRec.countryCode isEqualToString:country.countryCode]) {
                [filteredBenList addObject:benRec];
            }
        }
    }
    
    [beneficiaryList release];
    beneficiaryList = [filteredBenList retain];

    if ([beneficiaryList count] > 0) {
        TransactionDetailViewController *viewController = [[TransactionDetailViewController alloc] initWithNibName:@"TransactionDetailViewController" bundle:nil price:currencyPair];
        [fromController.navigationController pushViewController:viewController animated:YES];
        [viewController release];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You do not have a beneficiary in the same currency – please register your beneficiary via your account through the website before trying again." delegate:fromController cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

- (void)dealloc {
    [preloadView release];
    [filteredBenList release];
    [selCountryList release];
    [beneficiaryList release];
    [tempList release];
    [super dealloc];
}

@end
