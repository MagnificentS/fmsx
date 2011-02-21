//
//  FixtureLoader.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FixtureLoader.h"
#import "FMDateLoader.h"
#import "GameVersions.h"

@implementation FixtureLoader

+ (Fixture *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset version:(short)version
{
	char cbuffer;
	unsigned char ucbuffer;
	short sbuffer;
	int ibuffer;
	
	unsigned int offset = *byteOffset;
	
	Fixture *object = [[Fixture alloc] init];
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setTeamType1:cbuffer];
	if (cbuffer==1) { // nation
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar11:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar12:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar13:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar14:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar15:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar16:cbuffer];
	}
	else if (cbuffer==50) { // club
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt5:ibuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt6:ibuffer];
	}
	
	[object setDate:[FMDateLoader readFromData:data atOffset:&offset]];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt1:ibuffer];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt2:ibuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar1:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar2:cbuffer];
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setTeamType2:cbuffer];
	if (cbuffer==1) { // nation
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar17:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar18:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar19:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar20:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar21:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar22:cbuffer];
	}
	else if (cbuffer==50) { // club
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt7:ibuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt8:ibuffer];
	}
	
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt3:ibuffer];
	[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
	[object setUnknownInt4:ibuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar3:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar4:cbuffer];
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setTeamType3:cbuffer];
	if (cbuffer==1) { // nation
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar23:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar24:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar25:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar26:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar27:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar28:cbuffer];
	}
	else if (cbuffer==50) { // club
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt9:ibuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setUnknownInt10:ibuffer];
	}
	
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar5:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar6:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar7:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar8:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar9:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar10:cbuffer];
	
	[data getBytes:&ucbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setNameFlags:ucbuffer];
	
	if ([object nameFlags] & FIXTURE_NAME_MAIN_STAGE_NAME) { 
		[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
		[object setMainStageShortID:sbuffer];
		
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar53:cbuffer];
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar54:cbuffer];
		
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setMainStageUID:ibuffer];
		
		[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
		[object setUnknownChar58:cbuffer];
	}
	if ([object nameFlags] & FIXTURE_NAME_SUB_STAGE_NAME) { 
		[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
		[object setSubStageShortID:sbuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setSubStageUID:ibuffer];
	}
	if ([object nameFlags] & FIXTURE_NAME_EXTRA_STAGE_NAME) {
		[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
		[object setExtraStageShortID:sbuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setExtraStageUID:ibuffer];
	}
	if ([object nameFlags] & FIXTURE_NAME_OTHER_NAME) {
		[data getBytes:&sbuffer range:NSMakeRange(offset, 2)]; offset += 2;
		[object setOtherStageShortID:sbuffer];
		[data getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
		[object setOtherStageUID:ibuffer];
	}

	// 4 chars - first is usually 0x0A
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar29:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar30:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar31:cbuffer];
	[data getBytes:&cbuffer range:NSMakeRange(offset, 1)]; offset += 1;
	[object setUnknownChar32:cbuffer];
	
	*byteOffset = offset;
	
	return object;
}

@end
