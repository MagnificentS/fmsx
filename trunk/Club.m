//
//  Club.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Club.h"
#import "SXFGameDB.h"
#import "Team.h"
#import "Database.h"
#import "RegionalDivision.h"

@implementation Club

@synthesize databaseClass, nickname1Gender, nickname2Gender, nationID, nickname1,
nickname2, averageAttendance, minimumAttendance, maximumAttendance, futureTransferManagerID,
hasYouthAcademy, yearFounded, professionalStatus, youthSetup, trainingFacilities, flags,
directors, morale, chairmanID, firstTeamStrengthRating, firstTeamQuicknessRating, 
firstTeamGoalkeepingRating, firstTeamTacticsRating, firstTeamBallControlRating, 
firstTeamDefendingRating, firstTeamAttackingRating, firstTeamShootingRating, 
firstTeamSetPiecesRating, firstTeamStrengthWorkload, firstTeamQuicknessWorkload, 
firstTeamGoalkeepingWorkload, firstTeamTacticsWorkload, firstTeamBallControlWorkload, 
firstTeamDefendingWorkload, firstTeamAttackingWorkload, firstTeamShootingWorkload, 
firstTeamSetPiecesWorkload, youthTeamStrengthRating, youthTeamQuicknessRating, 
youthTeamGoalkeepingRating, youthTeamTacticsRating, youthTeamBallControlRating, 
youthTeamDefendingRating, youthTeamAttackingRating, youthTeamShootingRating, 
youthTeamSetPiecesRating, youthTeamStrengthWorkload, youthTeamQuicknessWorkload, 
youthTeamGoalkeepingWorkload, youthTeamTacticsWorkload, youthTeamBallControlWorkload, 
youthTeamDefendingWorkload, youthTeamAttackingWorkload, youthTeamShootingWorkload, 
youthTeamSetPiecesWorkload, shortlist, IDPCs, sponsors, regionalDivisions, UEFAPoints, 
UEFAMatches, hasUEFACoefficient, scouts, UEFATempCoefficient, UEFA5YearTotal,
coefficients, hasScoutingKnowledges, scoutingKnowledges, seasonTicketHolders,
seasonStartDate, seasonEndDate, preSeasonStartDate, rowID, UID, finance, cityID, 
maximumWeeklyWage, competitionID, allowSponsorshipForTopPlayers, transferOffers, 
teamContainer, isLeagueBodyClub, unknownChar1, roughFinancialState, 
unknownChar2, unknownChar3, unknownChar4, unknownChar5, unknownChar6, unknownChar7, 
unknownChar8, unknownChar9, unknownChar10, unknownChar11, unknownDate1, unknownDate2, logoPath, 
youthAcademy, youthRecruitment, unknownChar12, unknownShort1, unknownShort2,
unknownData1, unknownData2, unknownData3, unknownData4, unknownData5, unknownData6,
newRegionalDivisionLevel;

- (NSArray *)professionalStatusStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Not Set", @"general 'not set' option"),
						NSLocalizedString(@"Professional", @"club professional status"),
						NSLocalizedString(@"Semi-Professional", @"club professional status"),
						NSLocalizedString(@"Amateur", @"club professional status"),
						nil];
	return strings;
}

- (BOOL)isPLC { return (flags & CF_PLC); }
- (BOOL)paysHighWages { return (flags & CF_PAYS_HIGH_WAGES); }
- (BOOL)needsShortlistUpdate { return (flags & CF_NEEDS_SHORTLIST_UPDATE); }

- (void)setIsPLC:(BOOL)val {

}
- (void)setPaysHighWages:(BOOL)val {

}
- (void)setNeedsShortlistUpdate:(BOOL)val {

}

- (NSArray *)directorObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in directors) {
		if ([item intValue] < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] count]) {
			[array addObject:[[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
}

- (NSArray *)scoutObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in scouts) {
		if ([item intValue] < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] count]) {
			[array addObject:[[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
}

- (NSString *)name
{
	return [teamContainer name];
}

- (NSString *)nationString
{
	if (nationID>-1) { return [[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:nationID] teamContainer] name]; }
	return @"---";
}

- (NSString *)competitionString
{
	if ([[teamContainer teams] count]>0) {
		if ([[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:[[[teamContainer teams] objectAtIndex:0] intValue]] divisionID]>-1) {
			return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:[[[teamContainer teams] objectAtIndex:0] intValue]] divisionID]] name];
		}
	}
	return @"---";
}

- (short)reputation
{
	if ([[teamContainer teams] count]>0) {
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:[[[teamContainer teams] objectAtIndex:0] intValue]] reputation];
	}
	return 0;
}

- (void)addRegionalDivision:(Competition *)object
{
	if ([object respondsToSelector:NSSelectorFromString(@"UID")]) {
		RegionalDivision *newDivision = [[RegionalDivision alloc] init];
		[newDivision setDivisionID:[object UID]];
		[newDivision setLevel:newRegionalDivisionLevel];
		if (![regionalDivisions containsObject:newDivision]) {
			[[self mutableArrayValueForKey:@"regionalDivisions"] addObject:newDivision];
		}
		[newDivision release];
	}
}

@end
