//
//  Derby.m
//  FM10SX
//
//  Created by Amy Kettlewell on 10/11/14.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "Club.h"
#import "Derby.h"
#import "Nation.h"
#import "Team.h"

@implementation Derby

@synthesize databaseClass, firstMatchTeam1Goals, firstMatchTeam2Goals, worldReputation, nationalReputation,
team1ID, team2ID, firstMatchCompetitionID, firstMatchStadiumID, firstMatchAttendance, firstMatchDate,
team1TotalGamesWon, team1TotalGamesDrawn, team1TotalGamesLost, rowID, UID, name, shortName, alternativeName, 
alternativeShortName, unknownChar1, unknownChar2, unknownChar3, unknownChar4;

- (id)init
{
	[super init];
	
	name = @"---";
	shortName = @"---";
	alternativeName = @"---";
	alternativeShortName = @"---";
	
	return self;
}

- (NSString *)team1String
{
	if (team1ID>-1) { 
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:team1ID] teamString]; 
	}
	return @"---";	
}
- (NSString *)team2String
{
	if (team2ID>-1) { 
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:team2ID] teamString]; 
	}
	return @"---";	
}
- (NSString *)team1ShortString
{
	if (team1ID>-1) { 
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:team1ID] teamShortString]; 
	}
	return @"---";	
}
- (NSString *)team2ShortString
{
	if (team2ID>-1) { 
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:team2ID] teamShortString]; 
	}
	return @"---";	
}

@end
