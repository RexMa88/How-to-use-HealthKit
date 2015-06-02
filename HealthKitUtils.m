//
//  HealthKitUtils.m
//
//
//  Created by machao on 15-6-2.
//  Copyright (c) 2015年. All rights reserved.
//

#import "HealthKitUtils.h"

@interface HealthKitUtils ()

@property (nonatomic, strong) HKHealthStore *healthStore;

@end

@implementation HealthKitUtils

+ (HealthKitUtils *)sharedInstance {
    static HealthKitUtils *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        if ([HKHealthStore isHealthDataAvailable]) {
            NSSet *writeDataTypes = [self dataTypesToWrite];
            NSSet *readDataTypes = [self dataTypesToRead];
            
            self.healthStore = [[HKHealthStore alloc] init];
            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                if (!success) {
                    CLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                    return;
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                });
                
            }];
        }
    }
    return self;
}

#pragma mark - HealthKit Permissions

// Returns the types of data that Fit wishes to write to HealthKit.
- (NSSet *)dataTypesToWrite {
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    return [NSSet setWithObject:weightType];
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    HKCharacteristicType *birthdayType = [HKCharacteristicType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    HKCharacteristicType *biologicalSexType = [HKCharacteristicType characteristicTypeForIdentifier: HKCharacteristicTypeIdentifierBiologicalSex];
    return [NSSet setWithObjects:heightType ,weightType ,birthdayType, biologicalSexType, nil];
}

-(void)recordWeight:(double)weight{
    HKQuantityType *weightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    if ([HKHealthStore isHealthDataAvailable] &&
        [self.healthStore authorizationStatusForType:weightType]==HKAuthorizationStatusSharingAuthorized) {
        HKQuantity *weightQuantity = [HKQuantity quantityWithUnit:[HKUnit gramUnit] doubleValue:weight];
        HKQuantitySample *weightSample = [HKQuantitySample quantitySampleWithType:weightType quantity:weightQuantity startDate:[NSDate date] endDate:[NSDate date]];
        [_healthStore saveObject:weightSample withCompletion:^(BOOL success, NSError *error) {
            if (success) {
                CLog(@"The data has print");
            }else{
                CLog(@"The error is %@",error);
            }
        }];
    }
}

@end
