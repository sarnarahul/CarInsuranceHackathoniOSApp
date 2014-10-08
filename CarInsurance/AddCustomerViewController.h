//
//  AddCustomerViewController.h
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Customer.h"
#import "Vehicle.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"
#import "AddVehicleViewController.h"
#import "VehicleCell.h"

@interface AddCustomerViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *policyNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *policyCoverageTextField;
@property (strong, nonatomic) IBOutlet UITextField *aaaMemberTextField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITableView *carDisplayTable;

@property (strong, nonatomic) Customer *customer;


@end
