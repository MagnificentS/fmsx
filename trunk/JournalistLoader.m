//
//  JournalistLoader.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "JournalistLoader.h"

@implementation JournalistLoader

+ (Journalist *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset
{
	char cbuffer;
	int ibuffer;
	
	unsigned int offset = *byteOffset;
	
	Journalist *object = [[Journalist alloc] init];
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setFavouriteClubID:ibuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setStyleOfWriting:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setHonesty:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setCuriosity:cbuffer];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setCurrentEmployerID:ibuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setCharacterFlags:cbuffer];
		
	*byteOffset = offset;
	
	return object;
}

@end
