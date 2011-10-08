//
//  Official.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Official.h"
#import "Competition.h"

@implementation Official

@synthesize allowingFlow, discipline, importantMatches, pressure, refereeing, runningLine, timekeeping,
FIFAOfficial, continentalOfficial, assistantRefereeOnly, currentAbility, potentialAbility, reputation,
cityID, competitionsAsReferee, competitionsAsAssistant, pastGames, unknownDate1;

- (void)setNewRefereeCompetitionID:(int)val
{
	if (val<0) { return; }
	
	int newCompID = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:val] UID];
	[[self mutableArrayValueForKey:@"competitionsAsReferee"] addObject:[NSNumber numberWithInt:newCompID]];
}

- (void)setNewAssistantCompetitionID:(int)val
{
	if (val<0) { return; }
	
	int newCompID = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:val] UID];
	[[self mutableArrayValueForKey:@"competitionsAsReferee"] addObject:[NSNumber numberWithInt:newCompID]];
}

@end
