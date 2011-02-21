//
//  FixtureSaver.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/12/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FixtureSaver.h"
#import "FMDateSaver.h"
#import "GameVersions.h"

@implementation FixtureSaver

+ (void)saveFixture:(Fixture *)object toData:(NSMutableData *)data version:(short)version
{
	char cbuffer;
	short sbuffer;
	unsigned char ucbuffer;
	int ibuffer;

	cbuffer = [object teamType1];
	[data appendBytes:&cbuffer length:1];
	
	if ([object teamType1]==1) { // nation
		cbuffer = [object unknownChar11];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar12];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar13];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar14];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar15];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar16];
		[data appendBytes:&cbuffer length:1];
	}
	else if ([object teamType1]==50) { // club
		ibuffer = [object unknownInt5];
		[data appendBytes:&ibuffer length:4];
		ibuffer = [object unknownInt6];
		[data appendBytes:&ibuffer length:4];
	}
	
	[FMDateSaver saveDate:[object date] toData:data];
	
	ibuffer = [object unknownInt1];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object unknownInt2];
	[data appendBytes:&ibuffer length:4];
	cbuffer = [object unknownChar1];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar2];
	[data appendBytes:&cbuffer length:1];
	
	cbuffer = [object teamType2];
	[data appendBytes:&cbuffer length:1];
	
	if ([object teamType2]==1) { // nation
		cbuffer = [object unknownChar17];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar18];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar19];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar20];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar21];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar22];
		[data appendBytes:&cbuffer length:1];
	}
	else if ([object teamType2]==50) { // club
		ibuffer = [object unknownInt7];
		[data appendBytes:&ibuffer length:4];
		ibuffer = [object unknownInt8];
		[data appendBytes:&ibuffer length:4];
	}
	
	ibuffer = [object unknownInt3];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object unknownInt4];
	[data appendBytes:&ibuffer length:4];
	cbuffer = [object unknownChar3];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar4];
	[data appendBytes:&cbuffer length:1];
	
	cbuffer = [object teamType3];
	[data appendBytes:&cbuffer length:1];
	
	if ([object teamType3]==1) { // nation
		cbuffer = [object unknownChar23];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar24];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar25];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar26];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar27];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar28];
		[data appendBytes:&cbuffer length:1];
	}
	else if ([object teamType3]==50) { // club
		ibuffer = [object unknownInt9];
		[data appendBytes:&ibuffer length:4];
		ibuffer = [object unknownInt10];
		[data appendBytes:&ibuffer length:4];
	}
	
	cbuffer = [object unknownChar5];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar6];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar7];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar8];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar9];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar10];
	[data appendBytes:&cbuffer length:1];
	
	ucbuffer = [object nameFlags];
	[data appendBytes:&ucbuffer length:1];
	
	if ([object nameFlags] & FIXTURE_NAME_MAIN_STAGE_NAME) { 
		sbuffer = [object mainStageShortID];
		[data appendBytes:&sbuffer length:2];
		cbuffer = [object unknownChar53];
		[data appendBytes:&cbuffer length:1];
		cbuffer = [object unknownChar54];
		[data appendBytes:&cbuffer length:1];
		ibuffer = [object mainStageUID];
		[data appendBytes:&ibuffer length:4];
		cbuffer = [object unknownChar58];
		[data appendBytes:&cbuffer length:1];
	}
	if ([object nameFlags] & FIXTURE_NAME_SUB_STAGE_NAME) { 
		sbuffer = [object subStageShortID];
		[data appendBytes:&sbuffer length:2];
		ibuffer = [object subStageUID];
		[data appendBytes:&ibuffer length:4];
	}
	if ([object nameFlags] & FIXTURE_NAME_EXTRA_STAGE_NAME) {
		sbuffer = [object extraStageShortID];
		[data appendBytes:&sbuffer length:2];
		ibuffer = [object extraStageUID];
		[data appendBytes:&ibuffer length:4];
	}
	if ([object nameFlags] & FIXTURE_NAME_OTHER_NAME) {
		sbuffer = [object otherStageShortID];
		[data appendBytes:&sbuffer length:2];
		ibuffer = [object otherStageUID];
		[data appendBytes:&ibuffer length:4];
	}
	
	cbuffer = [object unknownChar29];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar30];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar31];
	[data appendBytes:&cbuffer length:1];
	cbuffer = [object unknownChar32];
	[data appendBytes:&cbuffer length:1];
	
}

@end
