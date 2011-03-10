//
//  SXFSaveGameSummaryLoader.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFSaveGameSummaryLoader.h"
#import "SupportFunctions.h"
#import "FMDateLoader.h"
#import "FMString.h"

@implementation SXFSaveGameSummaryLoader

+ (SXFSaveGameSummary *)readFileFromData:(NSData *)data
{
	unsigned int offset = 0;
	int ibuffer;
	
	SXFSaveGameSummary *object = [[SXFSaveGameSummary alloc] init];
	
	//	0x02 unknown
	//	0x04 file type
	//	0x02 file version
	//	0x01 unknown
	
	// Skip 9 bytes (as comment above)
	offset += 9;
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict setObject:[FMString readFromData:data atOffset:&offset] forKey:@"leaguesActive"];
	[dict setObject:[FMString readFromData:data atOffset:&offset] forKey:@"FMVersion"];
	
	for (int i=1;i<=16;i++) {
		[dict setObject:[FMString readFromData:data atOffset:&offset] forKey:[NSString stringWithFormat:@"manager%dname",i]];
		[dict setObject:[FMString readFromData:data atOffset:&offset] forKey:[NSString stringWithFormat:@"manager%dclub",i]];
	}
	[object setInfoStrings:dict];
	[dict release];
	
	// Read last saved date (TBC)
	[FMDateLoader readFromData:data atOffset:&offset];
	
	// 0x04 ???
	offset += 4;
	
	[data getBytes:&ibuffer range:NSMakeRange(offset,4)];	offset += 4;
	[object setNManagers:ibuffer];
	
	NSLog(@"save_game_summary.dat: %d of %d read",offset,[data length]);
	
	return object;
}
@end