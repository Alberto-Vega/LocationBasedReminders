//
//  AppDelegate.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "AppDelegate.h"
@import Parse;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupParse];
    [self registerForNotifications];
    // Override point for customization after application launch.
    return YES;
}

- (void)setupParse {
    [Parse setApplicationId:@"6RYCOzLAYmCSqATDQiNVUBN8cmLOtbsHTsJc6oDu" clientKey:@"8H95bDJQTlKxc1QTbqAmT0NV4hPFx7ooaE7Gz8Tx"];
}

- (void)registerForNotifications {
    [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge| UIUserNotificationTypeSound categories:nil]];
}

@end
