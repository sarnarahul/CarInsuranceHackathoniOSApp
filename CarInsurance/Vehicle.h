//
//  Vehicle.h
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Customer;

@interface Vehicle : NSManagedObject

@property (nonatomic, retain) NSString * vin;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * yearOfMake;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) Customer *owner;

@end
