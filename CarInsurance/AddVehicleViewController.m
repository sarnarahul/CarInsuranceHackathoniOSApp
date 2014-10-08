//
//  AddVehicleViewController.m
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import "AddVehicleViewController.h"

@interface AddVehicleViewController ()

@property (strong, nonatomic) UIImage *vehicleImage;

@end

@implementation AddVehicleViewController

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
    
    _vehicleImageView.image = [UIImage imageNamed:@"defaultAddImage.png"];
    
    _vehicleImageView.contentMode = UIViewContentModeScaleToFill;
    
//     self.clipsToBounds = YES;
    
    [_vehicleImageView setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    
    [singleTap setNumberOfTapsRequired:1];
    
    [_vehicleImageView addGestureRecognizer:singleTap];        
    
    self.vinTextField.delegate = self;
    self.makeTextField.delegate = self;
    self.modelTextField.delegate = self;
    self.typeTextField.delegate = self;
    self.yearOfMakeTextField.delegate = self;
    
    
    self.vinTextField.text = _vehicle.vin;
    self.makeTextField.text = _vehicle.make;
    self.modelTextField.text = _vehicle.model;
    self.typeTextField.text = _vehicle.type;
    self.yearOfMakeTextField.text = _vehicle.yearOfMake;
    
    if([UIImage imageWithData:_vehicle.picture] != nil)
        self.vehicleImageView.image = [UIImage imageWithData:_vehicle.picture];
    
}

-(void) singleTap: (UIGestureRecognizer *)recognizer{

    NSLog(@"Single Image Click");
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image from..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Image Gallary", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.alpha=1;
	actionSheet.tag = 1;
	[actionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	switch (actionSheet.tag)
	{
		case 1:
			switch (buttonIndex)
		{
			case 0:
			{
                
                // Took this code from an online source
#if TARGET_IPHONE_SIMULATOR
				
				UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Camera not available." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				
#elif TARGET_OS_IPHONE
				
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = UIImagePickerControllerSourceTypeCamera;
				picker.delegate = self;
                picker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
                picker.allowsEditing = NO;
                
				[self presentViewController:picker animated:YES completion:NULL];
                
#endif
			}
				break;
			case 1:
			{
				UIImagePickerController *picker = [[UIImagePickerController alloc] init];
				picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
				picker.delegate = self;
				[self presentViewController:picker animated:YES completion:NULL];
                
			}
				break;
		}
			break;
			
		default:
			break;
	}
}

- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError
                       contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        
        NSLog(@"Error = %@", paramError); }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        _vehicleImageView.image = image;
        _vehicleImage = image;
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)saveVehicleButton:(id)sender {
    
    if(!_vehicle){
     _vehicle = [NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:[AppDelegate context]];
    }
    
    [_vehicle setVin:_vinTextField.text];
    
    [_vehicle setMake:_makeTextField.text];
    
    [_vehicle setModel:_modelTextField.text];
    
    [_vehicle setType:_typeTextField.text];
    
    [_vehicle setYearOfMake:[_yearOfMakeTextField text]];
    
    NSData *imageData = UIImagePNGRepresentation(_vehicleImage);
    
    if(imageData!=nil)
    [_vehicle setPicture:imageData];
    
    _vehicle.owner = _customer;
    
    
    NSError *error = nil;
    
    if (![[AppDelegate context] save:&error])
        NSLog(@"Failed to add new vehicle with error: %@", [error domain]);

    
    [self.navigationController popViewControllerAnimated:YES];

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


- (IBAction)anyTextField:(id)sender {
    
    //I am adding an animation to make this look better
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 -65,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [UIView commitAnimations];
    
}



@end
