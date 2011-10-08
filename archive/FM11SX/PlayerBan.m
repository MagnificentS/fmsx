//
//  PlayerBan.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlayerBan.h"

@implementation PlayerBan

@synthesize gamesBannedFor, gamesMissed, reason, scope, decision, hasFixture, 
disciplineRulesIndex, daysBanned, pointsCount, startDate, fixture, unknownData1;

+ (NSString *)reasonStringWithType:(int)val
{
	if (val==PBR_INVALID) { return NSLocalizedString(@"Invalid",nil); }
	else if (val==PBR_YELLOW_CARDS) { return NSLocalizedString(@"Yellow Cards",@"ban reason"); }
	else if (val==PBR_POINTS) { return NSLocalizedString(@"Points",@"ban reason"); }
	else if (val==PBR_RED_CARDS) { return NSLocalizedString(@"Red Cards",@"ban reason"); }
	else if (val==PBR_YELLOW_CARDS_IN_LAST_TEN_GAMES) { return NSLocalizedString(@"Yellow Cards In Last 10 Games",@"ban reason"); }
	
	return [NSString stringWithFormat:@"Unknown: %d",val];
}

+ (NSString *)decisionStringWithType:(int)val
{
	if (val==PBD_INVALID) { return NSLocalizedString(@"Invalid",nil); }
	else if (val==PBD_WRONG) { return NSLocalizedString(@"Wrong",@"ban decision"); }
	else if (val==PBD_DOUBTFUL) { return NSLocalizedString(@"Doubtful",@"ban decision"); }
	else if (val==PBD_FAIR) { return NSLocalizedString(@"Fair",@"ban decision"); }
	else if (val==PBD_RIGHT) { return NSLocalizedString(@"Right",@"ban decision"); }
	
	return [NSString stringWithFormat:@"Unknown: %d",val];
}

+ (NSString *)scopeStringWithType:(int)val
{
	if (val==PBS_COMPETITION) { return NSLocalizedString(@"Competition",@"ban scope"); }
	else if (val==PBS_DOMESTIC_CUP) { return NSLocalizedString(@"Domestic Cup",@"ban scope"); }
	else if (val==PBS_DOMESTIC_LEAGUE) { return NSLocalizedString(@"Domestic League",@"ban scope"); }
	else if (val==PBS_NATIONAL) { return NSLocalizedString(@"National",@"ban scope"); }
	else if (val==PBS_CONTINENTAL) { return NSLocalizedString(@"Continental",@"ban scope"); }
	else if (val==PBS_INTERNATIONAL) { return NSLocalizedString(@"International",@"ban scope"); }
	else if (val==PBS_GLOBAL) { return NSLocalizedString(@"Global",@"ban scope"); }
	
	return [NSString stringWithFormat:@"Unknown: %d",val];
}

@end
