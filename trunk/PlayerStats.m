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
	if (leftFoot >= 75 && rightFoot >= 75) { return @"Either"; }
	else if (leftFoot >= 75 && rightFoot < 25) { return @"Left Only"; }
	else if (leftFoot < 25 && rightFoot >= 75) { return @"Right Only"; }	
	else if (leftFoot >= 75 && rightFoot < 75) { return @"Left Preferred"; }
	else if (leftFoot < 75 && rightFoot >= 75) { return @"Right Preferred"; }
	
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

// Position/Role ratings

- (NSString *)bestRoleString
{
	float currentBest = [self deepLyingForward];
	NSString *pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
	NSString *currentBestRole = [@"DpLy Fwd " stringByAppendingString:pctValue];
	
	if (currentBest < [self advancedForward]) 
	{	
		currentBest = [self advancedForward];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Adv Fwd " stringByAppendingString:pctValue];
	}
	if (currentBest < [self targetMan]) 
	{
		currentBest = [self targetMan];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Target " stringByAppendingString:pctValue];
	}
	if (currentBest < [self poacher]) 
	{
		currentBest = [self poacher];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Poacher " stringByAppendingString:pctValue];
	}
	if (currentBest < [self stikerTrequartista]) 
	{
		currentBest = [self stikerTrequartista];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Treq Fwd " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amcInsideForward]) 
	{
		currentBest = [self amcInsideForward];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMC InFwd " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amcAttackingMidfielder]) 
	{
		currentBest = [self amcAttackingMidfielder];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMC AttMid " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amcAdvancedPlaymaker]) 
	{
		currentBest = [self amcAdvancedPlaymaker];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMC AdvPly " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amcTrequartista]) 
	{
		currentBest = [self amcTrequartista];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMC Treq " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amlrWinger]) 
	{
		currentBest = [self amlrWinger];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMLR Winger " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amlrInsideForward]) 
	{
		currentBest = [self amlrInsideForward];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMLR InFwd " stringByAppendingString:pctValue];
	}
	if (currentBest < [self amlrAdvancedPlaymaker]) 
	{
		currentBest = [self amlrAdvancedPlaymaker];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"AMLR AdvPly " stringByAppendingString:pctValue];
	}
	if (currentBest < [self centMidfielder]) 
	{
		currentBest = [self centMidfielder];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"MC " stringByAppendingString:pctValue];
	}
	if (currentBest < [self mcDeepLyingPlaymaker]) 
	{
		currentBest = [self mcDeepLyingPlaymaker];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"MC DpLyPly " stringByAppendingString:pctValue];
	}
	if (currentBest < [self mcAdvancedPlaymaker]) 
	{
		currentBest = [self mcAdvancedPlaymaker];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"MC AdvPly " stringByAppendingString:pctValue];
	}
	if (currentBest < [self ballWinningMidfielder]) 
	{
		currentBest = [self ballWinningMidfielder];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Ball Win MC " stringByAppendingString:pctValue];
	}
	if (currentBest < [self dmcDefensiveMidfielder]) 
	{
		currentBest = [self dmcDefensiveMidfielder];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"DMC " stringByAppendingString:pctValue];
	}
	if (currentBest < [self dmcDeepLyingPlaymaker]) 
	{
		currentBest = [self dmcDeepLyingPlaymaker];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"DMC DLyPly " stringByAppendingString:pctValue];
	}
	if (currentBest < [self dmcAnchorMan]) 
	{
		currentBest = [self dmcAnchorMan];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"DMC Anchor " stringByAppendingString:pctValue];
	}
	if (currentBest < [self dlrWingBack]) 
	{
		currentBest = [self dlrWingBack];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Wing Back " stringByAppendingString:pctValue];
	}
	if (currentBest < [self dlrFullBack]) 
	{
		currentBest = [self dlrFullBack];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Full Back " stringByAppendingString:pctValue];
	}
	if (currentBest < [self coverCentreBack]) 
	{
		currentBest = [self coverCentreBack];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Cover CB " stringByAppendingString:pctValue];
	}
	if (currentBest < [self stopperCentreBack]) 
	{
		currentBest = [self stopperCentreBack];
		pctValue = [NSString stringWithFormat:@"(%.1f%%)", currentBest];
		currentBestRole = [@"Stopper CB " stringByAppendingString:pctValue];
	}
	
	//Just a workaround for GK
	int gkCheck = goalkeeper;
	if (gkCheck>14) 
	{ 
		currentBestRole = @"GK (100%)";
	}
	
	
	return currentBestRole;
}



//Strikers

- (float)strikerAbilityLevel
{
	int skillLevel = centreForward;
	float strikerAbilityLevel;
	if (skillLevel>18) { strikerAbilityLevel = 1.0; }
	else if (skillLevel>14) { strikerAbilityLevel = 0.95; }
	else if (skillLevel>11) { strikerAbilityLevel = 0.85; }
	else if (skillLevel>8) { strikerAbilityLevel = 0.70; }
	else if (skillLevel>4) { strikerAbilityLevel = 0.50; }
	else { strikerAbilityLevel = 0.40; }
	
	return strikerAbilityLevel;
}


- (float)deepLyingForward
{
	float strikerPositionAdjustmentMultiplier = [self strikerAbilityLevel];
	float tempDeepLyingForward = ((agility * 0.0) + (balance * 0.7) + (strength * 0.9) + (acceleration * 0.5) + (pace * 0.5) + 
								  (jumping * 0.3) + (stamina * 0.0) + (technique * 0.5) + (firstTouch * 0.9) + (dribbling * 0.5) + 
								  (crossing * 0.0) + (finishing * 0.8) + (longShots * 0.3) + (passing * 0.5) + (heading * 0.3) + (marking * 0.0) + 
								  (tackling * 0.0) + (creativity * 0.1) + (anticipation * 0.9) + (decisions * 0.5) + (offTheBall * 0.5) + 
								  (flair * 0.1) + (composure * 0.7) + (positioning * 0.0) + (bravery * 0.5) + (workRate * 0.2) + 
								  (concentration * 0.0) + (determination * 0.9) + (teamwork * 0.3));
	tempDeepLyingForward = (tempDeepLyingForward * strikerPositionAdjustmentMultiplier) * 0.1;
	return tempDeepLyingForward;
}

- (float)advancedForward
{
	float strikerPositionAdjustmentMultiplier = [self strikerAbilityLevel];
	float tempAdvancedForward = ((agility * 0.5) + (balance * 0.2) + (strength * 0.0) + (acceleration * 1.0) + (pace * 1.0) + 
								 (jumping * 0.0) + (stamina * 0.0) + (technique * 0.8) + (firstTouch * 0.8) + (dribbling * 0.8) + 
								 (crossing * 0.0) + (finishing * 1.0) + (longShots * 0.0) + (passing * 0.0) + (heading * 0.1) + (marking * 0.0) + 
								 (tackling * 0.0) + (creativity * 0.0) + (anticipation * 0.9) + (decisions * 0.2) + (offTheBall * 0.9) + 
								 (flair * 0.7) + (composure * 0.9) + (positioning * 0.0) + (bravery * 0.3) + (workRate * 0.6) + 
								 (concentration * 0.0) + (determination * 0.7) + (teamwork * 0.0)); 
	tempAdvancedForward = (tempAdvancedForward * strikerPositionAdjustmentMultiplier) * 0.1;
	return tempAdvancedForward;
}

- (float)targetMan
{
	float strikerPositionAdjustmentMultiplier = [self strikerAbilityLevel];
	float tempTargetMan = ((agility * 0.0) + (balance * 0.7) + (strength * 1.3) + (acceleration * 0.0) + (pace * 0.0) + 
						   (jumping * 1.1) + (stamina * 0.0) + (technique * 0.3) + (firstTouch * 0.9) + (dribbling * 0.0) + 
						   (crossing * 0.0) + (finishing * 0.5) + (longShots * 0.0) + (passing * 0.2) + (heading * 1.2) + (marking * 0.0) + 
						   (tackling * 0.0) + (creativity * 0.1) + (anticipation * 0.6) + (decisions * 0.1) + (offTheBall * 0.4) + 
						   (flair * 0.0) + (composure * 0.5) + (positioning * 0.3) + (bravery * 0.9) + (workRate * 0.8) + 
						   (concentration * 0.0) + (determination * 0.9) + (teamwork * 0.6)); 
	tempTargetMan = (tempTargetMan * strikerPositionAdjustmentMultiplier) * 0.1;
	return tempTargetMan;
}

- (float)poacher
{
	float strikerPositionAdjustmentMultiplier = [self strikerAbilityLevel];
	float tempPoacher = ((agility * 0.3) + (balance * 0.3) + (strength * 0.0) + (acceleration * 0.3) + (pace * 0.0) + 
						 (jumping * 0.0) + (stamina * 0.0) + (technique * 0.8) + (firstTouch * 1.1) + (dribbling * 0.4) + 
						 (crossing * 0.0) + (finishing * 1.3) + (longShots * 0.0) + (passing * 0.0) + (heading * 0.1) + (marking * 0.0) + 
						 (tackling * 0.0) + (creativity * 0.4) + (anticipation * 1.3) + (decisions * 0.9) + (offTheBall * 1.2) + 
						 (flair * 0.2) + (composure * 1.3) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.0) + 
						 (concentration * 0.4) + (determination * 0.6) + (teamwork * 0.0)); 
	tempPoacher = (tempPoacher * strikerPositionAdjustmentMultiplier) * 0.1;
	return tempPoacher;
}

- (float)stikerTrequartista
{
	float strikerPositionAdjustmentMultiplier = [self strikerAbilityLevel];
	float tempStikerTrequartista = ((agility * 0.4) + (balance * 0.4) + (strength * 0.0) + (acceleration * 0.3) + (pace * 0.3) + 
									(jumping * 0.0) + (stamina * 0.0) + (technique * 0.8) + (firstTouch * 0.8) + (dribbling * 0.5) + 
									(crossing * 0.2) + (finishing * 0.3) + (longShots * 0.2) + (passing * 1.0) + (heading * 0.0) + (marking * 0.0) + 
									(tackling * 0.0) + (creativity * 1.0) + (anticipation * 0.9) + (decisions * 0.8) + (offTheBall * 0.7) + 
									(flair * 0.9) + (composure * 0.7) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.3) + 
									(concentration * 0.0) + (determination * 0.2) + (teamwork * 0.7)); 
	tempStikerTrequartista = (tempStikerTrequartista * strikerPositionAdjustmentMultiplier) * 0.1;
	return tempStikerTrequartista;
}


// AMC

- (float)amcAbilityLevel
{
	int skillLevel = centralAttackingMidfielder;
	float amcAbilityLevel;
	if (skillLevel>17) { amcAbilityLevel = 1.0; }
	else if (skillLevel>14) { amcAbilityLevel = 0.97; }
	else if (skillLevel>11) { amcAbilityLevel = 0.85; }
	else if (skillLevel>8) { amcAbilityLevel = 0.70; }
	else if (skillLevel>4) { amcAbilityLevel = 0.50; }
	else { amcAbilityLevel = 0.40; }
	
	return amcAbilityLevel;
}

- (float)amcInsideForward
{
	float amcPositionAdjustmentMultiplier = [self amcAbilityLevel];
	float tempAmcInsideForward = ((agility * 0.4) + (balance * 0.4) + (strength * 0.0) + (acceleration * 0.4) + (pace * 0.4) + 
								  (jumping * 0.0) + (stamina * 0.1) + (technique * 1.0) + (firstTouch * 0.8) + (dribbling * 0.6) + 
								  (crossing * 0.0) + (finishing * 1.0) + (longShots * 0.2) + (passing * 0.6) + (heading * 0.0) + (marking * 0.0) + 
								  (tackling * 0.0) + (creativity * 0.6) + (anticipation * 0.6) + (decisions * 0.5) + (offTheBall * 1.0) + 
								  (flair * 0.9) + (composure * 0.9) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.2) + 
								  (concentration * 0.0) + (determination * 0.4) + (teamwork * 0.3)); 
	tempAmcInsideForward = (tempAmcInsideForward * amcPositionAdjustmentMultiplier) * 0.1;
	return tempAmcInsideForward;
}

- (float)amcAttackingMidfielder
{
	float amcPositionAdjustmentMultiplier = [self amcAbilityLevel];
	float tempAmcAttackingMidfielder = ((agility * 0.3) + (balance * 0.3) + (strength * 0.3) + (acceleration * 0.1) + (pace * 0.1) + 
										(jumping * 0.0) + (stamina * 0.7) + (technique * 0.7) + (firstTouch * 0.7) + (dribbling * 0.4) + 
										(crossing * 0.3) + (finishing * 0.8) + (longShots * 0.5) + (passing * 0.8) + (heading * 0.0) + (marking * 0.0) + 
										(tackling * 0.2) + (creativity * 0.7) + (anticipation * 0.7) + (decisions * 0.9) + (offTheBall * 0.7) + 
										(flair * 0.0) + (composure * 0.5) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.3) + 
										(concentration * 0.4) + (determination * 0.5) + (teamwork * 0.5)); 
	tempAmcAttackingMidfielder = (tempAmcAttackingMidfielder * amcPositionAdjustmentMultiplier) * 0.1;
	return tempAmcAttackingMidfielder;
}

- (float)amcAdvancedPlaymaker
{
	float amcPositionAdjustmentMultiplier = [self amcAbilityLevel];
	float tempAmcAdvancedPlaymaker = ((agility * 0.2) + (balance * 0.3) + (strength * 0.1) + (acceleration * 0.1) + (pace * 0.2) + 
									  (jumping * 0.0) + (stamina * 0.5) + (technique * 0.8) + (firstTouch * 0.9) + (dribbling * 0.6) + 
									  (crossing * 0.1) + (finishing * 0.1) + (longShots * 0.1) + (passing * 1.0) + (heading * 0.0) + (marking * 0.0) + 
									  (tackling * 0.1) + (creativity * 1.0) + (anticipation * 0.9) + (decisions * 1.0) + (offTheBall * 0.6) + 
									  (flair * 0.7) + (composure * 0.8) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.2) + 
									  (concentration * 0.2) + (determination * 0.4) + (teamwork * 0.4)); 
	tempAmcAdvancedPlaymaker = (tempAmcAdvancedPlaymaker * amcPositionAdjustmentMultiplier) * 0.1;
	return tempAmcAdvancedPlaymaker;
}


- (float)amcTrequartista
{
	float amcPositionAdjustmentMultiplier = [self amcAbilityLevel];
	float tempAmcTrequartista = ((agility * 0.4) + (balance * 0.4) + (strength * 0.0) + (acceleration * 0.3) + (pace * 0.3) + 
								 (jumping * 0.0) + (stamina * 0.0) + (technique * 0.8) + (firstTouch * 0.8) + (dribbling * 0.5) + 
								 (crossing * 0.0) + (finishing * 0.4) + (longShots * 0.3) + (passing * 1.0) + (heading * 0.0) + (marking * 0.0) + 
								 (tackling * 0.0) + (creativity * 1.0) + (anticipation * 0.9) + (decisions * 0.8) + (offTheBall * 0.9) + 
								 (flair * 0.9) + (composure * 0.8) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.3) + 
								 (concentration * 0.0) + (determination * 0.0) + (teamwork * 0.5)); 
	tempAmcTrequartista = (tempAmcTrequartista * amcPositionAdjustmentMultiplier) * 0.1;
	return tempAmcTrequartista;
}


// AMR & AML

- (float)amlrAbilityLevel
{
	int skillLevel;
	if (leftAttackingMidfielder < rightAttackingMidfielder) {skillLevel = rightAttackingMidfielder;}
	else {skillLevel = leftAttackingMidfielder;}
	
	float amlrAbilityLevel;
	if (skillLevel>18) { amlrAbilityLevel = 1.0; }
	else if (skillLevel>14) { amlrAbilityLevel = 0.97; }
	else if (skillLevel>11) { amlrAbilityLevel = 0.85; }
	else if (skillLevel>8) { amlrAbilityLevel = 0.70; }
	else if (skillLevel>4) { amlrAbilityLevel = 0.50; }
	else { amlrAbilityLevel = 0.40; }
	
	return amlrAbilityLevel;
}

- (float)amlrWinger
{
	float amlrPositionAdjustmentMultiplier = [self amlrAbilityLevel];
	float tempAmlrWinger = ((agility * 0.6) + (balance * 0.6) + (strength * 0.0) + (acceleration * 1.0) + (pace * 1.0) + 
							(jumping * 0.0) + (stamina * 0.5) + (technique * 0.7) + (firstTouch * 0.6) + (dribbling * 0.9) + 
							(crossing * 1.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.6) + (heading * 0.0) + (marking * 0.0) + 
							(tackling * 0.0) + (creativity * 0.6) + (anticipation * 0.4) + (decisions * 0.3) + (offTheBall * 0.6) + 
							(flair * 0.6) + (composure * 0.0) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.5) + 
							(concentration * 0.0) + (determination * 0.4) + (teamwork * 0.5)); 
	tempAmlrWinger = (tempAmlrWinger * amlrPositionAdjustmentMultiplier) * 0.1;
	return tempAmlrWinger;	
}

- (float)amlrInsideForward
{
	float amlrPositionAdjustmentMultiplier = [self amlrAbilityLevel];
	float tempAmlrInsideForward = ((agility * 0.4) + (balance * 0.4) + (strength * 0.0) + (acceleration * 0.5) + (pace * 0.5) + 
								   (jumping * 0.0) + (stamina * 0.0) + (technique * 1.0) + (firstTouch * 0.8) + (dribbling * 0.7) + 
								   (crossing * 0.0) + (finishing * 1.0) + (longShots * 0.3) + (passing * 0.8) + (heading * 0.0) + (marking * 0.0) + 
								   (tackling * 0.0) + (creativity * 0.8) + (anticipation * 0.6) + (decisions * 0.5) + (offTheBall * 0.9) + 
								   (flair * 0.9) + (composure * 0.9) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.1) + 
								   (concentration * 0.0) + (determination * 0.0) + (teamwork * 0.3)); 
	tempAmlrInsideForward = (tempAmlrInsideForward * amlrPositionAdjustmentMultiplier) * 0.1;
	return tempAmlrInsideForward;
}

- (float)amlrAdvancedPlaymaker
{
	float amlrPositionAdjustmentMultiplier = [self amlrAbilityLevel];
	float tempAmlrAdvancedPlaymaker = ((agility * 0.2) + (balance * 0.2) + (strength * 0.0) + (acceleration * 0.2) + (pace * 0.5) + 
									   (jumping * 0.0) + (stamina * 0.7) + (technique * 0.9) + (firstTouch * 0.9) + (dribbling * 0.9) + 
									   (crossing * 0.3) + (finishing * 0.0) + (longShots * 0.0) + (passing * 1.0) + (heading * 0.0) + (marking * 0.0) + 
									   (tackling * 0.0) + (creativity * 1.0) + (anticipation * 0.8) + (decisions * 1.0) + (offTheBall * 0.8) + 
									   (flair * 0.8) + (composure * 0.6) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.2) + 
									   (concentration * 0.0) + (determination * 0.2) + (teamwork * 0.2)); 
	tempAmlrAdvancedPlaymaker = (tempAmlrAdvancedPlaymaker * amlrPositionAdjustmentMultiplier) * 0.1;
	return tempAmlrAdvancedPlaymaker;
}


// MC
- (float)cmAbilityLevel
{
	int skillLevel = centralMidfielder;
	float cmAbilityLevel;
	if (skillLevel>18) { cmAbilityLevel = 1.0; }
	else if (skillLevel>14) { cmAbilityLevel = 0.94; }
	else if (skillLevel>11) { cmAbilityLevel = 0.85; }
	else if (skillLevel>8) { cmAbilityLevel = 0.70; }
	else if (skillLevel>4) { cmAbilityLevel = 0.50; }
	else { cmAbilityLevel = 0.40; }
	
	return cmAbilityLevel;
}

- (float)centMidfielder
{
	float mcPositionAdjustmentMultiplier = [self cmAbilityLevel];
	float tempCentMidfielder = ((agility * 0.3) + (balance * 0.4) + (strength * 0.5) + (acceleration * 0.0) + (pace * 0.0) + 
								(jumping * 0.0) + (stamina * 0.8) + (technique * 0.4) + (firstTouch * 0.5) + (dribbling * 0.2) + 
								(crossing * 0.4) + (finishing * 0.2) + (longShots * 0.0) + (passing * 0.6) + (heading * 0.4) + (marking * 0.5) + 
								(tackling * 0.5) + (creativity * 0.4) + (anticipation * 0.5) + (decisions * 0.7) + (offTheBall * 0.3) + 
								(flair * 0.0) + (composure * 0.1) + (positioning * 0.6) + (bravery * 0.5) + (workRate * 0.9) + 
								(concentration * 0.4) + (determination * 0.7) + (teamwork * 0.6)); 
	tempCentMidfielder = (tempCentMidfielder * mcPositionAdjustmentMultiplier) * 0.1;
	return tempCentMidfielder;
}

- (float)mcDeepLyingPlaymaker
{
	float mcPositionAdjustmentMultiplier = [self cmAbilityLevel];
	float tempMcDeepLyingPlaymaker = ((agility * 0.0) + (balance * 0.2) + (strength * 0.4) + (acceleration * 0.0) + (pace * 0.0) + 
									  (jumping * 0.0) + (stamina * 0.5) + (technique * 0.8) + (firstTouch * 0.9) + (dribbling * 0.1) + 
									  (crossing * 0.3) + (finishing * 0.0) + (longShots * 0.0) + (passing * 1.0) + (heading * 0.0) + (marking * 0.2) + 
									  (tackling * 0.2) + (creativity * 1.0) + (anticipation * 0.9) + (decisions * 0.9) + (offTheBall * 0.2) + 
									  (flair * 0.4) + (composure * 0.6) + (positioning * 0.6) + (bravery * 0.0) + (workRate * 0.2) + 
									  (concentration * 0.5) + (determination * 0.7) + (teamwork * 0.7)); 
	tempMcDeepLyingPlaymaker = (tempMcDeepLyingPlaymaker * mcPositionAdjustmentMultiplier) * 0.1;
	return tempMcDeepLyingPlaymaker;
}

- (float)mcAdvancedPlaymaker
{
	float mcPositionAdjustmentMultiplier = [self cmAbilityLevel];
	float tempMcAdvancedPlaymaker = ((agility * 0.2) + (balance * 0.3) + (strength * 0.2) + (acceleration * 0.1) + (pace * 0.2) + 
									 (jumping * 0.0) + (stamina * 0.5) + (technique * 0.8) + (firstTouch * 0.9) + (dribbling * 0.6) + 
									 (crossing * 0.1) + (finishing * 0.0) + (longShots * 0.0) + (passing * 1.0) + (heading * 0.0) + (marking * 0.2) + 
									 (tackling * 0.2) + (creativity * 1.0) + (anticipation * 0.8) + (decisions * 1.0) + (offTheBall * 0.6) + 
									 (flair * 0.7) + (composure * 0.7) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.2) + 
									 (concentration * 0.2) + (determination * 0.4) + (teamwork * 0.4)); 
	tempMcAdvancedPlaymaker = (tempMcAdvancedPlaymaker * mcPositionAdjustmentMultiplier) * 0.1;
	return tempMcAdvancedPlaymaker;
}

- (float)ballWinningMidfielder
{
	float mcPositionAdjustmentMultiplier = [self cmAbilityLevel];
	float tempBallWinningMidfielder = ((agility * 0.3) + (balance * 0.5) + (strength * 1.0) + (acceleration * 0.1) + (pace * 0.0) + 
									   (jumping * 0.0) + (stamina * 0.7) + (technique * 0.0) + (firstTouch * 0.1) + (dribbling * 0.1) + 
									   (crossing * 0.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.5) + (heading * 0.3) + (marking * 0.6) + 
									   (tackling * 1.1) + (creativity * 0.0) + (anticipation * 0.7) + (decisions * 0.7) + (offTheBall * 0.0) + 
									   (flair * 0.0) + (composure * 0.4) + (positioning * 0.9) + (bravery * 0.9) + (workRate * 0.5) + 
									   (concentration * 0.7) + (determination * 0.8) + (teamwork * 0.4)); 
	tempBallWinningMidfielder = (tempBallWinningMidfielder * mcPositionAdjustmentMultiplier) * 0.1;
	return tempBallWinningMidfielder;
}


// ML/MR
- (float)mlrAbilityLevel
{
	int skillLevel;
	if (leftMidfielder < rightMidfielder) {skillLevel = rightMidfielder;}
	else {skillLevel = leftMidfielder;}
	
	float mlrAbilityLevel;
	if (skillLevel>18) { mlrAbilityLevel = 1.0; }
	else if (skillLevel>14) { mlrAbilityLevel = 0.97; }
	else if (skillLevel>11) { mlrAbilityLevel = 0.85; }
	else if (skillLevel>8) { mlrAbilityLevel = 0.70; }
	else if (skillLevel>4) { mlrAbilityLevel = 0.50; }
	else { mlrAbilityLevel = 0.40; }
	
	return mlrAbilityLevel;
}

- (float)mlrWinger
{
	float mlrPositionAdjustmentMultiplier = [self mlrAbilityLevel];
	float tempMlrWinger = ((agility * 0.5) + (balance * 0.5) + (strength * 0.0) + (acceleration * 1.1) + (pace * 1.0) + 
						   (jumping * 0.0) + (stamina * 0.5) + (technique * 0.7) + (firstTouch * 0.6) + (dribbling * 0.9) + 
						   (crossing * 1.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.6) + (heading * 0.0) + (marking * 0.1) + 
						   (tackling * 0.1) + (creativity * 0.6) + (anticipation * 0.4) + (decisions * 0.2) + (offTheBall * 0.6) + 
						   (flair * 0.6) + (composure * 0.0) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.5) + 
						   (concentration * 0.0) + (determination * 0.5) + (teamwork * 0.5)); 
	tempMlrWinger = (tempMlrWinger * mlrPositionAdjustmentMultiplier) * 0.1;
	return tempMlrWinger;
}

- (float)wideMidfielder
{
	float mlrPositionAdjustmentMultiplier = [self mlrAbilityLevel];
	float tempWideMidfielder = ((agility * 0.3) + (balance * 0.3) + (strength * 0.0) + (acceleration * 0.5) + (pace * 0.5) + 
								(jumping * 0.0) + (stamina * 0.5) + (technique * 0.7) + (firstTouch * 0.6) + (dribbling * 0.9) + 
								(crossing * 1.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.6) + (heading * 0.0) + (marking * 0.3) + 
								(tackling * 0.3) + (creativity * 0.7) + (anticipation * 0.8) + (decisions * 0.6) + (offTheBall * 0.6) + 
								(flair * 0.6) + (composure * 0.0) + (positioning * 0.0) + (bravery * 0.0) + (workRate * 0.5) + 
								(concentration * 0.0) + (determination * 0.5) + (teamwork * 0.5)); 
	tempWideMidfielder = (tempWideMidfielder * mlrPositionAdjustmentMultiplier) * 0.1;
	return tempWideMidfielder;
}


// DMC
- (float)dmcAbilityLevel
{
	int skillLevel = defensiveMidfielder;
	float dmcAbilityLevel;
	if (skillLevel>18) { dmcAbilityLevel = 1.0; }
	else if (skillLevel>14) { dmcAbilityLevel = 0.97; }
	else if (skillLevel>11) { dmcAbilityLevel = 0.85; }
	else if (skillLevel>8) { dmcAbilityLevel = 0.70; }
	else if (skillLevel>4) { dmcAbilityLevel = 0.50; }
	else { dmcAbilityLevel = 0.40; }
	
	return dmcAbilityLevel;
}

- (float)dmcDefensiveMidfielder
{
	float dmcPositionAdjustmentMultiplier = [self dmcAbilityLevel];
	float tempDmcDefensiveMidfielder = ((agility * 0.1) + (balance * 0.3) + (strength * 0.7) + (acceleration * 0.2) + (pace * 0.0) + 
										(jumping * 0.1) + (stamina * 0.8) + (technique * 0.3) + (firstTouch * 0.4) + (dribbling * 0.0) + 
										(crossing * 0.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.6) + (heading * 0.4) + (marking * 0.7) + 
										(tackling * 0.7) + (creativity * 0.0) + (anticipation * 0.8) + (decisions * 0.7) + (offTheBall * 0.0) + 
										(flair * 0.0) + (composure * 0.6) + (positioning * 0.9) + (bravery * 0.5) + (workRate * 0.5) + 
										(concentration * 0.7) + (determination * 0.7) + (teamwork * 0.7)); 
	tempDmcDefensiveMidfielder = (tempDmcDefensiveMidfielder * dmcPositionAdjustmentMultiplier) * 0.1;
	return tempDmcDefensiveMidfielder;	
}

- (float)dmcDeepLyingPlaymaker
{
	float dmcPositionAdjustmentMultiplier = [self dmcAbilityLevel];
	float tempDmcDeepLyingPlaymaker = ((agility * 0.0) + (balance * 0.2) + (strength * 0.1) + (acceleration * 0.0) + (pace * 0.0) + 
									   (jumping * 0.0) + (stamina * 0.7) + (technique * 0.8) + (firstTouch * 0.9) + (dribbling * 0.0) + 
									   (crossing * 0.4) + (finishing * 0.0) + (longShots * 0.0) + (passing * 1.0) + (heading * 0.0) + (marking * 0.2) + 
									   (tackling * 0.2) + (creativity * 1.0) + (anticipation * 0.9) + (decisions * 0.9) + (offTheBall * 0.0) + 
									   (flair * 0.3) + (composure * 0.6) + (positioning * 0.8) + (bravery * 0.1) + (workRate * 0.2) + 
									   (concentration * 0.7) + (determination * 0.7) + (teamwork * 0.7));  
	tempDmcDeepLyingPlaymaker = (tempDmcDeepLyingPlaymaker * dmcPositionAdjustmentMultiplier) * 0.1;
	return tempDmcDeepLyingPlaymaker;
}

- (float)dmcAnchorMan
{
	float dmcPositionAdjustmentMultiplier = [self dmcAbilityLevel];
	float tempDmcAnchorMan = ((agility * 0.2) + (balance * 0.3) + (strength * 0.9) + (acceleration * 0.3) + (pace * 0.0) + 
							  (jumping * 0.1) + (stamina * 0.6) + (technique * 0.0) + (firstTouch * 0.1) + (dribbling * 0.0) + 
							  (crossing * 0.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.1) + (heading * 0.3) + (marking * 0.8) + 
							  (tackling * 0.9) + (creativity * 0.0) + (anticipation * 0.8) + (decisions * 0.6) + (offTheBall * 0.0) + 
							  (flair * 0.0) + (composure * 0.7) + (positioning * 1.0) + (bravery * 0.9) + (workRate * 0.6) + 
							  (concentration * 0.7) + (determination * 0.7) + (teamwork * 0.7)); 
	tempDmcAnchorMan = (tempDmcAnchorMan * dmcPositionAdjustmentMultiplier) * 0.1;
	return tempDmcAnchorMan;	
}


// DR/DL
- (float)dlrAbilityLevel
{
	int skillLevel;
	if (leftDefender < rightDefender) {skillLevel = rightDefender;}
	else {skillLevel = leftDefender;}
	
	float dlrAbilityLevel;
	if (skillLevel>18) { dlrAbilityLevel = 1.0; }
	else if (skillLevel>14) { dlrAbilityLevel = 0.95; }
	else if (skillLevel>11) { dlrAbilityLevel = 0.85; }
	else if (skillLevel>8) { dlrAbilityLevel = 0.70; }
	else if (skillLevel>4) { dlrAbilityLevel = 0.50; }
	else { dlrAbilityLevel = 0.40; }
	
	return dlrAbilityLevel;
}

- (float)dlrWingBack
{
	float dlrPositionAdjustmentMultiplier = [self dlrAbilityLevel];
	float tempDlrWingBack = ((agility * 0.1) + (balance * 0.1) + (strength * 0.5) + (acceleration * 0.8) + (pace * 0.7) + 
							 (jumping * 0.0) + (stamina * 1.0) + (technique * 0.2) + (firstTouch * 0.1) + (dribbling * 0.7) + 
							 (crossing * 0.7) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.4) + (heading * 0.0) + (marking * 0.8) + 
							 (tackling * 0.8) + (creativity * 0.2) + (anticipation * 0.3) + (decisions * 0.9) + (offTheBall * 0.5) + 
							 (flair * 0.0) + (composure * 0.0) + (positioning * 0.7) + (bravery * 0.0) + (workRate * 0.8) + 
							 (concentration * 0.4) + (determination * 0.0) + (teamwork * 0.7)); 
	tempDlrWingBack = (tempDlrWingBack * dlrPositionAdjustmentMultiplier) * 0.1;
	return tempDlrWingBack;
}

- (float)dlrFullBack
{
	float dlrPositionAdjustmentMultiplier = [self dlrAbilityLevel];
	float tempDlrFullBack = ((agility * 0.1) + (balance * 0.1) + (strength * 0.8) + (acceleration * 0.7) + (pace * 0.6) + 
							 (jumping * 0.1) + (stamina * 1.0) + (technique * 0.0) + (firstTouch * 0.0) + (dribbling * 0.2) + 
							 (crossing * 0.5) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.2) + (heading * 0.0) + (marking * 0.9) + 
							 (tackling * 0.9) + (creativity * 0.0) + (anticipation * 0.7) + (decisions * 0.9) + (offTheBall * 0.3) + 
							 (flair * 0.0) + (composure * 0.3) + (positioning * 0.8) + (bravery * 0.1) + (workRate * 0.8) + 
							 (concentration * 0.7) + (determination * 0.0) + (teamwork * 0.7)); 
	tempDlrFullBack = (tempDlrFullBack * dlrPositionAdjustmentMultiplier) * 0.1;
	return tempDlrFullBack;
}


// CB
- (float)cbAbilityLevel
{
	int skillLevel = centralDefender;
	float cbAbilityLevel;
	if (skillLevel>18) { cbAbilityLevel = 1.0; }
	else if (skillLevel>14) { cbAbilityLevel = 0.95; }
	else if (skillLevel>11) { cbAbilityLevel = 0.85; }
	else if (skillLevel>8) { cbAbilityLevel = 0.70; }
	else if (skillLevel>4) { cbAbilityLevel = 0.50; }
	else { cbAbilityLevel = 0.40; }
	
	return cbAbilityLevel;
}

- (float)coverCentreBack
{
	float cbPositionAdjustmentMultiplier = [self cbAbilityLevel];
	float tempCoverCentreBack = ((agility * 0.0) + (balance * 0.1) + (strength * 0.7) + (acceleration * 0.5) + (pace * 0.0) + 
								 (jumping * 0.8) + (stamina * 0.3) + (technique * 0.0) + (firstTouch * 0.0) + (dribbling * 0.0) + 
								 (crossing * 0.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.0) + (heading * 0.8) + (marking * 0.9) + 
								 (tackling * 0.9) + (creativity * 0.0) + (anticipation * 0.7) + (decisions * 0.9) + (offTheBall * 0.3) + 
								 (flair * 0.0) + (composure * 0.8) + (positioning * 0.8) + (bravery * 0.2) + (workRate * 0.4) + 
								 (concentration * 0.9) + (determination * 0.8) + (teamwork * 0.6)); 
	tempCoverCentreBack = (tempCoverCentreBack * cbPositionAdjustmentMultiplier) * 0.1;
	return tempCoverCentreBack;
}

- (float)stopperCentreBack
{
	float cbPositionAdjustmentMultiplier = [self cbAbilityLevel];
	float tempStopperCentreBack = ((agility * 0.0) + (balance * 0.3) + (strength * 1.0) + (acceleration * 0.0) + (pace * 0.0) + 
								   (jumping * 0.9) + (stamina * 0.5) + (technique * 0.0) + (firstTouch * 0.0) + (dribbling * 0.0) + 
								   (crossing * 0.0) + (finishing * 0.0) + (longShots * 0.0) + (passing * 0.0) + (heading * 0.9) + (marking * 0.9) + 
								   (tackling * 1.0) + (creativity * 0.0) + (anticipation * 0.0) + (decisions * 0.9) + (offTheBall * 0.0) + 
								   (flair * 0.0) + (composure * 0.8) + (positioning * 0.8) + (bravery * 0.7) + (workRate * 0.5) + 
								   (concentration * 0.8) + (determination * 0.8) + (teamwork * 0.5)); 
	tempStopperCentreBack = (tempStopperCentreBack * cbPositionAdjustmentMultiplier) * 0.1;
	return tempStopperCentreBack;
}


@end
