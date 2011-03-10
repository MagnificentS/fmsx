//
//  SXFGameInfoLoader.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFGameInfoLoader.h"
#import "SupportFunctions.h"
#import "FMDateLoader.h"
#import "FMString.h"

@implementation SXFGameInfoLoader

+ (SXFGameInfo *)readFileFromData:(NSData *)data
{
	unsigned int offset = 0;
	char cbuffer;
	int ibuffer;
	
	SXFGameInfo *object = [[SXFGameInfo alloc] init];
	
	//	0x02 unknown
	//	0x04 file type (CString)
	//	0x02 file version
	//	0x09 unknown
	
	// Skip 17 bytes in the new file length (as comment above)
	offset += 17;
	
	// directory
	[data getBytes:&cbuffer range:NSMakeRange(offset,1)];	offset += 1;
	NSMutableString *directory = [[NSMutableString alloc] init];
	while (cbuffer==6) {
		[directory appendFormat:@"/%@",[FMString readFromData:data atOffset:&offset]];
		[data getBytes:&cbuffer range:NSMakeRange(offset,1)];	offset += 1;
	}
	[object setDirectory:directory];
	[directory release];
	
	//	0x03 unknown
	//	another 0x01 in fm11
	//	0x04 unknown (-1)
	//	0x01 unknown
	
	// Skip 9 bytes (as comment above)
	offset += 9;
	
	// Start Date
	[FMDateLoader readFromData:data atOffset:&offset];
	
	[data getBytes:&ibuffer range:NSMakeRange(offset,4)];	offset += 4;
	[object setGameID:ibuffer];
	
	//	unknown (Not sure what this is for?)
	offset += 2515;
	
	[data getBytes:&ibuffer range:NSMakeRange(offset,4)];	offset += 4;
	[object setTimesSaved:ibuffer];
	
	// 0x04	???
	offset += 4;
	[FMDateLoader readFromData:data atOffset:&offset];
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setStartBuildVersion:ibuffer];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setCurrentBuildVersion:ibuffer];
	
	offset += 10;
	
	NSLog(@"game_info.dat: %d of %d read",offset,[data length]);
	
	return object;
}

@end
