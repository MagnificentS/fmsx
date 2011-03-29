//
//  OfficialPastGame.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "OfficialPastGame.h"
#import "Team.h"

@implementation OfficialPastGame

@synthesize yellowCards, redCards, rating, homePenalties, awayPenalties, homeGoals, awayGoals,
date, competitionID, homeTeamID, awayTeamID, unknownChar1;

- (NSString *)fixtureString
{
	NSString *homeTeam, *awayTeam;
	
	if (homeTeamID<0) { homeTeam = @"---"; }
	else {
		homeTeam = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:homeTeamID] teamShortString];
	}
	
	if (awayTeamID<0) { awayTeam = @"---"; }
	else {
		awayTeam = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:awayTeamID] teamShortString];
	}
	
	return [NSString stringWithFormat:@"%@ V %@",homeTeam,awayTeam];
}

@end
