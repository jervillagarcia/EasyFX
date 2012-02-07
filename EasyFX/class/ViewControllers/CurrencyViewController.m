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

@implementation CurrencyViewController

@synthesize table;
@synthesize currencyList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    return [currencyList count];
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
    [cell setCurrencyPair:(PriceRec *)[currencyList objectAtIndex:indexPath.row] fromController:self];
    return cell;		
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}


-(void)fetchCurrencies {
//    [NSThread detachNewThreadSelector:@selector(showActivity) toTarget:self withObject:nil];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws getDealCurrencies];
    
    [currencyList release];
    currencyList = [[[NSArray alloc] initWithArray:ws.wsResponse] retain];
	
//    if([ws.wsResponse count] > 0) { 
//        if (([ws.wsResponse count] == 1) && [[ws.wsResponse objectAtIndex:0] isKindOfClass:[Fault class]]) {
//            [ws release];
//            [pool release];
//            
//            [processActivity dismissWithClickedButtonIndex:0 animated:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:[(Fault*)[ws.wsResponse objectAtIndex:0] faultstring] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//        } else if (([ws.wsResponse count] == 1) && [[ws.wsResponse objectAtIndex:0] isKindOfClass:[Error class]]) {
//            [ws release];
//            [pool release];
//            
//            [processActivity dismissWithClickedButtonIndex:0 animated:YES];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[(Error*)[ws.wsResponse objectAtIndex:0] CODE] message:[(Error*)[ws.wsResponse objectAtIndex:0] DESCRIPTION] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert show];
//            [alert release];
//        } else {
//            [arr release];
//            arr = [ws.wsResponse retain];
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Validated OK." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Details", nil];
//            [alert show];
//            [alert release];
//            
//            [ws release];
//            [pool release];
//            
//            [processActivity dismissWithClickedButtonIndex:0 animated:YES];
//        }
//    } else {
//        
//        [ws release];
//        [pool release];
//        
//        [processActivity dismissWithClickedButtonIndex:0 animated:YES];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No results found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
//        
//    }

    [ws release];
    [pool release];

}

#pragma mark Actions (Button)
- (IBAction) backAction:(id)sender {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws logOut];

    [ws release];
    [pool release];
    
    [self.navigationController popViewControllerAnimated:YES];


}

- (IBAction) editAction:(id)sender {
    [table setEditing:YES animated:YES];
    
}

@end
