//
//  CompetitionHistorySaver.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/12/14.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CompetitionHistorySaver.h"

@implementation CompetitionHistorySaver

+ (void)saveCompetitionHistory:(CompetitionHistory *)object toData:(NSMutableData *)data archived:(BOOL)archived
{
	char cbuffer;
	short sbuffer;
	int ibuffer;
	
	if (!archived) {
		cbuffer = [object databaseClass];
		[data appendBytes:&cbuffer length:1];
	}
	ibuffer = [object competitionID];
	[data appendBytes:&ibuffer length:4];
	sbuffer = [object year];
	[data appendBytes:&sbuffer length:2];
	ibuffer = [object firstPlaceTeamID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object secondPlaceTeamID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object thirdPlaceTeamID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object hostTeam1ID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object hostTeam2ID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object stadiumID];
	[data appendBytes:&ibuffer length:4];
	
	ibuffer = [object unknownInt1];
	[data appendBytes:&ibuffer length:4];
	cbuffer = [object unknownChar1];
	[data appendBytes:&cbuffer length:1];
	
	ibuffer = [object rowID];
	[data appendBytes:&ibuffer length:4];
	ibuffer = [object UID];
	[data appendBytes:&ibuffer length:4];
}

@end
