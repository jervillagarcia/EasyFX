//
//  CurrencyViewController.m
//  EasyFX
//
//  Created by Errol on 2/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CurrencyViewController.h"
#import "WebServiceFactory.h"
#import "CurrencyTableViewCell.h"
#import "TransactionDetailViewController.h"
#import "EasyFXAppDelegate.h"

@implementation CurrencyViewController

@synthesize table;
@synthesize currencyList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        filteredList = [[NSMutableArray alloc] init];
        [preloadView release];
        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
        [preloadView setMessage:@"Logging out"];
        preloadView.tag = 1;
    }
    return self;
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

    [self performSelector:@selector(fetchCurrencies)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];

    UIImage  *buttonImage = [UIImage imageNamed:@"back_button.png"];
    UIImage  *editImage = [UIImage imageNamed:@"edit_currency_icon.png"];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:buttonImage forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:editImage forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];    

    //Logout Button
    UIBarButtonItem *backItem1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    [self.navigationController.navigationBar.topItem     setLeftBarButtonItem:backItem1];

    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    [self.navigationController.navigationBar.topItem     setRightBarButtonItem:backItem2];
    
    self.navigationController.navigationBar.topItem.titleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_logo.png"]] autorelease];

}

- (void)dealloc {
    [currencyList release];
    [filteredList release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([tableView isEditing])
        return [currencyList count];
    else
        return [filteredList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CurrencyCell";
    NSString *nibName = @"CurrencyTableViewCell";
    
    CurrencyTableViewCell *cell = (CurrencyTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSLog(@"New Cell Made");
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[CurrencyTableViewCell class]])
            {
                cell = (CurrencyTableViewCell *)currentObject;
                break;
            }
        }
    }
    if([tableView isEditing])
        [cell setCurrencyPair:(PriceRec *)[currencyList objectAtIndex:indexPath.row] fromController:self];
    else
        [cell setCurrencyPair:(PriceRec *)[filteredList objectAtIndex:indexPath.row] fromController:self];
    return cell;		
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



-(void)fetchCurrencies {
//    [NSThread detachNewThreadSelector:@selector(showActivity) toTarget:self withObject:nil];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws getDealCurrencies];
    
    [currencyList release];
    currencyList = [[[NSArray alloc] initWithArray:ws.wsResponse] retain];
    
    [filteredList release];
    filteredList = [[NSMutableArray alloc] init];
    for (PriceRec *price in currencyList) {
        [price setSelected:[[(EasyFXAppDelegate*)[[UIApplication sharedApplication] delegate] ccyPairList] containsObject:price.pair]];
        if ([price isSelected]) {
            [filteredList addObject:price];
        }
    }
    
    [ws release];
    [pool release];

}

-(void)filterSelectedCurrency {
    [filteredList release];
    filteredList = [[NSMutableArray alloc] init];
    for (PriceRec *priceRec in currencyList) {
        if ([priceRec isSelected]) [filteredList addObject:priceRec];
    }
    
}

-(void)updateCurrencyList{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (PriceRec *mPrice in filteredList) {
        [arr addObject:mPrice.pair];
    }
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws setCCYList:arr];
        
    [ws release];
    [pool release];
}

#pragma mark Actions (Button)
- (IBAction) backAction:(id)sender {
    [self.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(logoutAction) toTarget:self withObject:nil];

}

-(void)logoutAction {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws logOut];
    
    [ws release];
    [pool release];
    [preloadView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction) editAction:(id)sender {
    if (table.isEditing) {
        [table setEditing:NO animated:YES];
        [NSThread detachNewThreadSelector:@selector(updateCurrencyList) toTarget:self withObject:nil];
    } else
        [table setEditing:YES animated:YES];
    [self filterSelectedCurrency];
    [table reloadData];
}

@end
