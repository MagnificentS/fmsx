//
//  SXEditorEntityViewController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXEditorEntityViewController.h"
#import "Controller.h"
#import "ContentController.h"
#import "Award.h"
#import "City.h"
#import "Club.h"
#import "Currency.h"
#import "Continent.h"
#import "Derby.h"
#import "Injury.h"
#import "LangDB.h"
#import "Language.h"
#import "LocalArea.h"
#import "Nation.h"
#import "Sponsor.h"
#import "Stadium.h"
#import "StadiumChange.h"
#import "Team.h"
#import "Weather.h"
#import "StaffTendency.h"
#import "PlayerInjury.h"
#import "PlayerBan.h"

@implementation SXEditorEntityViewController

@synthesize awardMainViewContainer, awardEntityView, awardGeneralView, awardRulesView, awardSectionView,
cityMainViewContainer, cityEntityView, continentMainViewContainer, continentEntityView,
currencyMainViewContainer, currencyEntityView, localAreaMainViewContainer, localAreaEntityView, 
derbyMainViewContainer, derbyEntityView, injuryMainViewContainer, injuryEntityView, 
languageMainViewContainer, languageEntityView, stadiumChangeMainViewContainer, stadiumChangeEntityView,
sponsorMainViewContainer, sponsorEntityView, stadiumMainViewContainer, stadiumEntityView,
weatherMainViewContainer, weatherEntityView, competitionMainViewContainer, competitionEntityView,
mediaMainViewContainer, mediaEntityView, mediaGeneralView, mediaAssociationsView, mediaSectionView,
nationMainViewContainer, nationEntityView, nationGeneralView, nationSectionView, nationBannedPlayersView,
nationAgentsView, nationCoefficientsView, nationRankingPointsView, nationHumanPlayerPoolView,
nationShortlistsView, nationTransferPreferencesView, nationSpokenLanguagesView, nationTreatedAsEUView,
nationTreatedAsNonForeignView, nationRankingMatchesView, nationFutureRegenView, nationTacticsView,
nationStaffView, nationRelationshipsView, nationAlternativeStadiumsView, nationKitsView,
personMainViewContainer, personEntityView, personGeneralView, personSectionView, personActualPersonView,
personSpokespersonView, personHumanView, personRetiredPersonView, personAgentView, personJournalistView,
personOfficialView, personOfficialPastGamesView,personStatsView, personActualStaffView, personPreferredMovesView,
personPlayerView, personNonPlayerView, personNonPlayerStatsView, personInjuriesView, personBansView, personPlayerFormsView,
personPlayerStatsView, personRelationshipsView;

- (void)awakeFromNib
{
	[mediaNewClubPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[shirtPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[shortsPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[socksPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	// section tables
	if (aTableView==awardSectionsTable) { return 2; }
	else if (aTableView==mediaSectionsTable) { return 2; }
	else if (aTableView==nationSectionsTable) { return [NATION_SECTIONS count]; }
	else if (aTableView==peopleSectionsTable) { return [[[[[NSApp delegate] editorController] selectedPerson] sections:self] count]; }
	
	// entity tables
	if ([[[[NSApp delegate] editorController] searchResults] count]>0) { return [[[[NSApp delegate] editorController] searchResults] count]; }
	
	if (aTableView==awardsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] count]; }
	else if (aTableView==citiesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.cities"] count]; }
//	else if (aTableView==clubsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] count]; }
	else if (aTableView==competitionsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] count]; }
	else if (aTableView==continentsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.continents"] count]; }
	else if (aTableView==currenciesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.currencies"] count]; }
	else if (aTableView==derbiesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.derbies"] count]; }
	else if (aTableView==injuriesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.injuries"] count]; }
	else if (aTableView==languagesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.languages"] count]; }
	else if (aTableView==localAreasTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] count]; }
	else if (aTableView==mediaTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] count]; }
	else if (aTableView==nationsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] count]; }
	else if (aTableView==peopleTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] count]; }
	else if (aTableView==sponsorsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.sponsors"] count]; }
	else if (aTableView==stadiumsTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] count]; }
	else if (aTableView==stadiumChangesTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiumChanges"] count]; }
	else if (aTableView==weatherTable) { return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.weather"] count]; }

	return 0;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	NSString *columnName = [aTableColumn identifier];
	
	if (aTableView==awardsTable) {
		Award *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
		else if ([columnName isEqualToString:@"nation"])	{ return [object nationString]; }
		else if ([columnName isEqualToString:@"continent"]) { return [object continentString]; }
	}
	else if (aTableView==citiesTable) {
		City *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.cities"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==competitionsTable) {
		Competition *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==continentsTable) {
		Continent *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.continents"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==currenciesTable) {
		Currency *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.currencies"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==derbiesTable) {
		Derby *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.derbies"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==injuriesTable) {
		Injury *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.injuries"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==languagesTable) {
		Language *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.languages"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==localAreasTable) {
		LocalArea *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==mediaTable) {
		Media *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==nationsTable) {
		Nation *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==sponsorsTable) {
		Sponsor *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.sponsors"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
		else if ([columnName isEqualToString:@"businessName"])		{ return [object businessName]; }
	}
	else if (aTableView==peopleTable) {
		Person *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
		else if ([columnName isEqualToString:@"type"])		{ return [object typeString]; }
	}
	else if (aTableView==stadiumsTable) {
		Stadium *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==stadiumChangesTable) {
		StadiumChange *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiumChanges"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	else if (aTableView==weatherTable) {
		Weather *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.weather"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
	}
	
	
	else if (aTableView==awardSectionsTable) { 
		if (rowIndex==0)		{ return @"General"; }
		else if (rowIndex==1)	{ return @"Rules"; }
	}
	else if (aTableView==mediaSectionsTable) { 
		if (rowIndex==0)		{ return @"General"; }
		else if (rowIndex==1)	{ return @"Associations"; }
	}
	else if (aTableView==nationSectionsTable) { 
		return [[NATION_SECTIONS objectAtIndex:rowIndex] objectForKey:@"title"];
	}
	else if (aTableView==peopleSectionsTable) { 
		return [[[[[[NSApp delegate] editorController] selectedPerson] sections:self] objectAtIndex:rowIndex] objectForKey:@"title"];
	}
	
	return @"--Invalid--";
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	if (aTableView==awardsTable) {
		Award *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:rowIndex]; }
		
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[[object colour] backgroundColour]];
		[aCell setTextColor:[[object colour] foregroundColour]];
	}
	else if (aTableView==citiesTable) {
		City *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.cities"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==competitionsTable) {
		Competition *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:rowIndex]; }
	
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[[object colour] backgroundColour]];
		[aCell setTextColor:[[object colour] foregroundColour]];
	}
	else if (aTableView==continentsTable) {
		Continent *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.continents"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==currenciesTable) {
		Currency *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.currencies"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==derbiesTable) {
		Derby *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.derbies"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==injuriesTable) {
		Injury *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.injuries"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==languagesTable) {
		Language *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.languages"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==localAreasTable) {
		LocalArea *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==mediaTable) {
		Media *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==nationsTable) {
		Nation *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:rowIndex]; }
		
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[object valueForKeyPath:@"teamContainer.mainColour.backgroundColour"]];
		[aCell setTextColor:[object valueForKeyPath:@"teamContainer.mainColour.foregroundColour"]];
	}
	else if (aTableView==sponsorsTable) {
		Sponsor *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.sponsors"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==peopleTable) {
		Person *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==stadiumsTable) {
		Stadium *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==stadiumChangesTable) {
		StadiumChange *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiumChanges"] objectAtIndex:rowIndex]; }
	}
	else if (aTableView==weatherTable) {
		Weather *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.weather"] objectAtIndex:rowIndex]; }
	}
	
	
	// generic ID - txt columns
	if ([[aTableColumn identifier] isEqualToString:@"nationIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] count] && UID > -1) {
			[aCell setStringValue:[[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:UID] teamContainer] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"agreementIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.agreements"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.agreements"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"localAreaIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	
	else if ([[aTableColumn identifier] isEqualToString:@"continentIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.continents"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.continents"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"languageIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.languages"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.languages"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"injuryIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.injuries"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.injuries"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	
	else if ([[aTableColumn identifier] isEqualToString:@"personIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"mediaIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.media"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"stadiumIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"clubIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"clubUIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if ([[[[NSApp delegate] langDB] clubLang] objectForKey:[NSNumber numberWithInt:UID]]!=nil) {
			[aCell setStringValue:[[[[[NSApp delegate] langDB] clubLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"compIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] count] && UID >= 0) {
			NSString *compString = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:UID] name];
			if (!compString) { [aCell setStringValue:@"---"]; }
			else { [aCell setStringValue:compString]; }
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"compUIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if ([[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]]!=nil) {
			[aCell setStringValue:[[[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"teamIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:UID] fullTeamString]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"staffTendencytxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		[aCell setStringValue:[StaffTendency typeStringWithType:UID]];
	}
	else if ([[aTableColumn identifier] isEqualToString:@"injuryReceiveTypetxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		[aCell setStringValue:[PlayerInjury receiveTypeStringWithType:UID]];
	}
	else if ([[aTableColumn identifier] isEqualToString:@"banReasontxt"]) {
		int UID = [[aCell stringValue] intValue];
		[aCell setStringValue:[PlayerBan reasonStringWithType:UID]];
	}
	else if ([[aTableColumn identifier] isEqualToString:@"banDecisiontxt"]) {
		int UID = [[aCell stringValue] intValue];
		[aCell setStringValue:[PlayerBan decisionStringWithType:UID]];
	}
	else if ([[aTableColumn identifier] isEqualToString:@"banScopetxt"]) {
		int UID = [[aCell stringValue] intValue];
		[aCell setStringValue:[PlayerBan scopeStringWithType:UID]];
	}
	
	else if ([[aTableColumn identifier] isEqualToString:@"relnametxt"]) {
		NSString *type = [[aCell stringValue] substringToIndex:2];
		int UID = [[[aCell stringValue] substringFromIndex:2] intValue];
		
		if ([type isEqualToString:@"na"]) {
			[aCell setStringValue:[[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:UID] teamContainer] name]];
		}
		else if ([type isEqualToString:@"pe"]) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.people"] objectAtIndex:UID] name]];
		}
		else if ([type isEqualToString:@"cl"]) {
			[aCell setStringValue:[[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:UID] teamContainer] name]];
		}
		else if ([type isEqualToString:@"te"]) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:UID] fullTeamString]];
		}
		else if ([type isEqualToString:@"st"]) {
			NSString *stadString = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:UID] name];
			if (!stadString) { [aCell setStringValue:@"---"]; }
			else { [aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:UID] name]]; }
		}
	}
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object]==awardSectionsTable) {
		if ([awardSectionsTable selectedRow]==0) {
			[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardGeneralView];
		}
		else if ([awardSectionsTable selectedRow]==1) {
			[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardRulesView];
		}
	}
	else if ([aNotification object]==mediaSectionsTable) {
		if ([mediaSectionsTable selectedRow]==0) {
			[[[NSApp delegate] contentController] replacePlaceholder:mediaSectionView withView:mediaGeneralView];
		}
		else if ([mediaSectionsTable selectedRow]==1) {
			[[[NSApp delegate] contentController] replacePlaceholder:mediaSectionView withView:mediaAssociationsView];
		}
	}
	else if ([aNotification object]==nationSectionsTable) {
		if ([nationSectionsTable selectedRow]<0 || [nationSectionsTable selectedRow] >= [NATION_SECTIONS count]) { return; }
		
		[[[NSApp delegate] contentController] replacePlaceholder:nationSectionView withView:[[NATION_SECTIONS objectAtIndex:[nationSectionsTable selectedRow]] objectForKey:@"view"]];
	}
	else if ([aNotification object]==peopleSectionsTable) {
		if ([peopleSectionsTable selectedRow]<0 || [peopleSectionsTable selectedRow] >= [[[[[NSApp delegate] editorController] selectedPerson] sections:self] count]) { return; }
		
		[[[NSApp delegate] contentController] replacePlaceholder:personSectionView withView:[[[[[[NSApp delegate] editorController] selectedPerson] sections:self] objectAtIndex:[peopleSectionsTable selectedRow]] objectForKey:@"view"]];
	}
}

- (void)selectFromTable
{
	int currentSection = [[[NSApp delegate] editorController] currentSection];
	
	// set to -1 as failsafe
	int selectionIndex = -1;
	
	NSString *arrayString, *classString;
	
	if (currentSection==EDS_AWARDS) { 
		selectionIndex = [awardsTable selectedRow]; 
		arrayString = @"awards";	classString = @"award";
	}
	else if (currentSection==EDS_CITIES) { 
		selectionIndex = [citiesTable selectedRow]; 
		arrayString = @"cities";	classString = @"city";
	}
	else if (currentSection==EDS_COMPETITIONS) { 
		selectionIndex = [competitionsTable selectedRow]; 
		arrayString = @"competitions";	classString = @"competition";
	}
	else if (currentSection==EDS_CONTINENTS) { 
		selectionIndex = [continentsTable selectedRow]; 
		arrayString = @"continents";	classString = @"continent";
	}
	else if (currentSection==EDS_CURRENCIES) { 
		selectionIndex = [currenciesTable selectedRow]; 
		arrayString = @"currencies";	classString = @"currency";
	}
	else if (currentSection==EDS_DERBIES) { 
		selectionIndex = [derbiesTable selectedRow]; 
		arrayString = @"derbies";	classString = @"derby";
	}
	else if (currentSection==EDS_INJURIES) { 
		selectionIndex = [injuriesTable selectedRow]; 
		arrayString = @"injuries";	classString = @"injury";
	}
	else if (currentSection==EDS_LANGUAGES) { 
		selectionIndex = [languagesTable selectedRow]; 
		arrayString = @"languages";	classString = @"language";
	}
	else if (currentSection==EDS_LOCAL_AREAS) { 
		selectionIndex = [localAreasTable selectedRow]; 
		arrayString = @"localAreas";	classString = @"localArea";
	}
	else if (currentSection==EDS_MEDIA) { 
		selectionIndex = [mediaTable selectedRow]; 
		arrayString = @"media";	classString = @"media";
	}
	else if (currentSection==EDS_NATIONS) { 
		selectionIndex = [nationsTable selectedRow]; 
		arrayString = @"nations";	classString = @"nation";
	}
	else if (currentSection==EDS_PEOPLE) { 
		selectionIndex = [peopleTable selectedRow]; 
		arrayString = @"people";	classString = @"person";
	}
	else if (currentSection==EDS_SPONSORS) { 
		selectionIndex = [sponsorsTable selectedRow]; 
		arrayString = @"sponsors";	classString = @"sponsor";
	}
	else if (currentSection==EDS_STADIUM_CHANGES) { 
		selectionIndex = [stadiumChangesTable selectedRow]; 
		arrayString = @"stadiumChanges";	classString = @"stadiumChange";
	}
	else if (currentSection==EDS_STADIUMS) { 
		selectionIndex = [stadiumsTable selectedRow]; 
		arrayString = @"stadiums";	classString = @"stadium";
	}
	else if (currentSection==EDS_WEATHER) { 
		selectionIndex = [weatherTable selectedRow]; 
		arrayString = @"weather";	classString = @"weather";
	}
	/*
	else if (currentSection==EDS_CLUBS) { 
		selectionIndex = [clubsTable selectedRow]; 
		arrayString = @"clubs";	classString = @"club";
	}
*/
	
	// override selection index if there is a search
	if ([[[[NSApp delegate] editorController] searchResults] count]>0) { 
		selectionIndex = [[[NSApp delegate] valueForKeyPath:[NSString stringWithFormat:@"gameDB.database.%@",arrayString]] indexOfObjectIdenticalTo:[[[[NSApp delegate] editorController] searchResults] objectAtIndex:selectionIndex]];
	}
	
	if (selectionIndex==-1) { return; }
	
	[[[[NSApp delegate] editorController] searchResults] removeAllObjects];
	
	SEL selectionSelector = NSSelectorFromString([NSString stringWithFormat:@"setSelected%@:",[classString stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[classString substringToIndex:1] capitalizedString]]]);
	[[[NSApp delegate] editorController] performSelector:selectionSelector withObject:[[[NSApp delegate] valueForKeyPath:[NSString stringWithFormat:@"gameDB.database.%@",arrayString]] objectAtIndex:selectionIndex]];
	
	SEL containerViewSelector = NSSelectorFromString([NSString stringWithFormat:@"%@MainViewContainer",classString]);
	SEL entityViewSelector = NSSelectorFromString([NSString stringWithFormat:@"%@EntityView",classString]);
	 
	[[[NSApp delegate] contentController] replacePlaceholder:[self performSelector:containerViewSelector] withView:[self performSelector:entityViewSelector]];
	 
	// any extra things that need doing after the view is set
	if (currentSection==EDS_AWARDS) { 
		// make the default section the general view
		[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardGeneralView];
		
		// set header colour
		[awardHeaderBox setFillStartingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] backgroundColour]];
		[awardHeaderBox setFillEndingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
		[awardBGBox setFillColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
	}
	else if (currentSection==EDS_COMPETITIONS) { 
		// set header colour
		[competitionHeaderBox setFillStartingColor:[[[[[NSApp delegate] editorController] selectedCompetition] colour] backgroundColour]];
		[competitionHeaderBox setFillEndingColor:[[[[[NSApp delegate] editorController] selectedCompetition] colour] foregroundColour]];
		[competitionBGBox setFillColor:[[[[[NSApp delegate] editorController] selectedCompetition] colour] foregroundColour]];
	}
	else if (currentSection==EDS_MEDIA) { 
		// make the default section the general view
		[[[NSApp delegate] contentController] replacePlaceholder:mediaSectionView withView:mediaGeneralView];
	}
	else if (currentSection==EDS_NATIONS) { 
		// make the default section the general view
		[[[NSApp delegate] contentController] replacePlaceholder:nationSectionView withView:nationGeneralView];
		
		// set header colour
		[nationHeaderBox setFillStartingColor:[[[[[[NSApp delegate] editorController] selectedNation] teamContainer] mainColour] backgroundColour]];
		[nationHeaderBox setFillEndingColor:[[[[[[NSApp delegate] editorController] selectedNation] teamContainer] mainColour] foregroundColour]];
		[nationBGBox setFillColor:[[[[[[NSApp delegate] editorController] selectedNation] teamContainer] mainColour] foregroundColour]];
	}
	else if (currentSection==EDS_PEOPLE) { 
		// make the default section the general view
		[[[NSApp delegate] contentController] replacePlaceholder:personSectionView withView:[[[[[[NSApp delegate] editorController] selectedPerson] sections:self] objectAtIndex:0] objectForKey:@"view"]];
	}
	
	[self reloadEntityTable:[[[NSApp delegate] editorController] currentSection]];
}

- (void)controlTextDidEndEditing:(NSNotification *)aNotification
{
	int currentSection = [[[NSApp delegate] editorController] currentSection];
	NSString *searchVariable = @"";
	NSString *searchArray;
	
	if (currentSection==EDS_AWARDS)					{ searchArray = @"awards"; }
	else if (currentSection==EDS_CITIES)			{ searchArray = @"cities"; }
	//	else if (currentSection==EDS_CLUBS)				{ searchArray = @"clubs"; }
	else if (currentSection==EDS_COMPETITIONS)		{ searchArray = @"competitions"; }
	else if (currentSection==EDS_CONTINENTS)		{ searchArray = @"continents"; }
	else if (currentSection==EDS_CURRENCIES)		{ searchArray = @"currencies"; }
	else if (currentSection==EDS_DERBIES)			{ searchArray = @"derbies"; }
	else if (currentSection==EDS_INJURIES)			{ searchArray = @"injuries"; }
	else if (currentSection==EDS_LANGUAGES)			{ searchArray = @"languages"; }
	else if (currentSection==EDS_LOCAL_AREAS)		{ searchArray = @"localAreas"; }
	else if (currentSection==EDS_MEDIA)				{ searchArray = @"media"; }
	else if (currentSection==EDS_NATIONS)			{ searchArray = @"nations"; }
	else if (currentSection==EDS_PEOPLE)			{ searchArray = @"people"; }
	else if (currentSection==EDS_SPONSORS)			{ searchArray = @"sponsors"; }
	else if (currentSection==EDS_STADIUMS)			{ searchArray = @"stadiums"; }
	else if (currentSection==EDS_STADIUM_CHANGES)	{ searchArray = @"stadiumChanges"; }
	else if (currentSection==EDS_WEATHER)			{ searchArray = @"weather"; }	
	
	if (!searchVariable || [searchVariable length] < 1) { searchVariable = @"name"; }
		
	[[[[NSApp delegate] editorController] searchResults] removeAllObjects];
	
	if ([[[aNotification object] stringValue] length] < 1) { return; }
	
	NSString *searchString = [NSString stringWithFormat:@"%@ contains[cd] '%@'",searchVariable,[[aNotification object] stringValue]];
	[[[[NSApp delegate] editorController] searchResults] addObjectsFromArray:[[[NSApp delegate] valueForKeyPath:[NSString stringWithFormat:@"gameDB.database.%@",searchArray]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:searchString]]];
	
	[self reloadEntityTable:currentSection];
}

- (IBAction)showCityPicker:(id)sender { [[[NSApp delegate] contentController] showCityPicker:sender]; }
- (IBAction)showClubPicker:(id)sender { [[[NSApp delegate] contentController] showClubPicker:sender]; }
- (IBAction)showCompetitionPicker:(id)sender { [[[NSApp delegate] contentController] showCompetitionPicker:sender]; }
- (IBAction)showMediaPicker:(id)sender { [[[NSApp delegate] contentController] showMediaPicker:sender]; }
- (IBAction)showNationPicker:(id)sender { [[[NSApp delegate] contentController] showNationPicker:sender]; }
- (IBAction)showPersonPicker:(id)sender { [[[NSApp delegate] contentController] showPersonPicker:sender]; }
- (IBAction)showStadiumPicker:(id)sender { [[[NSApp delegate] contentController] showStadiumPicker:sender]; }

- (void)reloadEntityTable:(int)section
{
	if (section==EDS_AWARDS)				{ [awardsTable reloadData]; }
	else if (section==EDS_CITIES)			{ [citiesTable reloadData]; }
//	else if (section==EDS_CLUBS)			{ [clubsTable reloadData]; }
	else if (section==EDS_COMPETITIONS)		{ [competitionsTable reloadData]; }
	else if (section==EDS_CONTINENTS)		{ [continentsTable reloadData]; }
	else if (section==EDS_CURRENCIES)		{ [currenciesTable reloadData]; }
	else if (section==EDS_DERBIES)			{ [derbiesTable reloadData]; }
	else if (section==EDS_INJURIES)			{ [injuriesTable reloadData]; }
	else if (section==EDS_LANGUAGES)		{ [languagesTable reloadData]; }
	else if (section==EDS_LOCAL_AREAS)		{ [localAreasTable reloadData]; }
	else if (section==EDS_MEDIA)			{ [mediaTable reloadData]; }
	else if (section==EDS_NATIONS)			{ [nationsTable reloadData]; }
	else if (section==EDS_PEOPLE)			{ [peopleTable reloadData]; }
	else if (section==EDS_SPONSORS)			{ [sponsorsTable reloadData]; }
	else if (section==EDS_STADIUMS)			{ [stadiumsTable reloadData]; }
	else if (section==EDS_STADIUM_CHANGES)	{ [stadiumChangesTable reloadData]; }
	else if (section==EDS_WEATHER)			{ [weatherTable reloadData]; }	
}

@end
