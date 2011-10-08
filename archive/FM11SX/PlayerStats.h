//
//  PlayerStats.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/04.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PlayerStats : NSObject {
	char databaseClass, goalkeeper, sweeper, defender, defensiveMidfielder, midfielder, attackingMidfielder,
		 forward, wingBack, freeRole, rightSide, leftSide, central, leftDefender, centralDefender, rightDefender,
		 centralDefensiveMidfielder, leftMidfielder, centralMidfielder, rightMidfielder, leftAttackingMidfielder,
		 centralAttackingMidfielder, rightAttackingMidfielder, centreForward, leftWingBack, rightWingBack, crossing,
		 dribbling, finishing, heading, longShots, marking, offTheBall, passing, penalties, tackling, creativity,
		 handling, aerialAbility, commandOfArea, communication, kicking, throwing, anticipation, decisions, oneOnOnes,
		 positioning, reflexes, firstTouch, technique, leftFoot, rightFoot, flair, corners, teamwork, workRate,
		 longThrows, eccentricity, rushingOut, tendencyToPunch, acceleration, freeKicks, strength, stamina, pace,
		 jumping, influence, dirtiness, balance, bravery, consistency, aggression, agility, importantMatches,
		 injuryProneness, versatility, naturalFitness, determination, composure, concentration, unknownChar1;
	int rowID, UID;
}

@property(assign,readwrite) char databaseClass, goalkeeper, sweeper, defender, defensiveMidfielder, midfielder, attackingMidfielder,
forward, wingBack, freeRole, rightSide, leftSide, central, leftDefender, centralDefender, rightDefender,
centralDefensiveMidfielder, leftMidfielder, centralMidfielder, rightMidfielder, leftAttackingMidfielder,
centralAttackingMidfielder, rightAttackingMidfielder, centreForward, leftWingBack, rightWingBack, crossing,
dribbling, finishing, heading, longShots, marking, offTheBall, passing, penalties, tackling, creativity,
handling, aerialAbility, commandOfArea, communication, kicking, throwing, anticipation, decisions, oneOnOnes,
positioning, reflexes, firstTouch, technique, leftFoot, rightFoot, flair, corners, teamwork, workRate,
longThrows, eccentricity, rushingOut, tendencyToPunch, acceleration, freeKicks, strength, stamina, pace,
jumping, influence, dirtiness, balance, bravery, consistency, aggression, agility, importantMatches,
injuryProneness, versatility, naturalFitness, determination, composure, concentration, unknownChar1;
@property(assign,readwrite) int rowID, UID;

- (IBAction)maxStats;

- (NSString *)footString;

- (NSImage *)previewbg;
- (int)previewStat1;
- (int)previewStat2;
- (int)previewStat3;
- (int)previewStat4;
- (int)previewStat7;
- (int)previewStat8;
- (int)previewStat9;
- (int)previewStat10;
- (int)previewStat11;
- (int)previewStat12;
- (int)previewStat13;
- (int)previewStat14;

// Position/Role ratings
- (NSString *)bestRoleString; 


// ST
- (float)strikerAbilityLevel;
- (float)deepLyingForward; 
- (float)advancedForward;
- (float)targetMan;
- (float)poacher;
- (float)stikerTrequartista;


// AMC
- (float)amcAbilityLevel;
- (float)amcInsideForward;
- (float)amcAttackingMidfielder;
- (float)amcAdvancedPlaymaker;
- (float)amcTrequartista;


// AML/AMR
- (float)amlrAbilityLevel;
- (float)amlrWinger;
- (float)amlrInsideForward;
- (float)amlrAdvancedPlaymaker;



// MC
- (float)cmAbilityLevel;
- (float)centMidfielder;
- (float)mcDeepLyingPlaymaker;
- (float)mcAdvancedPlaymaker;
- (float)ballWinningMidfielder;


// ML/MR
- (float)mlrAbilityLevel;
- (float)mlrWinger;
- (float)wideMidfielder;


// DMC
- (float)dmcAbilityLevel;
- (float)dmcDefensiveMidfielder;
- (float)dmcDeepLyingPlaymaker;
- (float)dmcAnchorMan;


// DR/DL
- (float)dlrAbilityLevel;
- (float)dlrWingBack;
- (float)dlrFullBack;


// CB
- (float)cbAbilityLevel;
- (float)coverCentreBack;
- (float)stopperCentreBack;


// position ability (Natural, Accomplished, etc.)
- (NSImage *)strikerPositionAbility;
- (NSImage *)amrPositionAbility;
- (NSImage *)amcPositionAbility;
- (NSImage *)amlPositionAbility;
- (NSImage *)mrPositionAbility;
- (NSImage *)mcPositionAbility;
- (NSImage *)mlPositionAbility;
- (NSImage *)dmcPositionAbility;
- (NSImage *)wbrPositionAbility;
- (NSImage *)wblPositionAbility;
- (NSImage *)drPositionAbility;
- (NSImage *)dcPositionAbility;
- (NSImage *)dlPositionAbility;
- (NSImage *)gkPositionAbility;

- (NSImage *)playerPositionAbility:(int)total;
- (NSImage *)goalkeeperPositionAbility:(int)total;




@end
