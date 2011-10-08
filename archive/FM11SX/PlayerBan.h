//
//  PlayerBan.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FMDate.h"
#import "ShortFixture.h"

// type
#define PBT_GLOBAL_BAN			0
#define PBT_LEAGUE_BAN			1
#define PBT_CUP_BAN				2
#define PBT_DOMESTIC_BAN		3
#define PBT_CONTINENTAL_BAN		4
#define PBT_INTERNATIONAL_BAN	5
#define PBT_UNAVAILABLE			6
#define PBT_SABBATICAL			7
#define PBT_INJURY_REASONS		8
#define PBT_MEDICAL_REASONS		9
#define PBT_PERSONAL_REASONS	10
#define PBT_ON_HOLIDAY			11
#define PBT_STUDY_LEAVE			12
#define PBT_MILITARY_SERVICE	13

// ban scopes
#define PBS_COMPETITION			1	// Bans must be added so that scopes are in ascending order.
#define PBS_DOMESTIC_CUP		5	// This order is used to work out which games are covered by which bans
#define PBS_DOMESTIC_LEAGUE		6	// there are gaps so that more can be added in later on
#define PBS_NATIONAL			10
#define PBS_CONTINENTAL			15
#define PBS_INTERNATIONAL		20
#define PBS_GLOBAL				25

// ban reasons
#define PBR_INVALID								-1
#define PBR_YELLOW_CARDS						0
#define PBR_POINTS								1
#define PBR_RED_CARDS							2
#define PBR_YELLOW_CARDS_IN_LAST_TEN_GAMES		3

// decisions
#define PBD_INVALID		-1
#define PBD_WRONG		0	// completely wrong decision
#define PBD_DOUBTFUL	1	// there was doubt and/or room for subjective interpretation
#define PBD_FAIR		2	// ban was fair enough (nothing inherently wrong with it)
#define PBD_RIGHT		3	// absolutely right

@interface PlayerBan : NSObject {
	char gamesBannedFor, gamesMissed, reason, scope, decision;
	BOOL hasFixture;
	short disciplineRulesIndex, daysBanned, pointsCount;
	NSData *unknownData1;
	ShortFixture *fixture;
	FMDate *startDate;
}

@property (readwrite,assign) char gamesBannedFor, gamesMissed, reason, scope, decision;
@property (readwrite,assign) BOOL hasFixture;
@property (readwrite,assign) short disciplineRulesIndex, daysBanned, pointsCount;
@property (readwrite,assign) FMDate *startDate;
@property (readwrite,assign) ShortFixture *fixture;
@property(readwrite,copy) NSData *unknownData1;

+ (NSString *)reasonStringWithType:(int)val;
+ (NSString *)decisionStringWithType:(int)val;
+ (NSString *)scopeStringWithType:(int)val;

@end
