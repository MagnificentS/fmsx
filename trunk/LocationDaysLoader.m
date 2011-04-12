//
//  LocationDaysLoader.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/15.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "LocationDaysLoader.h"

@implementation LocationDaysLoader

+ (LocationDays *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset
{
	char cbuffer;
	short sbuffer;
	int ibuffer;
	
	unsigned int offset = *byteOffset;
	
	LocationDays *object = [[LocationDays alloc] init];
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	//[object setBetween15And21Only:cbuffer];
	[object setUnknownChar1:cbuffer];
	
	if (cbuffer>1) { NSLog(@"%d at %d",cbuffer,offset); }
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setDays:sbuffer];
	// nation or club
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setLocationUID:ibuffer];
	
	*byteOffset = offset;
	
	return object;
}

@end
