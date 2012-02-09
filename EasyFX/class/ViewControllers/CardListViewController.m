//
//  CardListViewController.m
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CardListViewController.h"
#import "Utils.h"
#import "WebServiceFactory.h"
#import "CardRec.h"

@implementation CardListViewController

@synthesize table;
@synthesize cardsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(fetchCards)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [Utils setNavTitleImage:self];
    
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
    return [cardsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cardCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    [cell setOpaque:NO];
    [cell.textLabel setTextColor:[UIColor colorWithRed:20.0 green:108.0 blue:156.0 alpha:1]];
    [cell.textLabel setText:[(CardRec*)[cardsList objectAtIndex:indexPath.row] name]];
    [cell.detailTextLabel setText:[(CardRec*)[cardsList objectAtIndex:indexPath.row] cardNumber]];
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
/*
    ExistingBeneficiaryViewController *detailViewController = [[ExistingBeneficiaryViewController alloc] initWithNibName:@"ExistingBeneficiaryViewController" bundle:nil beneficiaryRec:(BeneficiaryRec *)[beneficiaryList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
 */
}


-(void)fetchCards {
    //    [NSThread detachNewThreadSelector:@selector(showActivity) toTarget:self withObject:nil];
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    WebServiceFactory *ws = [[WebServiceFactory alloc] init];
    
    [ws getCardsList];
    
    [cardsList release];
    cardsList = [[[NSArray alloc] initWithArray:ws.wsResponse] retain];
	
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

- (IBAction) editAction:(id)sender {
    [table setEditing:YES animated:YES];
    
}

@end
