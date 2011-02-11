//
//  PlayerStats.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/04.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlayerStats.h"


@implementation PlayerStats

@synthesize rowID, UID, databaseClass, goalkeeper, sweeper, defender, defensiveMidfielder, midfielder, attackingMidfielder,
forward, wingBack, freeRole, rightSide, leftSide, central, leftDefender, centralDefender, rightDefender,
centralDefensiveMidfielder, leftMidfielder, centralMidfielder, rightMidfielder, leftAttackingMidfielder,
centralAttackingMidfielder, rightAttackingMidfielder, centreForward, leftWingBack, rightWingBack, crossing,
dribbling, finishing, heading, longShots, marking, offTheBall, passing, penalties, tackling, creativity,
handling, aerialAbility, commandOfArea, communication, kicking, throwing, anticipation, decisions, oneOnOnes,
positioning, reflexes, firstTouch, technique, leftFoot, rightFoot, flair, corners, teamwork, workRate,
longThrows, eccentricity, rushingOut, tendencyToPunch, acceleration, freeKicks, strength, stamina, pace,
jumping, influence, dirtiness, balance, bravery, consistency, aggression, agility, importantMatches,
injuryProneness, versatility, naturalFitness, determination, composure, concentration, unknownChar1;

- (IBAction)maxStats
{
	[self setCorners:100];
	[self setCrossing:100];
	[self setDribbling:100];
	[self setFinishing:100];
	[self setFirstTouch:100];
	[self setFreeKicks:100];
	[self setHeading:100];
	[self setLongShots:100];
	[self setLongThrows:100];
	[self setMarking:100];
	[self setPassing:100];
	[self setPenalties:100];
	[self setTackling:100];
	[self setTechnique:100];
	[self setVersatility:100];
	[self setLeftFoot:100];
	[self setRightFoot:100];
	[self setAerialAbility:100];
	[self setCommandOfArea:100];
	[self setCommunication:100];
	[self setEccentricity:100];
	
	if ([self goalkeeper]>=15) {
		[self setHandling:100];
		[self setKicking:100];
		[self setOneOnOnes:100];
		[self setReflexes:100];
		[self setRushingOut:100];
		[self setTendencyToPunch:100];
		[self setThrowing:100];
	}
	
	[self setAcceleration:100];
	[self setAgility:100];
	[self setBalance:100];
	[self setInjuryProneness:1];
	[self setJumping:100];
	[self setNaturalFitness:100];
	[self setPace:100];
	[self setStamina:100];
	[self setStrength:100];
	[self setAggression:50];
	[self setAnticipation:100];
	[self setBravery:100];
	[self setComposure:100];
	[self setConcentration:100];
	[self setConsistency:100];
	[self setCreativity:100];
	[self setDecisions:100];
	[self setDetermination:100];
	[self setDirtiness:1];
	[self setFlair:100];
	[self setImportantMatches:100];
	[self setInfluence:100];
	[self setOffTheBall:100];
	[self setPositioning:100];
	[self setTeamwork:100];
	[self setWorkRate:100];
	[self setLeftSide:20];
	[self setRightSide:20];
	[self setCentral:20];
}

- (NSImage *)previewbg
{
	if (goalkeeper>=15) 
	{
		return [NSImage imageNamed:@"gkscreenblanked.png"];
	}
	else { return [NSImage imageNamed:@"playerscreenblanked.png"]; }
}	
- (int)previewStat1
{
	if (goalkeeper>=15) { return aerialAbility; }
	else { return corners; }
}
- (int)previewStat2
{
	if (goalkeeper>=15) { return commandOfArea; }
	else { return crossing; }
}
- (int)previewStat3
{
	if (goalkeeper>=15) { return communication; }
	else { return dribbling; }
}
- (int)previewStat4
{
	if (goalkeeper>=15) { return eccentricity; }
	else { return finishing; }
}
- (int)previewStat7
{
	if (goalkeeper>=15) { return handling; }
	else { return heading; }
}
- (int)previewStat8
{
	if (goalkeeper>=15) { return kicking; }
	else { return longShots; }
}
- (int)previewStat9;
{
	if (goalkeeper>=15) { return oneOnOnes; }
	else { return longThrows; }
}
- (int)previewStat10
{
	if (goalkeeper>=15) { return penalties; }
	else { return marking; }
}
- (int)previewStat11
{
	if (goalkeeper>=15) { return reflexes; }
	else { return passing; }
}
- (int)previewStat12
{
	if (goalkeeper>=15) { return rushingOut; }
	else { return penalties; }
}
- (int)previewStat13
{
	if (goalkeeper>=15) { return tendencyToPunch; }
	else { return tackling; }
}
- (int)previewStat14
{
	if (goalkeeper>=15) { return throwing; }
	else { return technique; }
}

- (NSString *)footString
{
	if (leftFoot>=15 && rightFoot >=15) { return @"Both"; }
	else if (leftFoot>=15 && rightFoot < 15) { return @"Left Only"; }
	else if (leftFoot<15 && rightFoot >= 15) { return @"Right Only"; }
	
	return @"Unknown";
}
	
// position ability
- (NSImage *)playerPositionAbility:(int)total
{
	if (total>19) { return [NSImage imageNamed:@"natural.png"]; }
	else if (total>14) { return [NSImage imageNamed:@"accomplished.png"]; }
	else if (total>11) { return [NSImage imageNamed:@"competent.png"]; }
	else if (total>8) { return [NSImage imageNamed:@"unconvincing.png"]; }
	else if (total>4) { return [NSImage imageNamed:@"awkward.png"]; }
	else if (total>2) { return [NSImage imageNamed:@"ineffectual.png"]; }
	else { return [NSImage imageNamed:@"posNeverPlayed.png"]; }
}

- (NSImage *)goalkeeperPositionAbility:(int)total
{
	if (total>11) { return [NSImage imageNamed:@"goalkeeperNatural.png"]; }
	else { return [NSImage imageNamed:@"goalkeeperNotPlayed.png"]; }
}

- (NSImage *)strikerPositionAbility
{
	int skillLevel = centreForward;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)amrPositionAbility
{
	int skillLevel = rightAttackingMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)amcPositionAbility
{
	int skillLevel = centralAttackingMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)amlPositionAbility
{
	int skillLevel = leftAttackingMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)mrPositionAbility
{
	int skillLevel = rightMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)mcPositionAbility
{
	int skillLevel = centralMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)mlPositionAbility
{
	int skillLevel = leftMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)dmcPositionAbility
{
	int skillLevel = centralDefensiveMidfielder;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)wbrPositionAbility
{
	int skillLevel = rightWingBack;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)wblPositionAbility
{
	int skillLevel = leftWingBack;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)drPositionAbility
{
	int skillLevel = rightDefender;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)dcPositionAbility
{
	int skillLevel = centralDefender;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)dlPositionAbility
{
	int skillLevel = leftDefender;
	return [self playerPositionAbility:skillLevel];
}

- (NSImage *)gkPositionAbility
{
	int skillLevel = goalkeeper;
	return [self playerPositionAbility:skillLevel];
}


@end
