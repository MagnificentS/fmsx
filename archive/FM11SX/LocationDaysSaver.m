//
//  LocationDaysSaver.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/27.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "LocationDaysSaver.h"


@implementation LocationDaysSaver

+ (void)saveDays:(LocationDays *)object toData:(NSMutableData *)data
{
	char cbuffer;
	short sbuffer;
	int ibuffer;
	
	cbuffer = [object unknownChar1];
	[data appendBytes:&cbuffer length:1];
	sbuffer = [object days];
	[data appendBytes:&sbuffer length:2];
	ibuffer = [object locationUID];
	[data appendBytes:&ibuffer length:4];
}

@end
