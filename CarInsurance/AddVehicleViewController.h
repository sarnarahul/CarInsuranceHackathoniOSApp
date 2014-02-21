//
//  AddVehicleViewController.h
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Customer.h"
#import "Vehicle.h"
#import "CoreDataHelper.h"
#import <AssetsLibrary/ALAssetsLibrary.h>
#import "MobileCoreServices/MobileCoreServices.h"



@interface AddVehicleViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (strong, nonatomic) IBOutlet UITextField *vinTextField;
@property (strong, nonatomic) IBOutlet UITextField *makeTextField;
@property (strong, nonatomic) IBOutlet UITextField *modelTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeTextField;
@property (strong, nonatomic) IBOutlet UITextField *yearOfMakeTextField;

@property (strong, nonatomic) Customer *customer;




@end
