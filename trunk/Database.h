//
//  Database.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LangDB.h"
#import "Controller.h"

@interface Database : NSObject {
	unsigned int currentRecord;
	unsigned int totalRecords;
	unsigned int saveEndOffset;
	unsigned int databaseChanges;
	
	int unknownInt1, unknownInt2, unknownInt3, unknownInt4;
	
	NSMutableArray *badAlliterations, *competitions, *nations, *competitionHistories;
	NSMutableArray *goodAlliterations, *personStats, *playerStats, *nonPlayerStats;
	NSMutableArray *awards, *stageNames, *weather, *descriptions, *people;
	NSMutableArray *cities, *stadiums, *stadiumChanges, *teams, *localAreas;
	NSMutableArray *clubs, *firstNames, *surnames, *commonNames, *sponsors;
	NSMutableArray *media, *languages, *currencies, *continents, *injuries;
	NSMutableArray *clubLinks, *unknowns1, *derbies, *agreements;
	
	NSMutableArray *nationStrings, *competitionStrings, *peopleStrings, *cityStrings,
	*clubStrings, *stadiumStrings, *mediaStrings, *cityStringInfos, *clubStringInfos, 
	*competitionStringInfos, *mediaStringInfos, *peopleStringInfos, *stadiumStringInfos,
	*nationStringInfos, *localAreaStringInfos;
	
	NSData *unknownData1, *unknownData2, *unknownData3, *unknownData4, *unknownData5, 
	*unknownData6, *unknownData7;
	NSString *status;
}

- (id)readGameDB:(NSData *)data atOffset:(unsigned int *)byteOffset;
- (void)saveGameDB:(NSMutableData *)data;

@property(copy,readwrite) NSMutableArray *goodAlliterations, *badAlliterations, *awards,
*cities, *clubs, *media, *languages, *currencies, *continents, *injuries, *firstNames, 
*surnames, *commonNames, *sponsors, *stadiums, *stadiumChanges, *teams, *localAreas,
*stageNames, *weather, *descriptions, *people, *personStats, *playerStats, *nonPlayerStats, 
*competitions, *nations, *competitionHistories, *clubLinks, *unknowns1, *derbies, *agreements,
*nationStrings, *competitionStrings, *peopleStrings, *cityStrings, *clubStrings, *stadiumStrings,
*cityStringInfos, *clubStringInfos, *competitionStringInfos, *mediaStringInfos, *peopleStringInfos,
*stadiumStringInfos, *mediaStrings, *nationStringInfos, *localAreaStringInfos;
@property(copy,readwrite) NSString *status;
@property(assign,readwrite) unsigned int currentRecord, totalRecords, saveEndOffset, databaseChanges;
@property(assign,readwrite) int unknownInt1, unknownInt2, unknownInt3, unknownInt4;
@property(readwrite,copy) NSData *unknownData1, *unknownData2, *unknownData3, *unknownData4, *unknownData5, 
*unknownData6, *unknownData7;

- (NSArray *)formationStrings;
- (void)assignDescriptionNames:(NSString *)path;
- (void)assignInjuryNames:(NSString *)path;
- (void)assignContinentNames:(NSString *)path;
- (void)assignAwardNames:(NSString *)path;

- (NSArray *)continentStrings;
- (NSArray *)languageStrings;
- (NSArray *)weatherStrings;

@end
