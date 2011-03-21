//
//  SXFloatHolder.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/21.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFloatHolder.h"


@implementation SXFloatHolder

@synthesize floatValue;

+ (SXFloatHolder *)holderWithFloat:(float)val
{
	SXFloatHolder *newHolder = [[SXFloatHolder alloc] init];
	[newHolder setFloatValue:val];
	return newHolder;
}


@end
