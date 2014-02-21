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
    
//    _vehicleImageView.contentMode = UIViewContentModeScaleAspectFill;
    
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
}

- (IBAction)saveVehicleButton:(id)sender {
    
    Vehicle *vehicle = [NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:[AppDelegate context]];
    
    [vehicle setVin:_vinTextField.text];
    
    [vehicle setMake:_makeTextField.text];
    
    [vehicle setModel:_modelTextField.text];
    
    [vehicle setType:_typeTextField.text];
    
    [vehicle setYearOfMake:[_yearOfMakeTextField text]];
    
    NSData *imageData = UIImagePNGRepresentation(_vehicleImage);
    
    [vehicle setPicture:imageData];
    
    vehicle.owner = _customer;
    
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
