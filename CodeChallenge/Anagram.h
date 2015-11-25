//
//  Anagram.h
//  LocationBasedReminders
//
//  Created by Alberto Vega Gonzalez on 11/24/15.
//  Copyright © 2015 Alberto Vega Gonzalez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Anagram : NSObject

+ (BOOL) does: (NSString* ) firstWord contain: (NSString *) secondWord;

@end
