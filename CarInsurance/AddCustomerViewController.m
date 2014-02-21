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

@property (strong, nonatomic) Customer *customer;

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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"owner = %@",_customer];
    
//    _allVehicles = [CoreDataHelper getObjectsPredicateForEntity:@"Customer" withPredicate:predicate andSortKey:@"yearOfMake" andSortAscending:YES andContext:[AppDelegate context]];
}

-(void) viewWillAppear:(BOOL)animated{
    
    [self readForVehicleTable];
    
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
    
    [self readForVehicleTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCustomerButton:(id)sender {

    if(!_customer){
     _customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:[AppDelegate context]];
    
    
    
    [_customer setFirstName:_firstNameTextField.text];
    
    
    [_customer setLastName:_lastNameTextField.text];
    
    
    [_customer setPolicyNo:_policyNoTextField.text];
    
    
    [_customer setPhoneNo:_phoneNoTextField.text];

    
    [_customer setEmail:_emailTextField.text];
    
    
    [_customer setPolicyCoverageAmount:_policyCoverageTextField.text];
    
    
    [_customer setAaaMember:_aaaMemberTextField.text];
    
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    NSError *error = nil;
    
    if (![[AppDelegate context] save:&error])
        NSLog(@"Failed to add new customer with error: %@", [error domain]);
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"addVehicle"]){
        
        AddVehicleViewController *avvc = (AddVehicleViewController *)segue.destinationViewController;
        
        avvc.customer = _customer;
        
        
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


@end
