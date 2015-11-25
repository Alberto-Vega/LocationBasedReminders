//
//  Stack.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
    NSMutableArray* m_array;
    int count;
}

- (void)push: (id)anObject;
- (id)pop;
- (void)clear;
@property (nonatomic, readonly) int count;
@end
