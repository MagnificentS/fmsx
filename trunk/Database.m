//
//  Database.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Database.h"
#import "Loader.h"
#import "AlliterationLoader.h"
#import "AlliterationSaver.h"
#import "AgreementLoader.h"
#import "AgreementSaver.h"
#import "AwardLoader.h"
#import "AwardSaver.h"
#import "CityLoader.h"
#import "CitySaver.h"
#import "ClubLoader.h"
#import "ClubSaver.h"
#import "ClubLinkLoader.h"
#import "ClubLinkSaver.h"
#import "CompetitionLoader.h"
#import "CompetitionSaver.h"
#import "CompetitionHistoryLoader.h"
#import "CompetitionHistorySaver.h"
#import "ContinentLoader.h"
#import "ContinentSaver.h"
#import "CurrencyLoader.h"
#import "CurrencySaver.h"
#import "DerbyLoader.h"
#import "DerbySaver.h"
#import "DescriptionLoader.h"
#import "DescriptionSaver.h"
#import "GeneralInfoLoader.h"
#import "InjuryLoader.h"
#import "InjurySaver.h"
#import	"LangDBLoader.h"
#import "LanguageLoader.h"
#import "LanguageSaver.h"
#import "LocalAreaLoader.h"
#import "LocalAreaSaver.h"
#import "MediaLoader.h"
#import "MediaSaver.h"
#import "NameLoader.h"
#import "NameSaver.h"
#import "NationLoader.h"
#import "NationSaver.h"
#import "PersonLoader.h"
#import "PersonSaver.h"
#import "PersonStatsLoader.h"
#import "PersonStatsSaver.h"
#import "PlayerStatsLoader.h"
#import "PlayerStatsSaver.h"
#import "NonPlayerStatsLoader.h"
#import "NonPlayerStatsSaver.h"
#import "SponsorLoader.h"
#import "SponsorSaver.h"
#import "FootballStadiumLoader.h"
#import "FootballStadiumSaver.h"
#import "StadiumChangeLoader.h"
#import "StadiumChangeSaver.h"
#import "StageNameLoader.h"
#import "StageNameSaver.h"
#import "TeamLoader.h"
#import "TeamSaver.h"
#import "Unknown7Loader.h"
#import "Unknown7Saver.h"
#import "WeatherLoader.h"
#import "WeatherSaver.h"
#import "Person.h"

@implementation Database

@synthesize goodAlliterations, badAlliterations, awards, cities, currentRecord, 
totalRecords, status, clubs, media, languages, currencies, continents,
injuries, firstNames, surnames, commonNames, sponsors, stadiums, stadiumChanges,
teams, localAreas, stageNames, weather, descriptions, people, personStats, playerStats,
nonPlayerStats, competitions, nations, langDBLoaded, competitionHistories,
clubLinks, saveEndOffset, unknowns1, derbies, agreements, databaseChanges, unknownData1,
unknownData2, unknownData3, unknownData4, unknownData5, unknownData6, unknownData7,
unknownInt1, unknownInt2, unknownInt3, unknownInt4, nationStrings, competitionStrings;

- (id)init
{
	[super init];
	
	[[NSApp delegate] setStatusValue:0];
	[[NSApp delegate] setStatusMaxValue:1];
	
	goodAlliterations = [[NSMutableArray alloc] init];
	badAlliterations = [[NSMutableArray alloc] init];
	agreements = [[NSMutableArray alloc] init];
	awards = [[NSMutableArray alloc] init];
	cities = [[NSMutableArray alloc] init];
	clubs = [[NSMutableArray alloc] init];
	clubLinks = [[NSMutableArray alloc] init];
	commonNames = [[NSMutableArray alloc] init];
	competitions = [[NSMutableArray alloc] init];
	competitionHistories = [[NSMutableArray alloc] init];
	continents = [[NSMutableArray alloc] init];
	currencies = [[NSMutableArray alloc] init];
	derbies = [[NSMutableArray alloc] init];
	descriptions = [[NSMutableArray alloc] init];
	injuries = [[NSMutableArray alloc] init];
	firstNames = [[NSMutableArray alloc] init];
	languages = [[NSMutableArray alloc] init];
	localAreas = [[NSMutableArray alloc] init];
	media = [[NSMutableArray alloc] init];
	nations = [[NSMutableArray alloc] init];
	nonPlayerStats = [[NSMutableArray alloc] init];
	people = [[NSMutableArray alloc] init];
	personStats = [[NSMutableArray alloc] init];
	playerStats = [[NSMutableArray alloc] init];
	sponsors = [[NSMutableArray alloc] init];
	stadiums = [[NSMutableArray alloc] init];
	stadiumChanges = [[NSMutableArray alloc] init];
	stageNames = [[NSMutableArray alloc] init];
	surnames = [[NSMutableArray alloc] init];
	teams = [[NSMutableArray alloc] init];
	unknowns1 = [[NSMutableArray alloc] init];
	weather = [[NSMutableArray alloc] init];
	
	nationStrings = [[NSMutableArray alloc] init];
	competitionStrings = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)dealloc
{
	[goodAlliterations release];
	[badAlliterations release];
	[agreements release];
	[awards release];
	[cities release];
	[clubs release];
	[clubLinks release];
	[commonNames release];
	[competitions release];
	[competitionHistories release];
	[continents release];
	[currencies release];
	[derbies release];
	[descriptions release];
	[injuries release];
	[firstNames release];
	[languages release];
	[localAreas release];
	[media release];
	[nations release];
	[nonPlayerStats release];
	[people release];
	[personStats release];
	[playerStats release];
	[sponsors release];
	[stadiums release];
	[stadiumChanges release];
	[stageNames release];
	[surnames release];
	[teams release];
	[unknowns1 release];
	[weather release];
	
	[nationStrings release];
	[competitionStrings release];
	
	[super dealloc];
}

- (id)readGameDB:(NSData *)data atOffset:(unsigned int *)byteOffset
{
	NSAutoreleasePool *pool;
	
	unsigned int i, count, startingOffset;
	
#pragma mark Alliterations
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading good alliterations...", @"editor status")];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (int i=0; i<count; i++) {
		startingOffset = *byteOffset;
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readAlliterationFromData:data atOffset:byteOffset];
		if ([[object className] isEqualToString:@"Alliteration"]) {
			[goodAlliterations addObject:object];
		}
		else { return [NSArray arrayWithObjects:
						@"Good Alliteration",
						[NSString stringWithFormat:@"%d",i],				// entity
						[NSString stringWithFormat:@"%d",startingOffset],	// entity start
						[NSString stringWithFormat:@"%@",object],			// entity error
						nil];			
		}
	}
	NSLog(@"End of %d good alliterations at %d",[goodAlliterations count],*byteOffset);

	[[NSApp delegate] setStatus:NSLocalizedString(@"loading bad alliterations...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readAlliterationFromData:data atOffset:byteOffset];
		if ([[object className] isEqualToString:@"Alliteration"]) {
			[badAlliterations addObject:object];
		}
		else { return [NSArray arrayWithObjects:
					   @"Bad Alliteration",
					   [NSString stringWithFormat:@"%d",i],				// entity
					   [NSString stringWithFormat:@"%d",startingOffset],	// entity start
					   [NSString stringWithFormat:@"%@",object],			// entity error
					   nil]; }
	}
	NSLog(@"End of %d bad alliterations at %d",[badAlliterations count],*byteOffset);
	[pool drain];
	
	// 0x01 ???
	*byteOffset += 1;
	
#pragma mark Awards
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading awards...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readAwardFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Award"]) {
			return [NSArray arrayWithObjects:
					@"Award",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Award",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			[awards addObject:object]; 
		}
//		NSLog(@"Award %d (%d) done at %d",i,[object UID],*byteOffset);
	}
	NSLog(@"End of %d awards at %d",[awards count],*byteOffset);

	NSThread *awardThread = [[NSThread alloc] initWithTarget:self selector:@selector(assignAwardNames:) object:nil];
	[awardThread start];
	[awardThread release];
	
	[pool drain];
	
#pragma mark Cities
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading cities...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readCityFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"City"]) {
			return [NSArray arrayWithObjects:
					@"City",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"City",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) {
				id item = [[[[NSApp delegate] langDB] cityLang] objectForKey:[NSNumber numberWithInt:[object UID]]];
				if (item!=nil) {
					[(City *)object setName:[item objectForKey:@"name"]];
				}
			}
			[cities addObject:object];
		}
	}
	NSLog(@"End of %d cities at %d",[cities count],*byteOffset);
	
	[pool drain];
	
#pragma mark Clubs
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading clubs...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readClubFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Club"]) {
			return [NSArray arrayWithObjects:
					@"Club",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Club",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
		//	[object setLogoPath:[[graphics clubLogos] objectForKey:[NSNumber numberWithInt:[object UID]]]];
			[clubs addObject:object];
		}
	}
	NSLog(@"End of %d clubs at %d",[clubs count],*byteOffset);
	
	[pool drain];
	
#pragma mark Competitions
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading competitions...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readCompetitionFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Competition"]) {
			return [NSArray arrayWithObjects:
					@"Competition",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Competition",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) {
				id item = [[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:[object UID]]];
				if (item!=nil) {
					[(Competition *)object setName:[item objectForKey:@"name"]];
					[object setShortName:[item objectForKey:@"shortName"]];
					[object setThreeLetterName:[item objectForKey:@"threeLetterName"]];
				}
			}
			[competitions addObject:object];
		}
	}
	NSLog(@"End of %d competitions at %d",[competitions count],*byteOffset);
	
	[pool drain];
	
#pragma mark Continents
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading continents...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readContinentFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Continent"]) {
			return [NSArray arrayWithObjects:
					@"Continent",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Continent",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [continents addObject:object]; }
	}
	NSLog(@"End of %d continents at %d",[continents count],*byteOffset);
	
	NSThread *continentThread = [[NSThread alloc] initWithTarget:self selector:@selector(assignContinentNames:) object:nil];
	[continentThread start];
	[continentThread release];
	
	[pool drain];
	
#pragma mark Currencies
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading currencies...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readCurrencyFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Currency"]) {
			return [NSArray arrayWithObjects:
					@"Currency",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Currency",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [currencies addObject:object]; }
		
	}
	NSLog(@"End of %d currencies at %d",[currencies count],*byteOffset);
	
	[pool drain];
	
#pragma mark Injuries
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading injuries...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readInjuryFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Injury"]) {
			return [NSArray arrayWithObjects:
					@"Injury",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Injury",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [injuries addObject:object]; }
		
	}
	NSLog(@"End of %d injuries at %d",[injuries count],*byteOffset);
	
	NSThread *injuryThread = [[NSThread alloc] initWithTarget:self selector:@selector(assignInjuryNames:) object:nil];
	[injuryThread start];
	[injuryThread release];
	
	[pool drain];
	
#pragma mark Media
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading media...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readMediaFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Media"]) {
			return [NSArray arrayWithObjects:
					@"Media",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Media",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [media addObject:object]; }
	}
	NSLog(@"End of %d media at %d",[media count],*byteOffset);
	
	[pool drain];
	
#pragma mark Languages
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading languages...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readLanguageFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Language"]) {
			return [NSArray arrayWithObjects:
					@"Language",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Language",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [languages addObject:object]; }
	
	}
	NSLog(@"End of %d languages at %d",[languages count],*byteOffset);
	
	[pool drain];
	
#pragma mark Nations
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading nations...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readNationFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Nation"]) {
			return [NSArray arrayWithObjects:
					@"Nation",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Nation",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			[nations addObject:object];
		}
	}
	NSLog(@"End of %d nations at %d",[nations count],*byteOffset);
	
	[pool drain];
	
#pragma mark First Names
	
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading first names...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readNameFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Name"]) {
			return [NSArray arrayWithObjects:
					@"First Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"First Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [firstNames addObject:object]; }
		
	}
	NSLog(@"End of %d first names at %d",[firstNames count],*byteOffset);	
	[pool drain];
		
#pragma mark Surnames
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading surnames...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readNameFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Name"]) {
			return [NSArray arrayWithObjects:
					@"Surname",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Surname",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [surnames addObject:object]; }
	}
	NSLog(@"End of %d surnames at %d",[surnames count],*byteOffset);
	
	[pool drain];
	
#pragma mark Common Names
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading common names...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readNameFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Name"]) {
			return [NSArray arrayWithObjects:
					@"Common Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Common Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [commonNames addObject:object]; }
	}
	NSLog(@"End of %d common names at %d",[commonNames count],*byteOffset);	
	
	[pool drain];
	
#pragma mark Unknowns 1
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading unknowns 1...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readUnknown7FromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Unknown7"]) {
			return [NSArray arrayWithObjects:
					@"Unknown 1",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Unknown 1",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [unknowns1 addObject:object]; }
	}
	NSLog(@"End of %d unknowns 1 at %d", count, *byteOffset);
	
	[pool drain];
	
#pragma mark Local Areas
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading local areas...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readLocalAreaFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"LocalArea"]) {
			return [NSArray arrayWithObjects:
					@"Local Area",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Local Area",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) {
				id item = [[[[NSApp delegate] langDB] localAreaLang] objectForKey:[NSNumber numberWithInt:[object UID]]];
				if (item!=nil) {
					[(LocalArea *)object setName:[item objectForKey:@"name"]];
					[object setShortName:[item objectForKey:@"shortName"]];
				}
			}
			[localAreas addObject:object];
		}
	}
	NSLog(@"End of %d local areas at %d",[localAreas count],*byteOffset);	
	
	[pool drain];
	
#pragma mark Sponsors
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading sponsors...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readSponsorFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Sponsor"]) {
			return [NSArray arrayWithObjects:
					@"Sponsor",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Sponsor",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [sponsors addObject:object]; }
	}
	NSLog(@"End of %d sponsors at %d",[sponsors count],*byteOffset);
	
	[pool drain];
	
#pragma mark Stadiums
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading stadiums...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readStadiumFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Stadium"]) {
			return [NSArray arrayWithObjects:
					@"Stadium",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Stadium",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) {
				id item = [[[[NSApp delegate] langDB] stadiumLang] objectForKey:[NSNumber numberWithInt:[object UID]]];
				if (item!=nil) {
					[(Stadium *)object setName:[item objectForKey:@"name"]];
				}
			}
			[stadiums addObject:object];
		}
	}
	NSLog(@"End of %d stadiums at %d",[stadiums count],*byteOffset);
	
	[pool drain];
	
#pragma mark Stadium Changes
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading stadium changes...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readStadiumChangeFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"StadiumChange"]) {
			return [NSArray arrayWithObjects:
					@"Stadium Change",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
//		else if ([object rowID]!=i) {
//			NSLog(@"%d",[object rowID]);
//			return [NSArray arrayWithObjects:
//					@"Stadium Change",
//					[NSString stringWithFormat:@"%d",i],				// entity
//					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
//					@"Invalid ID",										// entity error
//					nil]; 
//		}
		else { [stadiumChanges addObject:object]; }
	}
	NSLog(@"End of %d stadium changes at %d",[stadiumChanges count],*byteOffset);	
	
	[pool drain];
	
#pragma mark Stage Names
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading stage names...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readStageNameFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"StageName"]) {
			return [NSArray arrayWithObjects:
					@"Stage Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Stage Name",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [stageNames addObject:object]; }
	}
	
	NSLog(@"End of %d stage names at %d",[stageNames count],*byteOffset);	
	
	NSThread *stageNameThread = [[NSThread alloc] initWithTarget:self selector:@selector(assignStageNames:) object:nil];
	[stageNameThread start];
	[stageNameThread release];
	
	[pool drain];
	
#pragma mark Teams
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading teams...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readTeamFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Team"]) {
			return [NSArray arrayWithObjects:
					@"Team",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Team",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			[teams addObject:object];
		}
	}
	NSLog(@"End of %d teams at %d",[teams count],*byteOffset);
	
	[pool drain];
	
#pragma mark Weather
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading weather...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readWeatherFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Weather"]) {
			return [NSArray arrayWithObjects:
					@"Weather",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Weather",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [weather addObject:object]; }
	}
	NSLog(@"End of %d weather at %d",[weather count],*byteOffset);
	
	[pool drain];
	
#pragma mark Descriptions
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading descriptions...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readDescriptionFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Description"]) {
			return [NSArray arrayWithObjects:
					@"Description",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Description",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [descriptions addObject:object]; }
	}
	
	NSLog(@"End of %d descriptions at %d",[descriptions count],*byteOffset);	
	
	NSThread *descriptionThread = [[NSThread alloc] initWithTarget:self selector:@selector(assignDescriptionNames:) object:nil];
	[descriptionThread start];
	[descriptionThread release];
	
	[pool drain];
	
#pragma mark Derbies
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading derbies...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readDerbyFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Derby"]) {
			return [NSArray arrayWithObjects:
					@"Derby",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Derby",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [derbies addObject:object]; }
	}
	NSLog(@"End of %d derbies at %d",[derbies count],*byteOffset);	
	
	[pool drain];

#pragma mark Agreements
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading agreements...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		id object = [Loader readAgreementFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"Agreement"]) {
			return [NSArray arrayWithObjects:
					@"Agreement",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Agreement",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) {
				id item = [[[[NSApp delegate] langDB] agreementLang] objectForKey:[NSNumber numberWithInt:[object UID]]];
				if (item!=nil) {
					[(Agreement *)object setName:[item objectForKey:@"name"]];
					[object setShortName:[item objectForKey:@"shortName"]];
					[object setAlternativeName:[item objectForKey:@"alternativeName"]];
					[object setAlternativeShortName:[item objectForKey:@"alternativeShortName"]];
				}
			}
			NSLog(@"%d - %@",[object UID],[object name]);
			[agreements addObject:object]; 
		}
	}
	NSLog(@"End of %d agreements at %d",[agreements count],*byteOffset);	
	
	[pool drain];
	
	
#pragma mark People
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading people...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	NSLog(@"%d people",count);
	[[NSApp delegate] setStatusMaxValue:count];
	
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readPersonFromData:data atOffset:byteOffset];
		
		if (![[object className] isEqualToString:@"Person"]) {
			return [NSArray arrayWithObjects:
					@"Person",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Person",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { 
			[people addObject:object]; 
		}
		
	//	NSLog(@"person %d - %d at %d ( %@ )",i,[object UID],*byteOffset,[object name]);
	}
	NSLog(@"End of %d people at %d",[people count],*byteOffset);
	
	[pool drain];
	
#pragma mark Person Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading person stats...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readPersonStatsFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"PersonStats"]) {
			return [NSArray arrayWithObjects:
					@"Person Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Person Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [personStats addObject:object]; }
	}
	NSLog(@"End of %d person stats at %d",[personStats count],*byteOffset);
	
	[pool drain];
	
#pragma mark Player Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading player stats...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readPlayerStatsFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"PlayerStats"]) {
			return [NSArray arrayWithObjects:
					@"Player Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Player Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [playerStats addObject:object]; }
	}
	NSLog(@"End of %d player stats at %d",[playerStats count],*byteOffset);
	
	[pool drain];
	
#pragma mark Non-Player Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading non-player stats...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readNonPlayerStatsFromData:data atOffset:byteOffset];
		if (![[object className] isEqualToString:@"NonPlayerStats"]) {
			return [NSArray arrayWithObjects:
					@"Non-Player Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Non-Player Stats",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [nonPlayerStats addObject:object]; }
	}
	NSLog(@"End of %d non-player stats at %d",[nonPlayerStats count],*byteOffset);
	
	[pool drain];

#pragma mark Latest Competition Histories
	
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading competition histories...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		
		id object = [Loader readCompetitionHistoryFromData:data atOffset:byteOffset archived:NO];
		if (![[object className] isEqualToString:@"CompetitionHistory"]) {
			return [NSArray arrayWithObjects:
					@"Competition History",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					[NSString stringWithFormat:@"%@",object],			// entity error
					nil]; 
		}
		else if ([object rowID]!=i) {
			return [NSArray arrayWithObjects:
					@"Competition History",
					[NSString stringWithFormat:@"%d",i],				// entity
					[NSString stringWithFormat:@"%d",startingOffset],	// entity start
					@"Invalid ID",										// entity error
					nil]; 
		}
		else { [competitionHistories addObject:object]; }
	}
	NSLog(@"End of %d competition histories at %d",[competitionHistories count],*byteOffset);
	
	// ???
	[self setUnknownData1:[data subdataWithRange:NSMakeRange(*byteOffset, 76)]]; 
	*byteOffset += 76;
	
	// ???
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[self setUnknownInt1:count];
	[self setUnknownData2:[data subdataWithRange:NSMakeRange(*byteOffset, (count*8))]]; 
	*byteOffset += (count*8);
	/*
	for (i=0; i<count; i++) {
		// int
		// int (counting - 0,1,2,3,4, etc)
		*byteOffset += 8;
	}
	*/
	NSLog(@"End of post-unknowns 1 (%d) at %d",count,*byteOffset);
	
	// ???
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[self setUnknownInt2:count];
	[self setUnknownData3:[data subdataWithRange:NSMakeRange(*byteOffset, (count*8))]]; 
	*byteOffset += (count*8);
	/*
	for (i=0; i<count; i++) {
		// int
		// int (counting - 0,1,2,3,4, etc)
		*byteOffset += 8;
	}
	*/
	NSLog(@"End of post-unknowns 2 (%d) at %d",count,*byteOffset);
	
	// ???
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[self setUnknownInt3:count];
	[self setUnknownData4:[data subdataWithRange:NSMakeRange(*byteOffset, (count*9))]]; 
	*byteOffset += (count*9);
	/*
	 for (i=0; i<count; i++) {
		*byteOffset += 9;
	}
	*/
	NSLog(@"End of post-unknowns 3 (%d) at %d",count,*byteOffset);
	
	// ???
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[self setUnknownInt4:count];
	[self setUnknownData5:[data subdataWithRange:NSMakeRange(*byteOffset, (count*10))]]; 
	*byteOffset += (count*10);
	/*
	 for (i=0; i<count; i++) {
		*byteOffset += 10;
	}
	*/
	NSLog(@"End of post-unknowns 4 (%d) at %d",count,*byteOffset);
	
	[self setUnknownData6:[data subdataWithRange:NSMakeRange(*byteOffset, 4)]]; 
	*byteOffset += 4;
	
#pragma mark Club Links
	
	[[NSApp delegate] setStatus:NSLocalizedString(@"loading club links...", @"editor status")];
	[[NSApp delegate] setStatusValue:0];
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[[NSApp delegate] setStatusMaxValue:count];
	for (i=0; i<count; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[clubLinks addObject:[Loader readClubLinkFromData:data atOffset:byteOffset]];
	}
	NSLog(@"End of %d club links at %d",[clubLinks count],*byteOffset);
	
	saveEndOffset = *byteOffset;
	
	// 0x04	FF FF FF FF
	[self setUnknownData7:[data subdataWithRange:NSMakeRange(*byteOffset, 4)]]; 
	*byteOffset += 4;
	
#pragma mark DB Changes
	[data getBytes:&count range:NSMakeRange(*byteOffset, 4)]; *byteOffset += 4;
	[self setDatabaseChanges:count];
	for (int i=0;i<count;i++) {
		[GeneralInfoLoader readFromData:data atOffset:byteOffset readInfo:NO];
	}
	NSLog(@"End of %d db changes at %d",count,*byteOffset);

/**************************************/
/******** END OF GAME_DB.DAT **********/
/**************************************/
	
	[[NSApp delegate] setStatus:NSLocalizedString(@"assigning Person Stats...", @"editor status")];
	for (id item in people) {
		if ([item personData] && [[item personData] personStatsID] > -1) {
			[item setPersonStats:[personStats objectAtIndex:[[item personData] personStatsID]]];
		}
		if ([item playerData] && [[item playerData] playerStatsID] > -1) {
			[item setPlayerStats:[playerStats objectAtIndex:[[item playerData] playerStatsID]]];
		}
		if ([item nonPlayerData] && [[item nonPlayerData] nonPlayingStatsID] > -1) {
			[item setNonPlayerStats:[nonPlayerStats objectAtIndex:[[item nonPlayerData] nonPlayingStatsID]]];
		}
	}
	
	return NULL;
}

- (void)saveGameDB:(NSMutableData *)data
{
	int ibuffer;
	
#pragma mark Alliterations
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving good alliterations...", @"editor status")];
	ibuffer = [goodAlliterations count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[AlliterationSaver saveAlliteration:[goodAlliterations objectAtIndex:i] toData:data];
	}
	
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving bad alliterations...", @"editor status")];
	ibuffer = [badAlliterations count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[AlliterationSaver saveAlliteration:[badAlliterations objectAtIndex:i] toData:data];
	}
	
	// unknown byte always seems to be 0
	[data increaseLengthBy:1];
	
	[pool drain];
	
#pragma mark Awards
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving awards...", @"editor status")];
	ibuffer = [awards count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[AwardSaver saveAward:[awards objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Cities
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving cities...", @"editor status")];
	ibuffer = [cities count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[CitySaver saveCity:[cities objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Clubs
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving clubs...", @"editor status")];
	ibuffer = [clubs count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[ClubSaver saveClub:[clubs objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Competitions
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving competitions...", @"editor status")];
	ibuffer = [competitions count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[CompetitionSaver saveCompetition:[competitions objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Continents
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving continents...", @"editor status")];
	ibuffer = [continents count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[ContinentSaver saveContinent:[continents objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Currencies
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving currencies...", @"editor status")];
	ibuffer = [currencies count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[CurrencySaver saveCurrency:[currencies objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Injuries
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving injuries...", @"editor status")];
	ibuffer = [injuries count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[InjurySaver saveInjury:[injuries objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark Media
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving media...", @"editor status")];
	ibuffer = [media count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[MediaSaver saveMedia:[media objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark Languages
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving languages...", @"editor status")];
	ibuffer = [languages count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[LanguageSaver saveLanguage:[languages objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Nations
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving nations...", @"editor status")];
	ibuffer = [nations count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[NationSaver saveNation:[nations objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark First Names
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving first names...", @"editor status")];
	ibuffer = [firstNames count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[NameSaver saveName:[firstNames objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Surnames
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving surnames...", @"editor status")];
	ibuffer = [surnames count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[NameSaver saveName:[surnames objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Common Names
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving common names...", @"editor status")];
	ibuffer = [commonNames count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[NameSaver saveName:[commonNames objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Unknowns 1
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving unknowns 1...", @"editor status")];
	ibuffer = [unknowns1 count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[Unknown7Saver saveUnknown:[unknowns1 objectAtIndex:i] toData:data];
	}
	[pool drain];	

#pragma mark Local Areas
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving local areas...", @"editor status")];
	ibuffer = [localAreas count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[LocalAreaSaver saveArea:[localAreas objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Sponsors
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving sponsors...", @"editor status")];
	ibuffer = [sponsors count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[SponsorSaver saveSponsor:[sponsors objectAtIndex:i] toData:data];
	}
	[pool drain];	

#pragma mark Stadiums
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving stadiums...", @"editor status")];
	ibuffer = [stadiums count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[FootballStadiumSaver saveStadium:[stadiums objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Stadium Changes
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving stadium changes...", @"editor status")];
	ibuffer = [stadiumChanges count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[StadiumChangeSaver saveStadiumChange:[stadiumChanges objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Stage Names
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving stage names...", @"editor status")];
	ibuffer = [stageNames count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[StageNameSaver saveStageName:[stageNames objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Teams
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving teams...", @"editor status")];
	ibuffer = [teams count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[TeamSaver saveTeam:[teams objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Weather
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving weather...", @"editor status")];
	ibuffer = [weather count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[WeatherSaver saveWeather:[weather objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark Descriptions
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving descriptions...", @"editor status")];
	ibuffer = [descriptions count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[DescriptionSaver saveDescription:[descriptions objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Derbies
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving derbies...", @"editor status")];
	ibuffer = [derbies count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[DerbySaver saveDerby:[derbies objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark Agreements
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving agreements...", @"editor status")];
	ibuffer = [agreements count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[AgreementSaver saveAgreement:[agreements objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark People
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving people...", @"editor status")];
	ibuffer = [people count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[PersonSaver savePerson:[people objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Person Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving person stats...", @"editor status")];
	ibuffer = [personStats count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[PersonStatsSaver saveStats:[personStats objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Player Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving playing stats...", @"editor status")];
	ibuffer = [playerStats count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[PlayerStatsSaver saveStats:[playerStats objectAtIndex:i] toData:data];
	}
	[pool drain];
	
#pragma mark Non-Player Stats
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving non-player stats...", @"editor status")];
	ibuffer = [nonPlayerStats count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[NonPlayerStatsSaver saveStats:[nonPlayerStats objectAtIndex:i] toData:data];
	}
	[pool drain];

#pragma mark Competition Histories
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving competition histories...", @"editor status")];
	ibuffer = [competitionHistories count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[CompetitionHistorySaver saveCompetitionHistory:[competitionHistories objectAtIndex:i] toData:data archived:NO];
	}
	[pool drain];

#pragma mark Unknowns
	[data appendData:unknownData1];
	[data appendBytes:&unknownInt1 length:4];
	[data appendData:unknownData2];
	[data appendBytes:&unknownInt2 length:4];
	[data appendData:unknownData3];
	[data appendBytes:&unknownInt3 length:4];
	[data appendData:unknownData4];
	[data appendBytes:&unknownInt4 length:4];
	[data appendData:unknownData5];
	[data appendData:unknownData6];

#pragma mark Club Links
	pool = [[NSAutoreleasePool alloc] init];
	[[NSApp delegate] setStatus:NSLocalizedString(@"saving club links...", @"editor status")];
	ibuffer = [clubLinks count];
	[data appendBytes:&ibuffer length:4];
	[[NSApp delegate] setStatusMaxValue:ibuffer];
	for (int i=0; i<ibuffer; i++) {
		[[NSApp delegate] setStatusValue:(i+1)];
		[ClubLinkSaver saveClubLink:[clubLinks objectAtIndex:i] toData:data];
	}
	[pool drain];
}

- (void)assignAwardNames:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	unsigned int i = 0;
	for (id item in awards)
	{
		id object = [[[[NSApp delegate] langDB] awardLang] objectForKey:[NSNumber numberWithInt:[item UID]]];
		if (object!=nil) {
			Award *aAward = [[self awards] objectAtIndex:i];
			[aAward setName:[object objectForKey:@"name"]];
			[aAward setShortName:[object objectForKey:@"shortName"]];
		}
		i++;
	}
	NSLog(@"LangDB Names (awards) assigned");
	
	[pool drain];
}

- (void)assignContinentNames:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	unsigned int i = 0;
	for (id item in continents) {
		id item2 = [[[[NSApp delegate] langDB] continentLang] objectForKey:[NSNumber numberWithInt:[item UID]]];
		if (item2!=nil) {
			Continent *object = [[self continents] objectAtIndex:i];
			[object setName:[item2 objectForKey:@"name"]];
			[object setThreeLetterName:[item2 objectForKey:@"threeLetterName"]];
			[object setContinentialityName:[item2 objectForKey:@"continentialityName"]];
			[object setFederationName:[item2 objectForKey:@"federationName"]];
			[object setFederationShortName:[item2 objectForKey:@"federationShortName"]];
		}
		i++;
	}
	NSLog(@"LangDB Names (continents) assigned");
	
	[pool drain];
}

- (void)assignInjuryNames:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	unsigned int i = 0;
	for (id item in injuries) {
		id item2 = [[[[NSApp delegate] langDB] injuryLang] objectForKey:[NSNumber numberWithInt:[item UID]]];
		if (item2!=nil) {
			Injury *object = [[self injuries] objectAtIndex:i];
			[object setName:[item2 objectForKey:@"name"]];
			[object setSentenceName:[item2 objectForKey:@"sentenceName"]];
		}
		i++;
	}
	NSLog(@"LangDB Names (injuries) assigned");
	
	[pool drain];
}

- (void)assignDescriptionNames:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	unsigned int i = 0;
	for (id item in descriptions) {
		id item2 = [[[[NSApp delegate] langDB] descriptionLang] objectForKey:[NSNumber numberWithInt:[item UID]]];
		if (item2!=nil) {
			Description *object = [[self descriptions] objectAtIndex:i];
			[object setNames:[item2 objectForKey:@"names"]];
		}
		i++;
	}
	NSLog(@"LangDB Names (descriptions) assigned");
	
	[pool drain];
}

- (void)assignStageNames:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	unsigned int i = 0;
	for (id item in stageNames) {
		id item2 = [[[[NSApp delegate] langDB] stageNameLang] objectForKey:[NSNumber numberWithInt:[item UID]]];
		if (item2!=nil) {
			StageName *object = [[self stageNames] objectAtIndex:i];
			[object setName:[item2 objectForKey:@"name"]];
			[object setShortName:[item2 objectForKey:@"shortName"]];
			[object setPluralName:[item2 objectForKey:@"pluralName"]];
		}
		i++;
	}
	NSLog(@"LangDB Names (stage names) assigned");
	
	[pool drain];
}

- (NSArray *)formationStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Not Set", @"general 'not set' option"),
						NSLocalizedString(@"5-3-2 Sweeper", @"formation"),
						NSLocalizedString(@"5-3-2", @"formation"),
						NSLocalizedString(@"4-4-2", @"formation"),
						NSLocalizedString(@"4-3-3", @"formation"),
						NSLocalizedString(@"4-2-4", @"formation"),
						NSLocalizedString(@"3-5-2", @"formation"),
						NSLocalizedString(@"4-1-2-1-2", @"formation"),
						NSLocalizedString(@"4-5-1", @"formation"),
						NSLocalizedString(@"3-4-3", @"formation"),
						NSLocalizedString(@"3-4-1-2", @"formation"),
						NSLocalizedString(@"3-4-2-1", @"formation"),
						NSLocalizedString(@"4-3-2-1", @"formation"),
						NSLocalizedString(@"3-5-2 Sweeper", @"formation"),
						NSLocalizedString(@"4-3-1-2", @"formation"),
						NSLocalizedString(@"5-4-1", @"formation"),
						NSLocalizedString(@"4-4-1-1", @"formation"),
						NSLocalizedString(@"4-4-2 Sweeper", @"formation"),
						NSLocalizedString(@"4-2-3-1", @"formation"),
						NSLocalizedString(@"4-1-3-1-1", @"formation"),
						NSLocalizedString(@"4-1-3-2", @"formation"),
						NSLocalizedString(@"4-2-3-1 Denmark", @"formation"),
						NSLocalizedString(@"4-4-2 Defensive Midfielder", @"formation"),
						NSLocalizedString(@"4-5-1 Defensive Midfielder", @"formation"),
						NSLocalizedString(@"4-2-2-2", @"formation"),
						NSLocalizedString(@"4-4-2 Diamond", @"formation"),
						NSLocalizedString(@"3-1-3-1-2", @"formation"),
						NSLocalizedString(@"4-1-2-3 Attacking", @"formation"),
						NSLocalizedString(@"4-1-2-2-1", @"formation"),
						NSLocalizedString(@"4-2-2-2 Defensive Midfielder", @"formation"),
						NSLocalizedString(@"4-2-3-1 Defensive Midfielder", @"formation"),
						NSLocalizedString(@"5-3-2 Serbia & Montenegro", @"formation"),
						NSLocalizedString(@"3-6-1", @"formation"),
						NSLocalizedString(@"Unknown 1", @"formation"),
						NSLocalizedString(@"Unknown 2", @"formation"),
						NSLocalizedString(@"Unknown 3", @"formation"),
						nil];
	return strings;
}

- (NSArray *)clubStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (Club *item in clubs) { [strings addObject:[[item teamContainer] name]]; }
	
	return [strings autorelease];
}
- (NSArray *)clubStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Club *item in clubs) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[item teamContainer] name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",[NSNumber numberWithInt:[item UID]],@"UID",nil]]; 
	}
	
	return [stringInfos autorelease];
}


- (NSArray *)localAreaStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (LocalArea *item in localAreas) { [strings addObject:[item name]]; }
	
	return [strings autorelease];
}
- (NSArray *)weatherStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (Weather *item in weather) { [strings addObject:[item name]]; }
	
	return [strings autorelease];
}
- (NSArray *)languageStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (Language *item in languages) { [strings addObject:[item name]]; }
	
	return [strings autorelease];
}


- (NSArray *)continentStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (Continent *item in continents) { [strings addObject:[item name]]; }
	
	return [strings autorelease];
}

- (NSArray *)competitionStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	
	for (Competition *item in competitions) { [strings addObject:[item name]]; }
	
	return [strings autorelease];
}

- (NSArray *)competitionStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Competition *item in competitions) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[item name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}

- (NSArray *)nationStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	for (Nation *item in nations) { [strings addObject:[[item teamContainer] name]]; }
	return [strings autorelease];
}

- (NSArray *)nationStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Nation *item in nations) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[[item teamContainer] name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}

- (NSArray *)mediaStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	for (Media *item in media) { [strings addObject:[item name]]; }
	return [strings autorelease];
}
- (NSArray *)mediaStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Media *item in media) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[item name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}
- (NSArray *)stadiumStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	for (Stadium *item in stadiums) { [strings addObject:[item name]]; }
	return [strings autorelease];
}
- (NSArray *)stadiumStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Stadium *item in stadiums) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[item name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}
- (NSArray *)cityStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	for (City *item in cities) { [strings addObject:[item name]]; }
	return [strings autorelease];
}
- (NSArray *)cityStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (City *item in cities) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[item name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}
- (NSArray *)peopleStrings
{
	NSMutableArray *strings = [[NSMutableArray alloc] init];
	for (Person *item in people) { [strings addObject:[item name]]; }
	return [strings autorelease];
}
- (NSArray *)peopleStringInfos
{
	NSMutableArray *stringInfos = [[NSMutableArray alloc] init];
	
	for (Person *item in people) { 
		[stringInfos addObject:[NSDictionary dictionaryWithObjectsAndKeys:[item name],@"name",[NSNumber numberWithInt:[item rowID]],@"rowID",nil]]; 
	}
	
	return [stringInfos autorelease];
}

@end
