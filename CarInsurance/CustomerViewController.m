//
//  CustomerViewController.m
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@property (nonatomic, strong) NSMutableArray *allCustomers;


@end

@implementation CustomerViewController


-(void) readDataForCustomerTable{
    
    _allCustomers = [CoreDataHelper getObjectsForEntity:@"Customer" withSortKey:@"dateAdded" andSortAscending:YES andContext:[AppDelegate context]];
    
    [self.tableView reloadData];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self readDataForCustomerTable];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateTitle) userInfo:nil repeats:YES];
    
    self.title = [NSString stringWithFormat:@"Insurance Customer - %lu",(unsigned long)[_allCustomers count]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) updateTitle{
    
    self.title = [NSString stringWithFormat:@"Insurance Customer - %lu",(unsigned long)[_allCustomers count]];

}


-(void) viewWillAppear:(BOOL)animated{
    
     [self readDataForCustomerTable];

    self.title = [NSString stringWithFormat:@"Insurance Customer - %lu",(unsigned long)[_allCustomers count]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return _allCustomers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[[_allCustomers objectAtIndex:indexPath.row] firstName],[[_allCustomers objectAtIndex:indexPath.row] lastName]];
    
    cell.detailTextLabel.text = [[_allCustomers objectAtIndex:indexPath.row] policyNo];
    
    
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"editCustomer"]){
        
        AddCustomerViewController *acvc = (AddCustomerViewController *)segue.destinationViewController;
        
        acvc.customer = [_allCustomers objectAtIndex:self.tableView.indexPathForSelectedRow.row];

    }
    else if([segue.identifier isEqualToString:@"addCustomer"]){
        
        
    }
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Customer *customerToDelete = [_allCustomers objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
        [[AppDelegate context] deleteObject:customerToDelete];
        
        [_allCustomers removeObjectAtIndex:self.tableView.indexPathForSelectedRow.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        self.title = [NSString stringWithFormat:@"Insurance Customer - %lu",(unsigned long)[_allCustomers count]];
        
        //[self.tableView reloadData];
        
        NSError *error = nil;
        
        if (![[AppDelegate context] save:&error])
            NSLog(@"Failed cto save with error: %@", [error domain]);
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
