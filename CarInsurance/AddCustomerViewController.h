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

@interface AddCustomerViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *policyNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *policyCoverageTextField;
@property (strong, nonatomic) IBOutlet UITextField *aaaMemberTextField;




@end
