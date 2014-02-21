//
//  AddCustomerViewController.m
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "AddCustomerViewController.h"

@interface AddCustomerViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCustomerButton:(id)sender {

    Customer *customer = [NSEntityDescription insertNewObjectForEntityForName:@"Customer" inManagedObjectContext:[AppDelegate context]];
    
    
    
    [customer setFirstName:_firstNameTextField.text];
    
    
    [customer setLastName:_lastNameTextField.text];
    
    
    [customer setPolicyNo:_policyNoTextField.text];
    
    
    [customer setPhoneNo:_phoneNoTextField.text];

    
    [customer setEmail:_emailTextField.text];
    
    
    [customer setPolicyCoverageAmount:_policyCoverageTextField.text];
    
    
    [customer setAaaMember:_aaaMemberTextField.text];
    
    
}

@end
