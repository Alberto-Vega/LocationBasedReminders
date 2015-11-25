//
//  Queue.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "Queue.h"

@interface Queue()
@property (strong) NSMutableArray *data;
@end

@implementation Queue
-(instancetype)init
{
    if (self = [super init]) {
        _data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)enqueue:(id)anObject {
    [self.data addObject:anObject];
}

-(id)dequeue {
    id headObject = [self.data objectAtIndex:0];
    if (headObject != nil) {
        [self.data removeObjectAtIndex:0];
    }
    return headObject;
}

@end
