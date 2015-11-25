//
//  Queue.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

- (void)enqueue:(id)anObject;
- (id)dequeue;

@end
