//
//  AddCustomerViewController.m
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "AddCustomerViewController.h"

@interface AddCustomerViewController (){
    
}

@property (strong, nonatomic) NSMutableArray *allVehicles;


@end

@implementation AddCustomerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) readForVehicleTable{

    
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"owner = %@",self.customer];
    
    _allVehicles = [CoreDataHelper getObjectsPredicateForEntity:@"Vehicle" withPredicate:predicate andSortKey:@"yearOfMake" andSortAscending:YES andContext:[AppDelegate context]];
    
    [self.carDisplayTable reloadData];
}

-(void) viewWillAppear:(BOOL)animated{
    
    if(_customer)
        [self readForVehicleTable];
    
    NSLog(@"%lu",(unsigned long)_allVehicles.count);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.emailTextField.delegate = self;
    self.policyCoverageTextField.delegate = self;
    self.aaaMemberTextField.delegate = self;
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.policyNoTextField.delegate = self;
    self.phoneNoTextField.delegate = self;
    
    
    //table
    
    self.carDisplayTable.delegate = self;
    self.carDisplayTable.dataSource = self;
    
    self.firstNameTextField.text = _customer.firstName;
    self.lastNameTextField.text = _customer.lastName;
    self.policyNoTextField.text = _customer.policyNo;
    self.phoneNoTextField.text = _customer.phoneNo;
    self.emailTextField.text = _customer.email;
    self.policyCoverageTextField.text = _customer.policyCoverageAmount;
    self.aaaMemberTextField.text = _customer.aaaMember;
    
//    [self readForVehicleTable];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCustomerButton:(id)sender {

    if(!_customer){
      _customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:[AppDelegate context]];
    }
    
    
    [_customer setFirstName:_firstNameTextField.text];
    
    
    [_customer setLastName:_lastNameTextField.text];
    
    
    [_customer setPolicyNo:_policyNoTextField.text];
    
    
    [_customer setPhoneNo:_phoneNoTextField.text];

    
    [_customer setEmail:_emailTextField.text];
    
    
    [_customer setPolicyCoverageAmount:_policyCoverageTextField.text];
    
    
    [_customer setAaaMember:_aaaMemberTextField.text];
    
    [_customer setDateAdded:[NSDate date]];
    
    
    
    NSError *error = nil;

    if (![[AppDelegate context] save:&error])
        NSLog(@"Failed to add new customer with error: %@", [error domain]);
    
    
    [self.view endEditing:YES];
    
//    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void) saveMethod{
    
    if(!_customer){
        _customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:[AppDelegate context]];
    }
    
    
    [_customer setFirstName:_firstNameTextField.text];
    
    
    [_customer setLastName:_lastNameTextField.text];
    
    
    [_customer setPolicyNo:_policyNoTextField.text];
    
    
    [_customer setPhoneNo:_phoneNoTextField.text];
    
    
    [_customer setEmail:_emailTextField.text];
    
    
    [_customer setPolicyCoverageAmount:_policyCoverageTextField.text];
    
    
    [_customer setAaaMember:_aaaMemberTextField.text];
    
    [_customer setDateAdded:[NSDate date]];
    
    
    
    NSError *error = nil;
    
    if (![[AppDelegate context] save:&error])
        NSLog(@"Failed to add new customer with error: %@", [error domain]);
    
    
    //    [self.navigationController popViewControllerAnimated:YES];
    
    [self.view endEditing:YES];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    [self saveMethod];
    
    if([segue.identifier isEqualToString:@"addVehicle"]){

        AddVehicleViewController *avvc = (AddVehicleViewController *)segue.destinationViewController;
        avvc.customer = _customer;
        
    }
    else if([segue.identifier isEqualToString:@"editVehicle"]){
        
        AddVehicleViewController *avvc = (AddVehicleViewController *)segue.destinationViewController;
        avvc.vehicle = [_allVehicles objectAtIndex:self.carDisplayTable.indexPathForSelectedRow.row];
        avvc.customer = _customer;
    }
    
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
    return _allVehicles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    VehicleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...    
    
    cell.vehicleInfo.text = [NSString stringWithFormat:@"%@, %@ (%@)",[[_allVehicles objectAtIndex:indexPath.row] make],[[_allVehicles objectAtIndex:indexPath.row] model],[[_allVehicles objectAtIndex:indexPath.row] yearOfMake]] ;
    
    cell.vehicleVIN.text = [NSString stringWithFormat:@"%@",[[_allVehicles objectAtIndex:indexPath.row] vin]];
    
//

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                UIImage *img = [UIImage imageWithData:[[_allVehicles objectAtIndex:indexPath.row] picture]];
//                dispatch_async(dispatch_get_main_queue(), ^{
                    cell.vehiclePicture.image = img;
//                });
//            });
    
    return cell;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        Vehicle *vehicleToDelete = [_allVehicles objectAtIndex:self.carDisplayTable.indexPathForSelectedRow.row];
        
        [[AppDelegate context] deleteObject:vehicleToDelete];
        
        [_allVehicles removeObjectAtIndex:self.carDisplayTable.indexPathForSelectedRow.row];

        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
//        [self.carDisplayTable reloadData];
        
        NSError *error = nil;
        
        if (![[AppDelegate context] save:&error])
            NSLog(@"Failed cto save with error: %@", [error domain]);

        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
    return NO;
}


- (IBAction)emailTextField:(id)sender {
    
    //I am adding an animation to make this look better
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 -35,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (IBAction)policyCoverageEditingBegin:(id)sender {
    
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 -35,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
    
}

- (IBAction)aaaMemberEditingBegin:(id)sender {
    
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 -35,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (IBAction)lastNameBeginEditing:(id)sender {
    
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}
- (IBAction)firstNameBeginEditing:(id)sender {
    
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[_firstNameTextField resignFirstResponder];
	[_lastNameTextField resignFirstResponder];
	[_policyCoverageTextField resignFirstResponder];
	[_phoneNoTextField resignFirstResponder];
	[_emailTextField resignFirstResponder];
	[_policyNoTextField resignFirstResponder];
	[_aaaMemberTextField resignFirstResponder];
}

@end
