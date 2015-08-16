# How-to-use-HealthKit
the example that express how to use healthkit,the two features are HKQuantityType and HKCharacteristicType.and it is very easy

The healthkit usage can help you make it easy to use it.The two thing must concerned.first is HKCharacteristicType that include gender,birthday etc,second is HKQuantityType that include height,weight.

First of all,We need create two NSSet instances,that can help you read and write your health data.

And then,You need initialize HKHealthStore,that can help you save your health data.

Later,We need a authorized.
As you see,if you wanna save your data,you need authorized wheather iOS can 'read' or 'write' your health data.

[self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                if (!success) {
                    CLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                    return;
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                });
                
            }];
