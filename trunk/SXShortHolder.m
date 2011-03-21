//
//  SXShortHolder.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/21.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXShortHolder.h"

@implementation SXShortHolder

@synthesize shortValue;

+ (SXShortHolder *)holderWithShort:(short)val
{
	SXShortHolder *newHolder = [[SXShortHolder alloc] init];
	[newHolder setShortValue:val];
	return newHolder;
}

@end
