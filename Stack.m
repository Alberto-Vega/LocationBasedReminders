//
//  Stack.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/23/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "Stack.h"

@implementation Stack
@synthesize count;
- (id)init
{
    if ( self = [super  init])
    {
        m_array = [[NSMutableArray alloc] init];
        count = 0;
    }
    return self;
}

- (void)push:(id)anObject
{
    [m_array addObject:anObject];
    count = m_array.count;
}

- (id)pop
{
    id obj = nil;
    if (m_array.count > 0)
    {
        [m_array removeLastObject];
        count = m_array.count;
    }
    return obj;
}

- (void) clear
{
    [m_array removeAllObjects];
    count = 0;
}
@end
