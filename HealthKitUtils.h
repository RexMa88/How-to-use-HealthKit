//
//  HealthKitUtils.h
//  GraduationProject
//
//  Created by machao on 15-6-2.
//  Copyright (c) 2015年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <HealthKit/HealthKit.h>

@interface HealthKitUtils : NSObject

+ (HealthKitUtils *)sharedInstance;

- (void)recordWeight:(double)weight;


@end
