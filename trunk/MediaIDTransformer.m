//
//  MediaIDTransformer.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/04/11.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "MediaIDTransformer.h"


@implementation MediaIDTransformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)object
{
	if (object == nil) return @"---";
	
	if ([object intValue] < 0) return @"---";
	
	return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] objectAtIndex:[object intValue]] name];
}

@end
