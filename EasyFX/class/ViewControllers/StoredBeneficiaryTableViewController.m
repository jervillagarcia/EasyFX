//
//  StoreBeneficiaryTableViewController.m
//  EasyFX
//
//  Created by Errol on 2/7/12.
//  Copyright (c) 2012 Apply Financial Ltd. All rights reserved.
//

#import "StoredBeneficiaryTableViewController.h"
#import "WebServiceFactory.h"
#import "BeneficiaryRec.h"
#import "StoredBeneficiaryTableViewCell.h"
#import "ExistingBeneficiaryViewController.h"
#import "Utils.h"
#import "CountryParser.h"
#import "Country.h"
#import "EasyFXAppDelegate.h"
#import "Payment.h"

@implementation StoredBeneficiaryTableViewController

@synthesize table;
@synthesize beneficiaryList;
@synthesize countryList;
@synthesize testList;
@synthesize filePath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        [preloadView release];
        preloadView = [[EasyFXPreloader alloc] initWithFrame:[self.view frame]];
        [preloadView setMessage:@"Loading..."];
        preloadView.tag = 1;

        NSError *parseErr;
        @autoreleasepool {
            CountryParser *parser = [[CountryParser alloc] init];
            [parser parseXMLData:[[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"xml"]] fromURI:@"country" toObject:@"Country" parseError:&parseErr];
            
//            [testList release];
//            testList = [[[NSMutableArray alloc] initWithArray:[parser items]] autorelease];
            [countryList release];
            countryList = [[NSMutableArray alloc] initWithArray:[[parser items] copy]];
            [parser release];
        }
        
        [selCountryList release];
        selCountryList = [[NSMutableArray alloc] init];
        
        [filteredBenList release];
        filteredBenList = [[NSMutableArray alloc] init];
        

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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
    [countryList release];
    [tempList release];
    [selCountryList release];
    [filteredBenList release];
    [beneficiaryList release];
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
    return [beneficiaryList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 73.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoredBeneficiaryCell";
    NSString *nibName = @"StoredBeneficiaryTableViewCell";
    
    StoredBeneficiaryTableViewCell *cell = (StoredBeneficiaryTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[StoredBeneficiaryTableViewCell class]])
            {
                cell = (StoredBeneficiaryTableViewCell *)currentObject;
                break;
            }
        }
    }
    [cell setBeneficiary:(BeneficiaryRec *)[beneficiaryList objectAtIndex:indexPath.row]];
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
    ExistingBeneficiaryViewController *detailViewController = [[ExistingBeneficiaryViewController alloc] initWithNibName:@"ExistingBeneficiaryViewController" bundle:nil beneficiaryRec:(BeneficiaryRec *)[beneficiaryList objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
}

-(void)loadData {
    [self.view addSubview:preloadView];
    [NSThread detachNewThreadSelector:@selector(fetchBeneficiaries) toTarget:self withObject:nil];
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
    NSString *ccy = delegate.payment.buyCCY;
    
    [selCountryList release];
    selCountryList = [[NSMutableArray alloc] init];
    for (Country *country in countryList) {
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
        //do nothing
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You do not have a beneficiary in the same currency – please register your beneficiary via your account through the website before trying again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    [table reloadData];
}

#pragma mark Actions (Button)

- (IBAction) editAction:(id)sender {
    [table setEditing:YES animated:YES];
    
}

@end
