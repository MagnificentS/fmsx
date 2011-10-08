//
//  NonPlayer.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/20.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NonPlayer.h"
#import "ScoutingKnowledge.h"

@implementation NonPlayer

@synthesize homeReputation, currentReputation, worldReputation, currentAbility, potentialAbility,
preferredFormation, preferredFormation2, attackingFormation, defensiveFormation, hasScoutingKnowledges,
nonPlayingStatsID, scoutingKnowledges, tendencies, hasTendencies, unknownChar1, unknownChar2, unknownChar3,
unknownData1, unknownData2, unknownData3, unknownBool1, unknownBool2;

- (void)setNewScoutingKnowledgeNationID:(int)val
{
	if (val<0) { return; }
	
	ScoutingKnowledge *object = [[ScoutingKnowledge alloc] init];
	[object setNationID:val];
	[object setPercentComplete:50];
	[[self mutableArrayValueForKey:@"scoutingKnowledges"] addObject:object];
	[object release];
}

@end
