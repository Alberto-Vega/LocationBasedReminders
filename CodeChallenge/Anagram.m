//
//  Anagram.m
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/24/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import "Anagram.h"

@implementation Anagram

+ (BOOL) does: (NSString* ) firstWord contain: (NSString *) secondWord {
    NSMutableString *first = [firstWord mutableCopy];
    for (int i = 0; i<secondWord.length; i++) {
        NSString *letter = [secondWord substringWithRange:NSMakeRange(i, 1)];
        NSRange letterRange = [first rangeOfString:letter];
        if (letterRange.location != NSNotFound) {
            [first deleteCharactersInRange:letterRange];
        } else {
            return NO;
        }
    }
    return YES;
}

@end
