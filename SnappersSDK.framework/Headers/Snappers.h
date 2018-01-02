//
//  Snappers.h
//  SnappersSDK
//
//  Created by Alon Genosar on 11/22/17.
//  Copyright © 2017 Snappers. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Snappers : NSObject
+ (instancetype) sharedInstance;
-(void) sendTestNotification:(NSString *)text delay:(NSTimeInterval)delay callback:(void(^)(NSError *error))callback;
-(void) isNotificationsEnabled:(void(^)(NSError *error,BOOL result))callback;
-(void) enableNotifications:(BOOL)enabled callback:(void(^)(NSError *error,BOOL result))callback;
-(void) signout:(void(^)(NSError *error))callback;
@property (readonly) NSString *version;
@end
