//
//  VehicleCell.h
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *vehiclePicture;

@property (strong, nonatomic) IBOutlet UILabel *vehicleInfo;

@property (strong, nonatomic) IBOutlet UILabel *vehicleVIN;



@end
