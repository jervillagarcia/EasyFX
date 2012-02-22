//
//  CardListViewController.m
//  EasyFX
//
//  Created by Errol on 2/9/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "CardListViewController.h"
#import "Utils.h"
#import "WebServiceFactory.h"
#import "CardRec.h"
#import "CardDetailViewController.h"
#import "AddCardViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation CardListViewController

@synthesize table;
@synthesize cardsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [preloadView release];
        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
        [preloadView setMessage:@"Loading..."];
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
    [self loadData];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [cardsList release];
    [preloadView release];
    [super dealloc];
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
    CardDetailViewController *detailViewController = [[CardDetailViewController alloc] initWithNibName:@"CardDetailViewController" bundle:nil cardRec:(CardRec *)[cardsList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

-(void)loadData {
    [self.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(fetchCards) toTarget:self withObject:nil];
}

-(void)fetchCards {
    @autoreleasepool {
        WebServiceFactory *ws = [[WebServiceFactory alloc] init];
        
        [ws getCardsList];
        
        [cardsList release];
        cardsList = [[[NSArray alloc] initWithArray:ws.wsResponse] retain];
	    
        [table reloadData];
        [preloadView removeFromSuperview];
        
        [ws release];
    }
}

#pragma mark Actions (Button)

- (IBAction) editAction:(id)sender {
    [table setEditing:YES animated:YES];
}

- (IBAction)addCardAction:(id)sender {
	CATransition *animation = [CATransition animation];
	animation.type = kCATransitionFromBottom;
	animation.duration = 0.5;  //Or whatever
//	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //Or whatever
//	animation.startProgress = 0;  //Set this as needed
//	animation.endProgress = 0.66;  //Set this as needed
	animation.fillMode = kCAFillModeBoth;
	[[self.navigationController.view layer] addAnimation:animation forKey:kCATransition];

    
    AddCardViewController *viewController = [[AddCardViewController alloc] initWithNibName:@"AddViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:NO];
    [viewController release];
}

@end
