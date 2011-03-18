//
//  HumanLoader.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameVersions.h"
#import "HumanLoader.h"
#import "FMDateLoader.h"
#import "FMString.h"
#import "GeneralInfoLoader.h"
#import "BookmarkFolderLoader.h"
#import "NewsFilterListLoader.h"
#import "SupportFunctions.h"

@implementation HumanLoader

+ (Human *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset version:(short)version
{
	char cbuffer;
	short sbuffer;
	int ibuffer;
	NSMutableArray *tempArray, *tempArray2;
	
	unsigned int offset = *byteOffset;
	
	Human *object = [[Human alloc] init];
	
	// ???
	[object setUnknownData1:[data subdataWithRange:NSMakeRange(offset, 6)]]; 
	offset += 6;
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setUnreadNewsItems:sbuffer];
	
	// ???
	[object setUnknownData2:[data subdataWithRange:NSMakeRange(offset, 2)]]; 
	offset += 2;
	
	[object setHolidayReturnDate:[FMDateLoader readFromData:data atOffset:&offset]];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setFogOfWarIndex:ibuffer];
	
	// ???
	[object setUnknownData3:[data subdataWithRange:NSMakeRange(offset, 2)]]; 
	offset += 2;
	
	[object setPassword:[FMString readFromData:data atOffset:&offset]];
	
	// ???
	[object setUnknownData17:[data subdataWithRange:NSMakeRange(offset, 157)]]; 
	offset += 157;
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<ibuffer;i++) {
		[tempArray addObject:[GeneralInfoLoader readFromData:data atOffset:&offset readInfo:YES version:version]];
	}
	[object setInfos:tempArray];
	[tempArray release];
	
	// ???
	[object setUnknownData4:[data subdataWithRange:NSMakeRange(offset, 10)]]; 
	offset += 10;
	
	// viewed fixtures
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar1:cbuffer];
	[object setUnknownData5:[data subdataWithRange:NSMakeRange(offset, (cbuffer*8))]]; 
	offset += (cbuffer*8);

//	commented out til i store
//	for (int i=0; i<MAX_HUMAN_PREFERRED_PLAYERS; i++) {
//		offset += 8;
//	}
	[object setUnknownData6:[data subdataWithRange:NSMakeRange(offset, (MAX_HUMAN_PREFERRED_PLAYERS*8))]]; 
	offset += (MAX_HUMAN_PREFERRED_PLAYERS*8);
	
	NSLog(@"in news filter lists at %d",offset);
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<ibuffer;i++) {
		[tempArray addObject:[NewsFilterListLoader readFromData:data atOffset:&offset version:version]];
		NSLog(@"done filter list %d at %d",(i+1),offset);
	}
	[object setNewsFilterLists:tempArray];
	[tempArray release];
	
	// ???
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar2:cbuffer];
	
	NSLog(@"out of news filter lists at %d",offset);
	
	// NULL string
	[SupportFunctions readCStringFromData:data atOffset:&offset length:4];
	
	// ???
	[object setUnknownData7:[data subdataWithRange:NSMakeRange(offset, 11)]]; 
	offset += 11;
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	tempArray = [[NSMutableArray alloc] init];
	for (int i=0;i<cbuffer;i++) {
		tempArray2 = [[NSMutableArray alloc] init];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		for (int j=0;j<ibuffer;j++) {
			NSLog(@"md info %d at %d",j,offset);
			[tempArray2 addObject:[GeneralInfoLoader readFromData:data atOffset:&offset readInfo:YES version:version]];
		}
		[tempArray addObject:tempArray2];
		[tempArray2 release];
	}
	[object setMediaDecisions:tempArray];
	[tempArray release];
	
	NSLog(@"after media decisions at %d",offset);
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setUnknownShort1:sbuffer];
	[object setUnknownData8:[data subdataWithRange:NSMakeRange(offset, (sbuffer*215))]]; 
	offset += (sbuffer*215);
	
	NSLog(@"after 215-1 at %d",offset);
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setUnknownShort2:sbuffer];
	[object setUnknownData9:[data subdataWithRange:NSMakeRange(offset, (sbuffer*215))]]; 
	offset += (sbuffer*215);
	
	NSLog(@"after 215-2 at %d",offset);
	
	// ???
	[object setUnknownData10:[data subdataWithRange:NSMakeRange(offset, 18)]]; 
	offset += 18;
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setUnknownShort3:sbuffer];
	[object setUnknownData11:[data subdataWithRange:NSMakeRange(offset, (sbuffer*16))]]; 
	offset += (sbuffer*16);
	
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setUnknownShort4:sbuffer];
	[object setUnknownData13:[data subdataWithRange:NSMakeRange(offset, (sbuffer*8))]]; 
	offset += (sbuffer*8);
	
	NSLog(@"after 2 arrays at %d",offset);
	
	// date
	[object setUnknownData12:[data subdataWithRange:NSMakeRange(offset, 4)]]; 
	offset += 4;
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt1:ibuffer];
	
	if (version<FM2011_11_2) {
		[object setUnknownData15:[data subdataWithRange:NSMakeRange(offset, (ibuffer*18))]]; 
		offset += (ibuffer*18);
	}
	else {
		[object setUnknownData15:[data subdataWithRange:NSMakeRange(offset, (ibuffer*19))]]; 
		offset += (ibuffer*19);
	}
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt3:ibuffer];
	[object setUnknownData14:[data subdataWithRange:NSMakeRange(offset, (ibuffer*22))]]; 
	offset += (ibuffer*22);
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt2:ibuffer];
	[object setUnknownData18:[data subdataWithRange:NSMakeRange(offset, (ibuffer*18))]]; 
	offset += (ibuffer*18);
	
	NSLog(@"after 3 arrays at %d",offset);
	
	// ???
	if (version<FM2011_11_2) {
		[object setUnknownData16:[data subdataWithRange:NSMakeRange(offset, 21)]]; 
		offset += 21;
	}
	else {
		// 24 bytes, date, char
		[object setUnknownData16:[data subdataWithRange:NSMakeRange(offset, 29)]]; 
		offset += 29;
	}
	
	NSLog(@"before twitter with version %d at %d",version,offset);
	
	// encrypted strings
	[object setTwitterLogin:[FMString readFromData:data atOffset:&offset]];
	[object setTwitterPassword:[FMString readFromData:data atOffset:&offset]];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setTwitterUpdateType:cbuffer];
	
	[object setYoutubeLogin:[FMString readFromData:data atOffset:&offset]];
	[object setYoutubePassword:[FMString readFromData:data atOffset:&offset]];
	

	NSLog(@"at bookmarks at %d",offset);
	[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
	[object setTopLevelBookmarkItems:sbuffer];
	
	if ([object topLevelBookmarkItems]>0) {
		[object setBookmarks:[BookmarkFolderLoader readFromData:data atOffset:&offset version:version]];
	}
	
	NSLog(@"at home page at %d",offset);
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setHomePageSet:cbuffer];
	
	if ([object homePageSet]) {
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		tempArray = [[NSMutableArray alloc] init];
		for (int i=0;i<ibuffer;i++) {
			[tempArray addObject:[GeneralInfoLoader readFromData:data atOffset:&offset readInfo:YES version:version]];
		}
		[object setHomePageInfos:tempArray];
		[tempArray release];
	}
	NSLog(@"out of human at %d",offset);
	
	*byteOffset = offset;
	
	return object;
}

@end
