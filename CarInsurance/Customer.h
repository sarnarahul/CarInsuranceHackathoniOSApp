//
//  Customer.h
//  CarInsurance
//
//  Created by Rahul Sarna on 21/02/14.
//  Copyright (c) 2014 Rahul Sarna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Vehicle;

@interface Customer : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * policyNo;
@property (nonatomic, retain) NSString * phoneNo;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * policyCoverageAmount;
@property (nonatomic, retain) NSString * aaaMember;
@property (nonatomic, retain) NSDate * dateAdded;
@property (nonatomic, retain) NSSet *carsOwn;
@end

@interface Customer (CoreDataGeneratedAccessors)

- (void)addCarsOwnObject:(Vehicle *)value;
- (void)removeCarsOwnObject:(Vehicle *)value;
- (void)addCarsOwn:(NSSet *)values;
- (void)removeCarsOwn:(NSSet *)values;

@end
