//
//  ContentController.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "Award.h"
#import "Club.h"
#import "Colour.h"
#import "Person.h"
#import "Team.h"
#import "Contract.h"
#import "Controller.h"
#import "DatabaseTypes.h"
#import "Database.h"
#import "FMString.h"
#import "LangDB.h"
#import "ContentController.h"
#import "PlayerStatsTransformer.h"
#import "PlayerRatingTransformer.h"
#import "SupportFunctions.h"
#import "SXOutlineViewCell.h"
#import "SXMainMediaController.h"

@implementation ContentController

@synthesize awardSearchView, awardGeneralView, citySearchView, cityGeneralView,
selectedRows, gameInfoView, continentSearchView, continentGeneralView, currencySearchView, 
currencyGeneralView, injuryGeneralView, injurySearchView, languageGeneralView, 
languageSearchView, localAreaGeneralView, localAreaSearchView, stadiumGeneralView, 
stadiumSearchView, weatherGeneralView, weatherSearchView, mediaGeneralView, mediaSearchView,
stadiumChangeGeneralView, stadiumChangeSearchView, clubSearchView, clubGeneralView, clubContainer, 
clubTacticsView, clubMainView, clubTrainingView, clubCoefficientView, peopleSearchView, 
peopleGeneralView, personContainer, competitionSearchView, competitionGeneralView,
actualPersonView, actualPlayerView, scoutResults, sponsorGeneralView, sponsorSearchView,
nationGeneralView, nationMainView, nationSearchView, personRelationshipsView,
clubRelationshipsView, nationRelationshipsView, clubScoutResults, staffScoutResults, playerScoutResults,
recentlyViewed, mainContainer, awardController, cityController, clubController, nationController, 
competitionController, continentController, injuryController, currencyController, 
languageController, localAreaController, mediaController, peopleController, clubKitView,
sponsorController, stadiumController, stadiumChangeController, weatherController, awardRulesView, 
awardMainView, derbyGeneralView, derbySearchView, derbyController, agentView, locationString,
clubLBCView, clubFacilitiesView, currentPlayerExpression, currentStaffExpression, currentClubExpression;

- (id)init
{
	[super init];
	
	selectedRows = [[NSMutableDictionary alloc] init];
	recentlyViewed = [[NSMutableArray alloc] init];
	
	sections = [[NSMutableArray alloc] init];
	awardSections = [[NSMutableArray alloc] init];
	clubSections = [[NSMutableArray alloc] init];
	nationSections = [[NSMutableArray alloc] init];
	personSections = [[NSMutableArray alloc] init];
	
	id playerStatsTransformer = [[[PlayerStatsTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerStatsTransformer forName:@"PlayerStatsTransformer"];
	id playerRatingTransformer = [[[PlayerRatingTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerRatingTransformer forName:@"PlayerRatingTransformer"];
	
	NSMutableDictionary *section;
	NSMutableArray *subsections;
	NSMutableDictionary *subsection;
	
	subsections = [[NSMutableArray alloc] init];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Awards" forKey:@"title"];
	[subsection setObject:@"award" forKey:@"image"];
	[subsection setObject:@"awards" forKey:@"array"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsection setObject:@"awardSearchView" forKey:@"view"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Cities" forKey:@"title"];
	[subsection setObject:@"city" forKey:@"image"];
	[subsection setObject:@"cities" forKey:@"array"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsection setObject:@"citySearchView" forKey:@"view"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Clubs" forKey:@"title"];
	[subsection setObject:@"club" forKey:@"image"];
	[subsection setObject:@"clubs" forKey:@"array"];
	[subsection setObject:@"clubSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Competitions" forKey:@"title"];
	[subsection setObject:@"competition" forKey:@"image"];
	[subsection setObject:@"competitions" forKey:@"array"];
	[subsection setObject:@"competitionSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Continents" forKey:@"title"];
	[subsection setObject:@"continent" forKey:@"image"];
	[subsection setObject:@"continents" forKey:@"array"];
	[subsection setObject:@"continentSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Currencies" forKey:@"title"];
	[subsection setObject:@"currency" forKey:@"image"];
	[subsection setObject:@"currencies" forKey:@"array"];
	[subsection setObject:@"currencySearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Derbies" forKey:@"title"];
	[subsection setObject:@"derby" forKey:@"image"];
	[subsection setObject:@"derbies" forKey:@"array"];
	[subsection setObject:@"derbySearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Injuries" forKey:@"title"];
	[subsection setObject:@"injury" forKey:@"image"];
	[subsection setObject:@"injuries" forKey:@"array"];
	[subsection setObject:@"injurySearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Languages" forKey:@"title"];
	[subsection setObject:@"language" forKey:@"image"];
	[subsection setObject:@"languages" forKey:@"array"];
	[subsection setObject:@"languageSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Local Areas" forKey:@"title"];
	[subsection setObject:@"localarea" forKey:@"image"];
	[subsection setObject:@"localAreas" forKey:@"array"];
	[subsection setObject:@"localAreaSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Media" forKey:@"title"];
	[subsection setObject:@"media" forKey:@"image"];
	[subsection setObject:@"media" forKey:@"array"];
	[subsection setObject:@"mediaSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Nations" forKey:@"title"];
	[subsection setObject:@"nation" forKey:@"image"];
	[subsection setObject:@"nations" forKey:@"array"];
	[subsection setObject:@"nationSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"People" forKey:@"title"];
	[subsection setObject:@"person" forKey:@"image"];
	[subsection setObject:@"people" forKey:@"array"];
	[subsection setObject:@"peopleSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Sponsors" forKey:@"title"];
	[subsection setObject:@"sponsor" forKey:@"image"];
	[subsection setObject:@"sponsors" forKey:@"array"];
	[subsection setObject:@"sponsorSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Stadiums" forKey:@"title"];
	[subsection setObject:@"stadium" forKey:@"image"];
	[subsection setObject:@"stadiums" forKey:@"array"];
	[subsection setObject:@"stadiumSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Stadium Changes" forKey:@"title"];
	[subsection setObject:@"stadiumchange" forKey:@"image"];
	[subsection setObject:@"stadiumChanges" forKey:@"array"];
	[subsection setObject:@"stadiumChangeSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	subsection = [[NSMutableDictionary alloc] init];
	[subsection setObject:@"Weather" forKey:@"title"];
	[subsection setObject:@"weather" forKey:@"image"];
	[subsection setObject:@"weather" forKey:@"array"];
	[subsection setObject:@"weatherSearchView" forKey:@"view"];
	[subsection setObject:@"1" forKey:@"subsection"];
	[subsections addObject:subsection];
	[subsection release];
	
	section = [[NSMutableDictionary alloc] init];
	[section setObject:@"Entities" forKey:@"title"];
	[section setObject:subsections forKey:@"subsections"];
	[sections addObject:section];
	[subsections release];
	[section release];
	
	subsections = [[NSMutableArray alloc] init];
	section = [[NSMutableDictionary alloc] init];
	[section setObject:@"Favourites" forKey:@"title"];
	[sections addObject:section];
	[section setObject:subsections forKey:@"subsections"];
	[section release];
	
	section = [[NSMutableDictionary alloc] init];
	[section setObject:@"Shortlists" forKey:@"title"];
	[sections addObject:section];
	[section release];

	return self;
}

- (void)dealloc
{
	[recentlyViewed release];
	[selectedRows release];
	[sections release];
	[awardSections release];
	[clubSections release];
	[personSections release];
	
	[super dealloc];
}

- (void)awakeFromNib
{
	[staffScoutPersonalAttributeEditor addRow:self];
	[staffScoutPersonalAttributeEditor removeRowAtIndex:1];
	[staffScoutPersonalAttributeEditor setCanRemoveAllRows:YES];
	[staffScoutStatEditor addRow:self];
	[staffScoutStatEditor removeRowAtIndex:1];
	[staffScoutStatEditor setCanRemoveAllRows:YES];
	
	[playerScoutPersonalAttributeEditor addRow:self];
	[playerScoutPersonalAttributeEditor removeRowAtIndex:1];
	[playerScoutPersonalAttributeEditor setCanRemoveAllRows:YES];
	[playerScoutTechnicalAttributeEditor addRow:self];
	[playerScoutTechnicalAttributeEditor removeRowAtIndex:1];
	[playerScoutTechnicalAttributeEditor setCanRemoveAllRows:YES];
	[playerScoutPhysicalAttributeEditor addRow:self];
	[playerScoutPhysicalAttributeEditor removeRowAtIndex:1];
	[playerScoutPhysicalAttributeEditor setCanRemoveAllRows:YES];
	[playerScoutMentalAttributeEditor addRow:self];
	[playerScoutMentalAttributeEditor removeRowAtIndex:1];
	[playerScoutMentalAttributeEditor setCanRemoveAllRows:YES];
	
	SXOutlineViewCell *oCell = [[SXOutlineViewCell alloc] init];
	
	[[mainOutlineView tableColumnWithIdentifier:@"mainCol"] setDataCell:oCell];
	
	if (![mainOutlineView isItemExpanded:[mainOutlineView itemAtRow:0]] &&
		[mainOutlineView isExpandable:[mainOutlineView itemAtRow:0]]) {
		[mainOutlineView expandItem:[mainOutlineView itemAtRow:0]];
	}
	
}

- (void)setFavourites
{
	
}

#pragma mark Outline View Delegate

- (void)outlineViewSelectionDidChange:(NSNotification *)notification
{
	id oView = [notification object];
	if ([oView selectedRow]==-1) { return; }
	if ([[oView itemAtRow:[oView selectedRow]] objectForKey:@"favourite"]!=nil) {
		if (![controller dataLoaded]) { return; }
		
		SEL arraySelector = NSSelectorFromString([[oView itemAtRow:[oView selectedRow]] objectForKey:@"array"]);
		
		int row = [[[oView itemAtRow:[oView selectedRow]] objectForKey:@"row"] intValue];
		if (row<[[[controller database] performSelector:arraySelector] count]) {
			[self selectItem:[[[controller database] performSelector:arraySelector] objectAtIndex:row]];
		}
	}
	else if ([[oView itemAtRow:[oView selectedRow]] objectForKey:@"view"]!=nil) {
		SEL viewSelector = NSSelectorFromString([[oView itemAtRow:[oView selectedRow]] objectForKey:@"view"]);
		[mainContainer setContentView:[self performSelector:viewSelector]];
	}
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldEditTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	return FALSE;	 
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item
{
	if ([[item objectForKey:@"groupItem"] boolValue]) { return TRUE; }
	
	return FALSE;
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	[cell setColor:nil];
	[cell setBackgroundColor:nil];
	[cell setMenu:nil];
	
	if ([item objectForKey:@"image"]!=nil) {
		[cell setImage:[NSImage imageNamed:[item objectForKey:@"image"]]];
	}
	else { [cell setImage:nil]; }
	
	if ([item objectForKey:@"subsection"]!=nil) {
		[cell setIsChild:TRUE];
	}
	else { [cell setIsChild:FALSE]; }
	
	if ([item objectForKey:@"array"]!=nil &&
		[item objectForKey:@"favourite"]==nil) {
		int count = [[controller valueForKeyPath:[NSString stringWithFormat:@"database.%@",[item objectForKey:@"array"]]] count];
		[cell setBadgeCount:count];
	}
	else { [cell setBadgeCount:0]; }
	
	[cell setText:[item objectForKey:@"title"]];
}

#pragma mark Outline View Data Source

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	if (item==nil) { return [sections objectAtIndex:index]; }
	else if ([item objectForKey:@"subsections"]) {
		return [[item objectForKey:@"subsections"] objectAtIndex:index];
	}
	return nil;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	if ([[item objectForKey:@"subsections"] count]>0) { return TRUE; }
	
	return FALSE;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if (item==nil) { return [sections count]; }
	else if ([item objectForKey:@"subsections"]) {
		return [[item objectForKey:@"subsections"] count];
	}
	
	return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
{
	
	return [item objectForKey:@"title"];
}

- (void)reloadOutlineView { [mainOutlineView reloadData]; }

#pragma mark Table Delegate

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
//	NSMenu *rightClick = [[NSMenu alloc] initWithTitle:@"Right Click Menu"];
//	NSMenuItem *viewItem
	
	if ([[aCell className] isEqualToString:@"SXOutlineViewCell"]) { 
		[aCell setBadgeCount:0];
		[aCell setText:[[aCell stringValue] copy]];
		[aCell setBackgroundColor:nil];
		[aCell setColor:nil];
		[aCell setIsChild:TRUE];
	}
	if ([aCell respondsToSelector: @selector(setImage:)]) { [aCell setImage:nil]; }
	
	if (aTableView==awardTable) {
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[[[[awardController arrangedObjects] objectAtIndex:rowIndex] colour] backgroundColour]];
		[aCell setTextColor:[[[[awardController arrangedObjects] objectAtIndex:rowIndex] colour] foregroundColour]];
	}
	else if (aTableView==clubKitTable) {
		if ([[aTableColumn identifier] isEqualToString:@"compcol"]) {
			int UID = [[aCell stringValue] intValue];
		
			if ([[[[controller database] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]]==nil) {
				[aCell setStringValue:@"---"];
			}
			else {
				[aCell setStringValue:[[[[[controller database] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
			}
		}
	}
	else if (aTableView==cityTable) {
//		viewItem = [[NSMenuItem alloc] initWithTitle:@"View" action:@selector(performCityMenuAction:) keyEquivalent:@""];
//		[viewItem setTarget:self];
//		[viewItem setImage:[NSImage imageNamed:@"View"]];
//		[rightClick addItem:viewItem];
//		[viewItem release];
	}
	else if (aTableView==clubTable) {
	/*	[aCell setDrawsBackground:YES];
		if ([[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] count] > 0) {
			[aCell setBackgroundColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] backgroundColour]];
			if ([[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] numberColour]==
				[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] backgroundColour]) {
				[aCell setTextColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] foregroundColour]];
			}
			else {
				[aCell setTextColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] numberColour]];
			}
		}
		else {
			[aCell setBackgroundColor:[NSColor whiteColor]];
			[aCell setTextColor:[NSColor blackColor]];
		}
//		viewItem = [[NSMenuItem alloc] initWithTitle:@"View" action:@selector(performClubMenuAction:) keyEquivalent:@""];
//		[viewItem setTarget:self];
//		[viewItem setImage:[NSImage imageNamed:@"View"]];
//		[rightClick addItem:viewItem];
//		[viewItem release];
		
/*		if ([[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] count] > 0) {
			[aCell setBackgroundColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] backgroundColour]];
			if ([[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] numberColour]==
				[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] backgroundColour]) {
				[aCell setColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] foregroundColour]];
			}
			else {
				[aCell setColor:[[[[[[clubController arrangedObjects] objectAtIndex:rowIndex] teamContainer] colours] objectAtIndex:0] numberColour]];
			}
		}
*/	}
	else if (aTableView==competitionTable) {
//		viewItem = [[NSMenuItem alloc] initWithTitle:@"View" action:@selector(performCompetitionMenuAction:) keyEquivalent:@""];
//		[viewItem setTarget:self];
//		[viewItem setImage:[NSImage imageNamed:@"View"]];
//		[rightClick addItem:viewItem];
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[[[[competitionController arrangedObjects] objectAtIndex:rowIndex] colour] backgroundColour]];
		[aCell setTextColor:[[[[competitionController arrangedObjects] objectAtIndex:rowIndex] colour] foregroundColour]];
		
//		[viewItem release];
	}
	else if ([[aTableColumn identifier] isEqualToString:@"playerscoutstatuscolumn"]) {
		if ([[[[playerScoutResults objectAtIndex:rowIndex] playerData] injuries] count] > 0) {
			[aCell setImage:[NSImage imageNamed:@"status_inj"]];
		}
		else if ([[[[playerScoutResults objectAtIndex:rowIndex] playerData] bans] count] > 0) {
			[aCell setImage:[NSImage imageNamed:@"status_sus"]];
		}
		else if ([[playerScoutResults objectAtIndex:rowIndex] acceptedContractOffer]) {
			[aCell setImage:[NSImage imageNamed:@"status_fut"]];
		}
		else if ([[[[playerScoutResults objectAtIndex:rowIndex] staffData] transferOffers] count] > 0) {
			[aCell setImage:[NSImage imageNamed:@"status_bid"]];
		}
		else if ([[[[playerScoutResults objectAtIndex:rowIndex] staffData] interestedClubs] count] > 0) {
			[aCell setImage:[NSImage imageNamed:@"status_wnt"]];
		}
		else if ([[[playerScoutResults objectAtIndex:rowIndex] staffData] hasYouthContract]) {
			[aCell setImage:[NSImage imageNamed:@"status_yth"]];
		}
		else if ([[playerScoutResults objectAtIndex:rowIndex] contractIsExpiring]) {
			[aCell setImage:[NSImage imageNamed:@"status_ctr"]];
		}
		else if ([[playerScoutResults objectAtIndex:rowIndex] isTransferListed]) {
			[aCell setImage:[NSImage imageNamed:@"status_lst"]];
		}
		else if ([[playerScoutResults objectAtIndex:rowIndex] isListedForLoan]) {
			[aCell setImage:[NSImage imageNamed:@"status_loa"]];
		}
	}
	else if ([[aTableColumn identifier] isEqualToString:@"statuscolumn"]) {
			if ([[[[[peopleController arrangedObjects] objectAtIndex:rowIndex] playerData] injuries] count] > 0) {
				[aCell setImage:[NSImage imageNamed:@"status_inj"]];
			}
			else if ([[[[[peopleController arrangedObjects] objectAtIndex:rowIndex] playerData] bans] count] > 0) {
				[aCell setImage:[NSImage imageNamed:@"status_sus"]];
			}
			else if ([[[[[peopleController arrangedObjects] objectAtIndex:rowIndex] staffData] transferOffers] count] > 0) {
				[aCell setImage:[NSImage imageNamed:@"status_bid"]];
			}
			else if ([[[[[peopleController arrangedObjects] objectAtIndex:rowIndex] staffData] interestedClubs] count] > 0) {
				[aCell setImage:[NSImage imageNamed:@"status_wnt"]];
			}
	}
	
	// generic ID - txt columns
	if ([[aTableColumn identifier] isEqualToString:@"nationIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] nations] count] && UID > -1) {
			[aCell setStringValue:[[[[[controller database] nations] objectAtIndex:UID] teamContainer] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"personIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] people] count] && UID > -1) {
			[aCell setStringValue:[[[[controller database] people] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"mediaIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] media] count] && UID > -1) {
			[aCell setStringValue:[[[[controller database] media] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"clubIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] clubs] count] && UID > -1) {
			[aCell setStringValue:[[[[controller database] clubs] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"comprowIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] competitions] count] && UID >= 0) {
			NSString *compString = [[[[controller database] competitions] objectAtIndex:UID] name];
			if (!compString) { [aCell setStringValue:@"---"]; }
			else { [aCell setStringValue:compString]; }
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"compIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] competitions] count] && UID > -1) {
			[aCell setStringValue:[[[[controller database] competitions] objectAtIndex:UID] name]];
		}
		else if ([[[[controller database] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]]!=nil) {
			[aCell setStringValue:[[[[[controller database] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"clubUIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if ([[[[controller database] langDB] clubLang] objectForKey:[NSNumber numberWithInt:UID]]!=nil) {
			[aCell setStringValue:[[[[[controller database] langDB] clubLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"teamIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[controller database] teams] count] && UID > -1) {
			[aCell setStringValue:[[[[controller database] teams] objectAtIndex:UID] fullTeamString]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	
	
	else if ([[aTableColumn identifier] isEqualToString:@"relnametxt"]) {
		NSString *type = [[aCell stringValue] substringToIndex:2];
		int UID = [[[aCell stringValue] substringFromIndex:2] intValue];
		
		if ([type isEqualToString:@"na"]) {
			[aCell setStringValue:[[[[[controller database] nations] objectAtIndex:UID] teamContainer] name]];
		}
		else if ([type isEqualToString:@"pe"]) {
			[aCell setStringValue:[[[[controller database] people] objectAtIndex:UID] name]];
		}
		else if ([type isEqualToString:@"cl"]) {
			[aCell setStringValue:[[[[[controller database] clubs] objectAtIndex:UID] teamContainer] name]];
		}
		else if ([type isEqualToString:@"te"]) {
			[aCell setStringValue:[[[[controller database] teams] objectAtIndex:UID] fullTeamString]];
		}
		else if ([type isEqualToString:@"st"]) {
			NSString *stadString = [[[[controller database] stadiums] objectAtIndex:UID] name];
			if (!stadString) { [aCell setStringValue:@"---"]; }
			else { [aCell setStringValue:[[[[controller database] stadiums] objectAtIndex:UID] name]]; }
		}
	}
}

- (void)selectItem:(id)object
{
	NSLog(@"selecting item...");
	
	NSString *lowerClass;
	
	if ([[object className] isEqualToString:@"StadiumChange"]) {
		lowerClass = @"stadiumChange";
	}
	else if ([[object className] isEqualToString:@"LocalArea"]) {
		lowerClass = @"localArea";
	}
	else if ([[object className] isEqualToString:@"Person"]) {
		lowerClass = @"people";
	}
	else { lowerClass = [[object className] lowercaseString]; }
	
	// add object to recently viewed and remove previous entry if it exists
	[[self mutableArrayValueForKey:@"recentlyViewed"] removeObject:object];
	[[self mutableArrayValueForKey:@"recentlyViewed"] insertObject:object atIndex:0];
	
	NSLog(@"before controller content reset");
	
	// reset the controllers contents
	SEL controllerSelector = NSSelectorFromString([NSString stringWithFormat:@"%@Controller",lowerClass]);
//	NSSortDescriptor *rowIDDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rowID" ascending:YES];
	
	NSLog(@"resetting predicate");
	[[self performSelector:controllerSelector] setFilterPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"rowID==%d",[object rowID]]]];
	[[self performSelector:controllerSelector] setSelectionIndex:0];
	
	NSLog(@"before setview");
	// set the view
	SEL viewSelector = NSSelectorFromString([NSString stringWithFormat:@"%@GeneralView",lowerClass]);
	[mainContainer setContentView:[self performSelector:viewSelector]];
	
	NSLog(@"after setview");
	
	// set up scope bars
	if ([[object className] isEqualToString:@"Person"]) {
		// setup scope bar
		NSMutableArray *scopeBarItems = [[NSMutableArray alloc] init];
		
		if ([object personData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"ActualPersonItem", MGSB_ITEM_IDENTIFIER, 
									  @"Person Data", MGSB_ITEM_NAME, 
									  nil]];
			if ([[object personData] personStatsID]>-1) {
				[selectedRows setObject:[NSIndexSet indexSetWithIndex:[[object personData] personStatsID]] forKey:@"personStats"];
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PersonStatsItem", MGSB_ITEM_IDENTIFIER, 
										  @"Person Stats", MGSB_ITEM_NAME, 
										  nil]];
			}
			if ([[object personData] hasRelationships]) {
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PersonRelationshipsItem", MGSB_ITEM_IDENTIFIER, 
										  @"Relationships", MGSB_ITEM_NAME, 
										  nil]];
			}
		}
		if ([object agentData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"AgentItem", MGSB_ITEM_IDENTIFIER, 
									  @"Agent Data", MGSB_ITEM_NAME, 
									  nil]];
		}
		if ([object playerData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"ActualPlayerItem", MGSB_ITEM_IDENTIFIER, 
									  @"Player Data", MGSB_ITEM_NAME, 
									  nil]];
			if ([[object playerData] playerStatsID]>-1) {
				[selectedRows setObject:[NSIndexSet indexSetWithIndex:[[object playerData] playerStatsID]] forKey:@"playerStats"];
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PlayerStatsItem", MGSB_ITEM_IDENTIFIER, 
										  @"Player Stats", MGSB_ITEM_NAME, 
										  nil]];
			}
			
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"PPMItem", MGSB_ITEM_IDENTIFIER, 
									  @"Preferred Moves", MGSB_ITEM_NAME, 
									  nil]];
			
			if ([[[object playerData] bans] count] > 0) {
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PlayerBansItem", MGSB_ITEM_IDENTIFIER, 
										  @"Bans", MGSB_ITEM_NAME, 
										  nil]];
			}
			if ([[[object playerData] injuries] count] > 0) {
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PlayerInjuriesItem", MGSB_ITEM_IDENTIFIER, 
										  @"Injuries", MGSB_ITEM_NAME, 
										  nil]];
			}
			if ([[object playerData] hasForms]) {
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"PlayerFormsItem", MGSB_ITEM_IDENTIFIER, 
										  @"Player Forms", MGSB_ITEM_NAME, 
										  nil]];
			}
		}
		if ([object nonPlayerData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"ActualNonPlayerItem", MGSB_ITEM_IDENTIFIER, 
									  @"Non-Player Data", MGSB_ITEM_NAME, 
									  nil]];
			if ([[object nonPlayerData] nonPlayingStatsID]>-1) {
				[selectedRows setObject:[NSIndexSet indexSetWithIndex:[[object nonPlayerData] nonPlayingStatsID]] forKey:@"nonPlayerStats"];
				[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
										  @"NonPlayerStatsItem", MGSB_ITEM_IDENTIFIER, 
										  @"Non-Player Stats", MGSB_ITEM_NAME, 
										  nil]];
			}
		}
		if ([object staffData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"StaffItem", MGSB_ITEM_IDENTIFIER, 
									  @"Staff Data", MGSB_ITEM_NAME, 
									  nil]];
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"ContractsItem", MGSB_ITEM_IDENTIFIER, 
									  @"Contracts", MGSB_ITEM_NAME, 
									  nil]];
		}
		if ([object officialData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"OfficialItem", MGSB_ITEM_IDENTIFIER, 
									  @"Official Data", MGSB_ITEM_NAME, 
									  nil]];
		}
		if ([object journalistData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"JournalistItem", MGSB_ITEM_IDENTIFIER, 
									  @"Journalist Data", MGSB_ITEM_NAME, 
									  nil]];
		}
		if ([object humanData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"HumanItem", MGSB_ITEM_IDENTIFIER, 
									  @"Human Data", MGSB_ITEM_NAME, 
									  nil]];
		}
		if ([object retiredPersonData]) {
			[scopeBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									  @"RetiredPersonItem", MGSB_ITEM_IDENTIFIER, 
									  @"Retired Person Data", MGSB_ITEM_NAME, 
									  nil]];
		}
		
		[personScopeBar setDelegate:self];
		
		[personSections removeAllObjects];
		
		[personSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithInt:MGRadioSelectionMode], MGSB_GROUP_SELECTION_MODE, // single selection group.
								   scopeBarItems, MGSB_GROUP_ITEMS, 
								   nil]];
		
		[personScopeBar reloadData];
		
		if ([object personData]) {
			[personContainer setContentView:actualPersonView];
		}
	}
	else if ([[object className] isEqualToString:@"Club"]) {
		// setup scope bars
		NSMutableArray *clubBarItems = [[NSMutableArray alloc] init];
		
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"GeneralItem", MGSB_ITEM_IDENTIFIER, 
								 @"General", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"KitsItem", MGSB_ITEM_IDENTIFIER, 
								 @"Kits & Colours", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"StaffItem", MGSB_ITEM_IDENTIFIER, 
								 @"Staff", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"CoefficientsItem", MGSB_ITEM_IDENTIFIER, 
								 @"Coefficients", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"FacilitiesItem", MGSB_ITEM_IDENTIFIER, 
								 @"Facilities", MGSB_ITEM_NAME, 
								 nil]];
		if ([[object finance] isValidFinance]) {
			[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									 @"FinanceItem", MGSB_ITEM_IDENTIFIER, 
									 @"Finances", MGSB_ITEM_NAME, 
									 nil]];
		}
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"IDPCItem", MGSB_ITEM_IDENTIFIER, 
								 @"IDPCs", MGSB_ITEM_NAME, 
								 nil]];
		if ([object databaseClass]==DBC_LEAGUE_BODY_CLUB) {
			[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									 @"LBC", MGSB_ITEM_IDENTIFIER, 
									 @"League Body Club Details", MGSB_ITEM_NAME, 
									 nil]];
		}
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"RegionalDivisionItem", MGSB_ITEM_IDENTIFIER, 
								 @"Regional Divisions", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"RelationshipsItem", MGSB_ITEM_IDENTIFIER, 
								 @"Relationships", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"ScoutingKnowledgeItem", MGSB_ITEM_IDENTIFIER, 
								 @"Scouting Knowledges", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"SponsorItem", MGSB_ITEM_IDENTIFIER, 
								 @"Sponsors", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"StaffItem", MGSB_ITEM_IDENTIFIER, 
								 @"Staff", MGSB_ITEM_NAME, 
								 nil]];
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"TacticsItem", MGSB_ITEM_IDENTIFIER, 
								 @"Tactics", MGSB_ITEM_NAME, 
								 nil]];
		if ([[[object teamContainer] teams] count]>0) {
			[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
									 @"TeamsItem", MGSB_ITEM_IDENTIFIER, 
									 @"Teams", MGSB_ITEM_NAME, 
									 nil]];
		}
		[clubBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 @"TrainingItem", MGSB_ITEM_IDENTIFIER, 
								 @"Training", MGSB_ITEM_NAME, 
								 nil]];
		
		[clubScopeBar setDelegate:self];
		[clubSections removeAllObjects];
		[clubSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								 [NSNumber numberWithInt:MGRadioSelectionMode], MGSB_GROUP_SELECTION_MODE, // single selection group.
								 clubBarItems, MGSB_GROUP_ITEMS, 
								 nil]];
		[clubScopeBar reloadData];
		
		// set club header bg
		[clubHeaderBackground setFillColor:[[object teamContainer] bgColour]];
		[clubHeaderBackground setHasBottomBorder:YES];
		[clubHeaderBackground setBottomBorderColor:[[object teamContainer] trimColour]];
	}
	else if ([[object className] isEqualToString:@"Nation"]) {
		// setup scope bars
		NSMutableArray *nationBarItems = [[NSMutableArray alloc] init];
		
		[nationBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   @"GeneralItem", MGSB_ITEM_IDENTIFIER, 
								   @"General", MGSB_ITEM_NAME, 
								   nil]];
		[nationBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   @"RelationshipsItem", MGSB_ITEM_IDENTIFIER, 
								   @"Relationships", MGSB_ITEM_NAME, 
								   nil]];
		
		[nationScopeBar setDelegate:self];
		[nationSections removeAllObjects];
		[nationSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithInt:MGRadioSelectionMode], MGSB_GROUP_SELECTION_MODE, // single selection group.
								   nationBarItems, MGSB_GROUP_ITEMS, 
								   nil]];
		[nationScopeBar reloadData];
	
		// set nation header bg
		[nationHeaderBackground setFillColor:[[object teamContainer] bgColour]];
		[nationHeaderBackground setHasBottomBorder:YES];
		[nationHeaderBackground setBottomBorderColor:[[object teamContainer] trimColour]];
	}
	else if ([[object className] isEqualToString:@"Award"]) {
		// setup scope bars
		NSMutableArray *awardBarItems = [[NSMutableArray alloc] init];
		
		[awardBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   @"GeneralItem", MGSB_ITEM_IDENTIFIER, 
								   @"General", MGSB_ITEM_NAME, 
								   nil]];
		[awardBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   @"RulesItem", MGSB_ITEM_IDENTIFIER, 
								   @"Rules", MGSB_ITEM_NAME, 
								   nil]];
		
		[awardScopeBar setDelegate:self];
		[awardSections removeAllObjects];
		[awardSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithInt:MGRadioSelectionMode], MGSB_GROUP_SELECTION_MODE, // single selection group.
								   awardBarItems, MGSB_GROUP_ITEMS, 
								   nil]];
		[awardScopeBar reloadData];
	
		// set header bg
		[awardHeaderBackground setFillColor:[[object colour] backgroundColour]];
		[awardHeaderBackground setHasBottomBorder:YES];
		[awardHeaderBackground setBottomBorderColor:[[object colour] trimColour]];
	}
	else if ([[object className] isEqualToString:@"Competition"]) {
		// set header bg
		[competitionHeaderBackground setFillColor:[[object colour] backgroundColour]];
		[competitionHeaderBackground setHasBottomBorder:YES];
		[competitionHeaderBackground setBottomBorderColor:[[object colour] trimColour]];
	}
	
	// deselect outline view rows
	[mainOutlineView deselectAll:self];
	NSLog(@"done select");
}

- (void)addToFavourites:(id)sender
{
	if (!sender) { return; }
	
	NSMutableDictionary *newFavourite = [[NSMutableDictionary alloc] init];
	
	if ([[sender className] isEqualToString:@"Award"]) {
		[newFavourite setObject:@"Award-s" forKey:@"image"];
		[newFavourite setObject:@"awards" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"City"]) {
		[newFavourite setObject:@"City-s" forKey:@"image"];
		[newFavourite setObject:@"cities" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Club"]) {
		[newFavourite setObject:@"Club-s" forKey:@"image"];
		[newFavourite setObject:@"clubs" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Competition"]) {
		[newFavourite setObject:@"Competition-s" forKey:@"image"];
		[newFavourite setObject:@"competitions" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Continent"]) {
		[newFavourite setObject:@"Continent-s" forKey:@"image"];
		[newFavourite setObject:@"continents" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Currency"]) {
		[newFavourite setObject:@"Currency-s" forKey:@"image"];
		[newFavourite setObject:@"currencies" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Injury"]) {
		[newFavourite setObject:@"Injury-s" forKey:@"image"];
		[newFavourite setObject:@"injuries" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Language"]) {
		[newFavourite setObject:@"Language-s" forKey:@"image"];
		[newFavourite setObject:@"languages" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"LocalArea"]) {
		[newFavourite setObject:@"LocalArea-s" forKey:@"image"];
		[newFavourite setObject:@"localAreas" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"LocalArea"]) {
		[newFavourite setObject:@"Media-s" forKey:@"image"];
		[newFavourite setObject:@"media" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"LocalArea"]) {
		[newFavourite setObject:@"Nation-s" forKey:@"image"];
		[newFavourite setObject:@"nations" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Person"]) {
		[newFavourite setObject:@"Person-s" forKey:@"image"];
		[newFavourite setObject:@"people" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Sponsor"]) {
		[newFavourite setObject:@"Sponsor-s" forKey:@"image"];
		[newFavourite setObject:@"sponsors" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Stadium"]) {
		[newFavourite setObject:@"Stadium-s" forKey:@"image"];
		[newFavourite setObject:@"stadiums" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Stadium"]) {
		[newFavourite setObject:@"Stadium-s" forKey:@"image"];
		[newFavourite setObject:@"stadiumChanges" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	else if ([[sender className] isEqualToString:@"Weather"]) {
		[newFavourite setObject:@"Weather-s" forKey:@"image"];
		[newFavourite setObject:@"weather" forKey:@"array"];
		[newFavourite setObject:[NSNumber numberWithInt:[sender rowID]] forKey:@"row"];
		[newFavourite setObject:[sender name] forKey:@"title"];
	}
	[newFavourite setObject:[controller gamePath] forKey:@"game"];
	[newFavourite setObject:@"1" forKey:@"subsection"];
	[newFavourite setObject:@"1" forKey:@"favourite"];
	
	// add to view
	if ([[sections objectAtIndex:1] objectForKey:@"subsections"]!=nil) {
		id item;
		BOOL containsObject = FALSE;
		NSEnumerator *oEnum = [[[sections objectAtIndex:1] objectForKey:@"subsections"] objectEnumerator];
		while (item = [oEnum nextObject]) {
			if ([[item objectForKey:@"array"] isEqualToString:[newFavourite objectForKey:@"array"]] &&
				[[item objectForKey:@"row"] intValue] == [sender rowID] &&
				[[item objectForKey:@"game"] isEqualToString:[controller gamePath]]) {
				containsObject = TRUE;
			}
		}
		if (!containsObject) {
			[[[sections objectAtIndex:1] objectForKey:@"subsections"] addObject:newFavourite];
		}
	}
	else {
		NSMutableArray *subsections = [[NSMutableArray alloc] init];
		[subsections addObject:newFavourite];
		[[sections objectAtIndex:1] setObject:subsections forKey:@"subsections"];
		[subsections release];
	}
	
	[newFavourite release];
	
	[self reloadOutlineView];
}

-(IBAction)showGameInfo:(id)sender
{
	[mainContainer setContentView:gameInfoView];
}

- (void)performSpaceKeyPress:(id)sender
{
	if ([sender selectedRow]==-1) { return; }
	
	if (sender==playerScoutResultsTable) {
		[playerScoutPreviewPanel makeKeyAndOrderFront:self];
	}
}

#pragma mark MGScopeBarDelegate methods

- (int)numberOfGroupsInScopeBar:(MGScopeBar *)theScopeBar
{
	if (theScopeBar==clubScopeBar) { return [clubSections count]; }
	else if (theScopeBar==awardScopeBar) { return [awardSections count]; }
	else if (theScopeBar==nationScopeBar) { return [nationSections count]; }
	else if (theScopeBar==personScopeBar) { return [personSections count]; }
	return 0;
}


- (NSArray *)scopeBar:(MGScopeBar *)theScopeBar itemIdentifiersForGroup:(int)groupNumber
{
	if (theScopeBar==clubScopeBar) { 
		return [[clubSections objectAtIndex:groupNumber] valueForKeyPath:[NSString stringWithFormat:@"%@.%@", MGSB_GROUP_ITEMS, MGSB_ITEM_IDENTIFIER]];
	}
	else if (theScopeBar==awardScopeBar) { 
		return [[awardSections objectAtIndex:groupNumber] valueForKeyPath:[NSString stringWithFormat:@"%@.%@", MGSB_GROUP_ITEMS, MGSB_ITEM_IDENTIFIER]];
	}
	else if (theScopeBar==nationScopeBar) { 
		return [[nationSections objectAtIndex:groupNumber] valueForKeyPath:[NSString stringWithFormat:@"%@.%@", MGSB_GROUP_ITEMS, MGSB_ITEM_IDENTIFIER]];
	}
	else if (theScopeBar==personScopeBar) { 
		return [[personSections objectAtIndex:groupNumber] valueForKeyPath:[NSString stringWithFormat:@"%@.%@", MGSB_GROUP_ITEMS, MGSB_ITEM_IDENTIFIER]];
	}
	return nil;
}


- (NSString *)scopeBar:(MGScopeBar *)theScopeBar labelForGroup:(int)groupNumber
{
	if (theScopeBar==clubScopeBar) { 
		return [[clubSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_LABEL]; // might be nil, which is fine (nil means no label).
	}
	else if (theScopeBar==awardScopeBar) { 
		return [[awardSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_LABEL]; // might be nil, which is fine (nil means no label).
	}
	else if (theScopeBar==nationScopeBar) { 
		return [[nationSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_LABEL]; // might be nil, which is fine (nil means no label).
	}
	else if (theScopeBar==personScopeBar) { 
		return [[personSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_LABEL]; // might be nil, which is fine (nil means no label).
	}
	return @"---";
}


- (NSString *)scopeBar:(MGScopeBar *)theScopeBar titleOfItem:(NSString *)identifier inGroup:(int)groupNumber
{
	if (theScopeBar==clubScopeBar) { 
		NSArray *items = [[clubSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_ITEMS];
		if (items) {
			for (NSDictionary *item in items) {
				if ([[item objectForKey:MGSB_ITEM_IDENTIFIER] isEqualToString:identifier]) {
					return [item objectForKey:MGSB_ITEM_NAME];
					break;
				}
			}
		}
	}
	else if (theScopeBar==awardScopeBar) { 
		NSArray *items = [[awardSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_ITEMS];
		if (items) {
			for (NSDictionary *item in items) {
				if ([[item objectForKey:MGSB_ITEM_IDENTIFIER] isEqualToString:identifier]) {
					return [item objectForKey:MGSB_ITEM_NAME];
					break;
				}
			}
		}
	}
	else if (theScopeBar==nationScopeBar) { 
		NSArray *items = [[nationSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_ITEMS];
		if (items) {
			for (NSDictionary *item in items) {
				if ([[item objectForKey:MGSB_ITEM_IDENTIFIER] isEqualToString:identifier]) {
					return [item objectForKey:MGSB_ITEM_NAME];
					break;
				}
			}
		}
	}
	else if (theScopeBar==personScopeBar) { 
		NSArray *items = [[personSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_ITEMS];
		if (items) {
			// We'll iterate here, since this is just a demo. This avoids having to keep an NSDictionary of identifiers 
			// for each group as well as an array for ordering. In a more realistic scenario, you'd probably want to be 
			// able to look-up an item by its identifier in constant time.
			for (NSDictionary *item in items) {
				if ([[item objectForKey:MGSB_ITEM_IDENTIFIER] isEqualToString:identifier]) {
					return [item objectForKey:MGSB_ITEM_NAME];
					break;
				}
			}
		}
	}
	return nil;
}


- (MGScopeBarGroupSelectionMode)scopeBar:(MGScopeBar *)theScopeBar selectionModeForGroup:(int)groupNumber
{
	if (theScopeBar==clubScopeBar) { 
		return [[[clubSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SELECTION_MODE] intValue];
	}
	else if (theScopeBar==awardScopeBar) { 
		return [[[awardSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SELECTION_MODE] intValue];
	}
	else if (theScopeBar==nationScopeBar) { 
		return [[[nationSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SELECTION_MODE] intValue];
	}
	else if (theScopeBar==personScopeBar) { 
		return [[[personSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SELECTION_MODE] intValue];
	}
	return MGRadioSelectionMode;
}


- (BOOL)scopeBar:(MGScopeBar *)theScopeBar showSeparatorBeforeGroup:(int)groupNumber
{
	// Optional method. If not implemented, all groups except the first will have a separator before them.
	if (theScopeBar==clubScopeBar) {
		return [[[clubSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SEPARATOR] boolValue];
	}
	else if (theScopeBar==awardScopeBar) {
		return [[[awardSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SEPARATOR] boolValue];
	}
	else if (theScopeBar==nationScopeBar) {
		return [[[nationSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SEPARATOR] boolValue];
	}
	else if (theScopeBar==personScopeBar) {
		return [[[personSections objectAtIndex:groupNumber] objectForKey:MGSB_GROUP_SEPARATOR] boolValue];
	}
	return TRUE;
}


- (NSImage *)scopeBar:(MGScopeBar *)scopeBar imageForItem:(NSString *)identifier inGroup:(int)groupNumber
{
	// Optional method. If not implemented (or if you return nil), items will not have an image.
	
	return nil;
}


- (NSView *)accessoryViewForScopeBar:(MGScopeBar *)scopeBar
{
	// Optional method. If not implemented (or if you return nil), the scope-bar will not have an accessory view.
	return FALSE;
}

- (void)scopeBar:(MGScopeBar *)theScopeBar selectedStateChanged:(BOOL)selected 
		 forItem:(NSString *)identifier inGroup:(int)groupNumber
{
	NSString *section = [self scopeBar:theScopeBar titleOfItem:identifier inGroup:groupNumber];
	if (theScopeBar==clubScopeBar) {
		if ([section isEqualToString:@"General"]) { [clubContainer setContentView:clubMainView]; }
		else if ([section isEqualToString:@"IDPCs"]) { [clubContainer setContentView:clubIDPCView]; }
		else if ([section isEqualToString:@"Staff"]) { [clubContainer setContentView:clubStaffView]; }
		else if ([section isEqualToString:@"Kits & Colours"]) { [clubContainer setContentView:clubKitView]; }
		else if ([section isEqualToString:@"Finances"]) { [clubContainer setContentView:clubFinanceView]; }
		else if ([section isEqualToString:@"League Body Club Details"]) { [clubContainer setContentView:clubLBCView]; }
		else if ([section isEqualToString:@"Facilities"]) { [clubContainer setContentView:clubFacilitiesView]; }
		else if ([section isEqualToString:@"Shortlisted People"]) { [clubContainer setContentView:clubShortlistedPeopleView]; }
		else if ([section isEqualToString:@"Scouting Knowledges"]) { [clubContainer setContentView:clubScoutingKnowledgeView]; }
		else if ([section isEqualToString:@"Regional Divisions"]) { [clubContainer setContentView:clubRegionalDivisionsView]; }
		else if ([section isEqualToString:@"Sponsors"]) { [clubContainer setContentView:clubSponsorView]; }
		else if ([section isEqualToString:@"Tactics"]) { [clubContainer setContentView:clubTacticsView]; }
		else if ([section isEqualToString:@"Teams"]) { [clubContainer setContentView:clubTeamsView]; }
		else if ([section isEqualToString:@"Training"]) { [clubContainer setContentView:clubTrainingView]; }
		else if ([section isEqualToString:@"Coefficients"]) { [clubContainer setContentView:clubCoefficientView]; }
		else if ([section isEqualToString:@"Relationships"]) { [clubContainer setContentView:clubRelationshipsView]; }
	}
	else if (theScopeBar==awardScopeBar) {
		if ([section isEqualToString:@"General"]) { [awardContainer setContentView:awardMainView]; }
		else if ([section isEqualToString:@"Rules"]) { [awardContainer setContentView:awardRulesView]; }
	}
	else if (theScopeBar==nationScopeBar) {
		if ([section isEqualToString:@"General"]) { [nationContainer setContentView:nationMainView]; }
		else if ([section isEqualToString:@"Relationships"]) { [nationContainer setContentView:nationRelationshipsView]; }
	}
	else if (theScopeBar==personScopeBar) {
		if ([section isEqualToString:@"Person Data"]) { [personContainer setContentView:actualPersonView]; }
		else if ([section isEqualToString:@"Person Stats"]) { [personContainer setContentView:personStatsView]; }
		else if ([section isEqualToString:@"Player Data"]) { [personContainer setContentView:actualPlayerView]; }
		else if ([section isEqualToString:@"Player Stats"]) { [personContainer setContentView:playerStatsView]; }
		else if ([section isEqualToString:@"Preferred Moves"]) { [personContainer setContentView:ppmView]; }
		else if ([section isEqualToString:@"Player Forms"]) { [personContainer setContentView:playerFormView]; }
		else if ([section isEqualToString:@"Bans"]) { [personContainer setContentView:playerBanView]; }
		else if ([section isEqualToString:@"Injuries"]) { [personContainer setContentView:playerInjuryView]; }
		else if ([section isEqualToString:@"Contracts"]) { [personContainer setContentView:contractView]; }
		else if ([section isEqualToString:@"Non-Player Data"]) { [personContainer setContentView:actualNonPlayerView]; }
		else if ([section isEqualToString:@"Non-Player Stats"]) { [personContainer setContentView:nonPlayerStatsView]; }
		else if ([section isEqualToString:@"Staff Data"]) { [personContainer setContentView:actualStaffView]; }
		else if ([section isEqualToString:@"Official Data"]) { [personContainer setContentView:officialView]; }
		else if ([section isEqualToString:@"Journalist Data"]) { [personContainer setContentView:journalistView]; }
		else if ([section isEqualToString:@"Retired Person Data"]) { [personContainer setContentView:retiredPersonView]; }
		else if ([section isEqualToString:@"Human Data"]) { [personContainer setContentView:humanView]; }
		else if ([section isEqualToString:@"Relationships"]) { [personContainer setContentView:personRelationshipsView]; }
		else if ([section isEqualToString:@"Agent Data"]) { [personContainer setContentView:agentView]; }
	}
}

#pragma mark Scout Functions

- (IBAction)importShortlist:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"slf",nil]];
	[op setDirectory:DEFAULT_SHORTLIST_LOCATION];
	
	int result = [op runModal];
	
	if (result==NSFileHandlingPanelOKButton) {
		NSData *shortlistData = [[NSData alloc] initWithContentsOfFile:[op filename]];
		
		// skip header
		unsigned int offset = 2;
		
		// check it is actually an slf file
		if (![[SupportFunctions readCStringFromData:shortlistData atOffset:&offset length:4] isEqualToString:@"fls."]) {
			// If it isn't, alert user
			NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid Shortlist", @"error - invalid shortlist") defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This does not appear to be a valid FM shortlist",@"error - not an FM shortlist")];
			[alert runModal];
			return;
		}
		
		// skip down to players
		offset += 8;
		[FMString readFromData:shortlistData atOffset:&offset];
		
		unsigned int count, ibuffer;
		NSMutableArray *shortlistIDs = [[NSMutableArray alloc] init];
		[shortlistData getBytes:&count range:NSMakeRange(offset, 4)]; offset += 4;
		for (int i=0; i<count; i++) {
			[shortlistData getBytes:&ibuffer range:NSMakeRange(offset, 4)]; offset += 4;
			[shortlistIDs addObject:[NSNumber numberWithInt:ibuffer]];
		}
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"UID IN %@",shortlistIDs];
		NSMutableArray *playerResults = [[NSMutableArray alloc] initWithArray:[[[controller database] people] filteredArrayUsingPredicate:predicate]];
		[self setPlayerScoutResults:playerResults];
		[playerResults release];
		[shortlistIDs release];
	}
}

- (IBAction)exportShortlist:(id)sender
{
	// return an error if the shortlist is empty
	if ([activeShortlist count]==0) {
		NSAlert *alert = [NSAlert alertWithMessageText:@"Shortlist Empty" defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:@"You can't save an empty shortlist"];
		[alert runModal];
		return;
	}
	
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"slf",nil]];
	[op setDirectory:DEFAULT_SHORTLIST_LOCATION];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		
	}
}

- (void)saveShortlist:(NSArray *)players atPath:(NSString *)path
{
	Byte header[2]	= { 0x02, 0x01 };
	char cbuffer;
	short sbuffer;
	int ibuffer;
	
	NSMutableData *shortlist = [[NSMutableData alloc] initWithBytes:&header length:sizeof(header)];

	[SupportFunctions saveCString:@"fls." toData:shortlist];
	
	// file version
	sbuffer = 1;
	[shortlist appendBytes:&sbuffer length:2];
	
	// ???
	cbuffer = 0;
	[shortlist appendBytes:&cbuffer length:1];
	
	// ???
	cbuffer = 1;
	[shortlist appendBytes:&cbuffer length:1];
	
	// unique game ID
	ibuffer = [controller gameID];
	[shortlist appendBytes:&ibuffer length:4];
	
	// shortlist name
	[FMString saveString:[[path lastPathComponent] stringByDeletingPathExtension] toData:shortlist];
	
	// players count
	ibuffer = [players count];
	[shortlist appendBytes:&ibuffer length:4];
	
	// players
	for (int i = 0;i<[players count]; i++) 
	{
		ibuffer = [[players objectAtIndex:i] UID];
		[shortlist appendBytes:&ibuffer length:4];
	}
	
	// ???
	cbuffer = 0;
	[shortlist appendBytes:&cbuffer length:1];
	
	// write the data to a file
	if (![[NSFileManager defaultManager] createFileAtPath:path contents:shortlist attributes:nil]) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Unable To Save Shortlist",@"error saving shortlist") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"The shortlist could not be saved.",@"error saving shortlist")];
		[alert runModal];
	}
	
	[shortlist release];
}

- (IBAction)saveAllScoutResultsToShortlist:(id)sender
{
	if ([playerScoutResults count]==0) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"No Players In Scout Results",@"error - saving all scout results to shortlist") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"There are no players in the current scout results to save",@"error - saving all scout results to shortlist")];
		[alert runModal];
		return;
	}
	
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"slf",nil]];
	[op setDirectory:DEFAULT_SHORTLIST_LOCATION];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		// save the array
		[self saveShortlist:playerScoutResults atPath:[op filename]];
	}
}

- (IBAction)saveSelectedScoutResultsToShortlist:(id)sender
{
	NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
	
	NSIndexSet *indexSet = [playerScoutResultsTable selectedRowIndexes];
	for (NSUInteger index = [indexSet firstIndex]; index != NSNotFound; index = [indexSet indexGreaterThanIndex:index]) {
		if ([playerScoutResults count]>index) {
			[selectedArray addObject:[playerScoutResults objectAtIndex:index]];
		}
	}
	
	if ([selectedArray count]==0) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"No Players In Scout Results",@"error - saving all scout results to shortlist") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"There are no players in the current scout results to save",@"error - saving all scout results to shortlist")];
		[alert runModal];
		return;
	}
	
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"slf",nil]];
	[op setDirectory:DEFAULT_SHORTLIST_LOCATION];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		// save the array
		[self saveShortlist:selectedArray atPath:[op filename]];
	}
}

- (IBAction)loadSearch:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"sxs",nil]];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		NSData *data = [[NSData alloc] initWithContentsOfFile:[op filename]];
		
		unsigned int offset = 0;
		
		if (![[SupportFunctions readCStringFromData:data atOffset:&offset length:4] isEqualToString:@"sxs."]) {
			// If it isn't, alert user
			NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid Search File", @"error - invalid search file") defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This does not appear to be a valid FMSX search file",@"error - not an FMSX search file")];
			[alert runModal];
			return;
		}
		
		char type, version;
		[data getBytes:&version range:NSMakeRange(offset, 1)]; offset += 1;
		
		if (version < SXS_VERSION) {
			NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid Search Version", @"error - invalid search file") defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This appears to be an outdated FMSX search file",@"error - outdated FMSX search file")];
			[alert runModal];
			return;
		}
		
		[data getBytes:&type range:NSMakeRange(offset, 1)]; offset += 1;
		
		if (type!=SCTY_STAFF && type!=SCTY_PLAYER) {
			// If it isn't, alert user
			NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid Search File", @"error - invalid search file") defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This does not appear to be a valid FMSX search file",@"error - not an FMSX search file")];
			[alert runModal];
			return;
		}
		
		NSString *savedExpression = [FMString readFromData:data atOffset:&offset];
		
		NSPredicate *predicate = [NSPredicate predicateWithFormat:savedExpression];
		NSLog(@"saved predicate: %@",savedExpression);
		
		NSMutableArray *results = [[NSMutableArray alloc] init];
		[results addObjectsFromArray:[[[controller database] people] filteredArrayUsingPredicate:predicate]];
		NSLog(@"%d results",[results count]);
		
		if (type==SCTY_STAFF) { 
			[scoutSectionControl selectSegmentWithTag:SCTY_STAFF]; 
			[scoutSectionTabView selectTabViewItemAtIndex:SCTY_STAFF];
			[self setStaffScoutResults:results]; 
		}
		else if (type==SCTY_PLAYER) { 
			[scoutSectionControl selectSegmentWithTag:SCTY_PLAYER]; 
			[scoutSectionTabView selectTabViewItemAtIndex:SCTY_PLAYER];
			[self setPlayerScoutResults:results]; 
		}
		
		[results release];
	}
}
- (IBAction)saveSearch:(id)sender
{
	char type = [scoutSectionControl selectedSegment];
	char version = SXS_VERSION;
	
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"sxs",nil]];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		NSMutableData *data = [[NSMutableData alloc] init];
		
		[SupportFunctions saveCString:@"sxs." toData:data];
		[data appendBytes:&version length:1];
		[data appendBytes:&type length:1];
		
		if (type==SCTY_STAFF) { [FMString saveString:currentStaffExpression toData:data]; }
		else if (type==SCTY_PLAYER) { [FMString saveString:currentPlayerExpression toData:data]; }
		
		if (![[NSFileManager defaultManager] createFileAtPath:[op filename] contents:data attributes:nil]) {
			NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Unable To Save Search",@"error saving search") defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"The search could not be saved.",@"error saving search")];
			[alert runModal];
		}
		[data release];
	}
}

- (IBAction)scoutClubs:(id)sender
{
	NSMutableArray *teamResults = [[NSMutableArray alloc] init];
	NSMutableString *expression = [[NSMutableString alloc] init];
	NSMutableString *bexpression;
	
	if ([[clubScoutCompSearchField stringValue] length] > 0) {
		NSMutableArray *compResults = [[NSMutableArray alloc] init];
		bexpression = [[NSMutableString alloc] init];
		// enclose the comp expression
		[expression appendString:@"("];
		
		 // find comps with that name
		[bexpression appendFormat:@"(name contains[cd] '%@')",[clubScoutCompSearchField stringValue]];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:bexpression];
		[compResults addObjectsFromArray:[[[controller database] competitions] filteredArrayUsingPredicate:predicate]]; 
		[bexpression release];
		
		// find teams in that competition
		for (int i = 0; i<[compResults count]; i++) {
			[expression appendFormat:@"(divisionID = %d)", [[compResults objectAtIndex:i] rowID]];
			if (i<([compResults count]-1)) { [expression appendString:@" OR "]; }
		}
		// close the comp expression
		[expression appendString:@")"];
		
	//	NSLog(@"predicate comps: %@",expression);
		[compResults release];
	}
	if ([[clubScoutNationSearchField stringValue] length] > 0) {
		NSMutableArray *nationResults = [[NSMutableArray alloc] init];
		bexpression = [[NSMutableString alloc] init];
		
		if ([[clubScoutCompSearchField stringValue] length] > 0) {
			[expression appendString:@" AND "];
		}
		
		// find nations with that name
		[bexpression appendFormat:@"(teamContainer.name contains[cd] '%@')",[clubScoutNationSearchField stringValue]];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:bexpression];
		[nationResults addObjectsFromArray:[[[controller database] nations] filteredArrayUsingPredicate:predicate]]; 
		[bexpression release];
		NSLog(@"%d nations",[nationResults count]);
		
		// enclose the nation expression
		[expression appendString:@"("];
		
		// find teams in that nation
		for (int i = 0; i<[nationResults count]; i++) {
			[expression appendFormat:@"(databaseClass==%d) AND (club.nationID = %d)", DBC_TEAM, [[nationResults objectAtIndex:i] rowID]];
			if (i<([nationResults count]-1)) { [expression appendString:@" OR "]; }
		}
		// close the nation expression
		[expression appendString:@")"];
		[nationResults release];
	}
	if ([[clubScoutClubSearchField stringValue] length] > 0) {
		NSMutableArray *clubResults = [[NSMutableArray alloc] init];
		bexpression = [[NSMutableString alloc] init];
 
		if ([[clubScoutCompSearchField stringValue] length] > 0 ||
			[[clubScoutNationSearchField stringValue] length] > 0) {
			[expression appendString:@" AND "];
		}
 
		// find clubs with that name
		[bexpression appendFormat:@"(teamContainer.name contains[cd] '%@')",[clubScoutClubSearchField stringValue]];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:bexpression];
		[clubResults addObjectsFromArray:[[[controller database] clubs] filteredArrayUsingPredicate:predicate]]; 
		[bexpression release];
		NSLog(@"%d clubs",[clubResults count]);
 
		// enclose the club expression
		[expression appendString:@"("];
 
		// find teams in that club
		for (int i = 0; i<[clubResults count]; i++) {
			[expression appendFormat:@"(teamContainerID = %d)", [[clubResults objectAtIndex:i] rowID]];
			if (i<([clubResults count]-1)) { [expression appendString:@" OR "]; }
		}
		// close the club expression
		[expression appendString:@")"];
		[clubResults release];
	}
	
	if ([expression length] > 0) {
		[expression appendString:@" AND (databaseClass = 10)"];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:expression];
		NSLog(@"final predicate: %@",expression);
		[teamResults addObjectsFromArray:[[[controller database] teams] filteredArrayUsingPredicate:predicate]];
		[self setClubScoutResults:teamResults];
	}
}

- (IBAction)scoutStaff:(id)sender
{
	NSMutableArray *staffResults = [[NSMutableArray alloc] init];
	NSMutableString *expression = [[NSMutableString alloc] init];
	
	if ([[staffTextSearchField stringValue] length] > 0) {
		[expression appendFormat:@"((name contains[cd] '%@') OR (teamString contains[cd] '%@') OR (nationString contains[cd] '%@'))",
		 [staffTextSearchField stringValue], [staffTextSearchField stringValue],
		 [staffTextSearchField stringValue]];
	}
	
	if ([[[staffScoutPersonalAttributeEditor predicate] predicateFormat] length] > 0 &&
		[staffScoutPersonalAttributeEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[staffScoutPersonalAttributeEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	
	if ([[[staffScoutStatEditor predicate] predicateFormat] length] > 0 &&
		[staffScoutStatEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[staffScoutStatEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	
	if ([staffScoutContractExpiryBox indexOfSelectedItem]>0) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		if ([staffScoutContractExpiryBox indexOfSelectedItem]==1) {
			[expression appendString:@"(contractIsExpired = YES)"];
		}
		else if ([staffScoutContractExpiryBox indexOfSelectedItem]==2) {
			[expression appendString:@"(contractIsExpiring = YES)"];
		}
		else if ([staffScoutContractExpiryBox indexOfSelectedItem]==3) {
			[expression appendString:@"(staffData.contracts.@count = 0) AND (staffData.clubTeamID = -1)"];
		}
	}
	
	if ([staffScoutShowECStaffOnlyBox state]==NSOnState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(isECNational = TRUE)"];
	}
	
	if ([staffScoutRegenButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.isRegen = FALSE)"];
	}
	
	if ([staffScoutNonRegenButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.isRegen = TRUE)"];
	}
	
	if ([staffScoutFemaleButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.female = FALSE)"];
	}
	
	if ([staffScoutMaleButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.male = FALSE)"];
	}
	
	if ([expression length] > 0) {
		[expression appendString:@" AND (nonPlayerData != NIL)"];
		[self setCurrentStaffExpression:expression];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:expression];
		NSLog(@"final predicate: %@",expression);
		[staffResults addObjectsFromArray:[[[controller database] people] filteredArrayUsingPredicate:predicate]];
		[self setStaffScoutResults:staffResults];
	}
	
	[expression release];
}

- (IBAction)scoutPlayers:(id)sender
{
	NSMutableArray *playerResults = [[NSMutableArray alloc] init];
	NSMutableString *expression = [[NSMutableString alloc] init];
	
	if ([[playerTextSearchField stringValue] length] > 0) {
		[expression appendFormat:@"((name contains[cd] '%@') OR (teamString contains[cd] '%@') OR (nationString contains[cd] '%@'))",
		 [playerTextSearchField stringValue], [playerTextSearchField stringValue],
		 [playerTextSearchField stringValue]];
	}
	
	if ([[[playerScoutPersonalAttributeEditor predicate] predicateFormat] length] > 0 &&
		[playerScoutPersonalAttributeEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[playerScoutPersonalAttributeEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	if ([[[playerScoutTechnicalAttributeEditor predicate] predicateFormat] length] > 0 &&
		[playerScoutTechnicalAttributeEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[playerScoutTechnicalAttributeEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	if ([[[playerScoutPhysicalAttributeEditor predicate] predicateFormat] length] > 0 &&
		[playerScoutPhysicalAttributeEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[playerScoutPhysicalAttributeEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	if ([[[playerScoutMentalAttributeEditor predicate] predicateFormat] length] > 0 &&
		[playerScoutMentalAttributeEditor numberOfRows]>1) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendFormat:@"(%@)",[[[playerScoutMentalAttributeEditor predicate] predicateFormat] stringByReplacingOccurrencesOfString:@"\"" withString:@""]];
	}
	
	if ([playerScoutContractExpiryBox indexOfSelectedItem]>0) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		if ([playerScoutContractExpiryBox indexOfSelectedItem]==1) {
			[expression appendString:@"(contractIsExpired = YES)"];
		}
		else if ([playerScoutContractExpiryBox indexOfSelectedItem]==2) {
			[expression appendString:@"(contractIsExpiring = YES)"];
		}
		else if ([playerScoutContractExpiryBox indexOfSelectedItem]==3) {
			[expression appendString:@"(staffData.contracts.@count = 0) AND (staffData.clubTeamID = -1)"];
		}
	}
	
	if ([playerScoutTransferStatusBox indexOfSelectedItem]>0) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		if ([playerScoutTransferStatusBox indexOfSelectedItem]==1) {
			[expression appendString:@"(isTransferListed = YES)"];
		}
		else if ([playerScoutTransferStatusBox indexOfSelectedItem]==2) {
			[expression appendString:@"(isListedForLoan = YES)"];
		}
	}
	
	if ([playerScoutRegenButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.isRegen = FALSE)"];
	}
	
	if ([playerScoutNonRegenButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.isRegen = TRUE)"];
	}
	
	if ([playerScoutFemaleButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.female = FALSE)"];
	}
	
	if ([playerScoutMaleButton state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(personData.male = FALSE)"];
	}
	
	if ([playerScoutShowECPlayersOnlyBox state]==NSOnState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(isECNational = TRUE)"];
	}
	
	if ([playerScoutShowInjuredBox state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(playerData.injuries.@count = 0)"];
	}
	
	if ([playerScoutShowBannedBox state]==NSOffState) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		[expression appendString:@"(playerData.bans.@count = 0)"];
	}
	
	if ([playerScoutPositionBox indexOfSelectedItem] > 0) {
		if ([expression length] > 0) { [expression appendString:@" AND "]; }
		if ([playerScoutPositionBox indexOfSelectedItem]==1) {
			[expression appendString:@"(playerStats.goalkeeper >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==2) {
			[expression appendString:@"(playerStats.sweeper >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==3) {
			[expression appendString:@"(playerStats.leftDefender >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==4) {
			[expression appendString:@"(playerStats.rightDefender >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==5) {
			[expression appendString:@"(playerStats.centralDefender >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==6) {
			[expression appendString:@"(playerStats.leftWingBack >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==7) {
			[expression appendString:@"(playerStats.rightWingBack >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==8) {
			[expression appendString:@"(playerStats.centralDefensiveMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==9) {
			[expression appendString:@"(playerStats.leftMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==10) {
			[expression appendString:@"(playerStats.rightMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==11) {
			[expression appendString:@"(playerStats.centralMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==12) {
			[expression appendString:@"(playerStats.leftAttackingMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==13) {
			[expression appendString:@"(playerStats.rightAttackingMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==14) {
			[expression appendString:@"(playerStats.centralAttackingMidfielder >= 15)"]; 
		}
		else if ([playerScoutPositionBox indexOfSelectedItem]==15) {
			[expression appendString:@"(playerStats.centreForward >= 15)"]; 
		}
	}
	
	if ([expression length] > 0) {
		[expression appendString:@" AND (playerData != NIL)"];
		[self setCurrentPlayerExpression:expression];
		NSPredicate *predicate = [NSPredicate predicateWithFormat:expression];
		NSLog(@"final predicate: %@",expression);
		[playerResults addObjectsFromArray:[[[controller database] people] filteredArrayUsingPredicate:predicate]];
		NSLog(@"%d results",[playerResults count]);
		[self setPlayerScoutResults:playerResults];
	}
	
	[expression release];
}

- (void)exportPlayersToCSV:(NSMutableArray *)array
{
	NSMutableString *csv = [[NSMutableString alloc] initWithString:@"\"Row ID\",\"UID\",\"Name\",\"Team\",\"Nation\",\"Age\",\"Position\",\"CA\",\"PA\",\"Home Rep\",\"Current Rep\",\"World Rep\",\"Condition\",\"Value\",\"Asking Price\",\"GP\"\n"];
	
	for (Person *item in array) {
		[csv appendFormat:@"\"%d\",\"%d\",\"%@\",\"%@\",\"%@\",\"%d\",\"%@\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%d\",\"%f\"\n",
			[item rowID],[item UID],[item name],[item teamString],[item nationString],[item age],
			[item positionString],[[item playerData] currentAbility],[[item playerData] potentialAbility],
			[[item playerData] homeReputation],[[item playerData] currentReputation],[[item playerData] worldReputation],
			[[item playerData] conditionPercent], [[item playerData] value],[[item playerData] askingPrice]],
			[item playerGrowthPotentialVal];
	}
	
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"csv",nil]];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		NSData *csvData = [csv dataUsingEncoding:NSUnicodeStringEncoding];
		NSLog(@"%d",[csvData length]);
		[[NSFileManager defaultManager] createFileAtPath:[op filename] contents:csvData attributes:nil];
	}
}

- (void)addRelationship:(id)sender
{
	
}

- (IBAction)showNationPicker:(id)sender
{
	nationPickerSelector = @"";
	[nationPicker openSheet:self];
	if ([sender tag]==1) { nationPickerSelector = @"nationID"; }
	else if ([sender tag]==2) { nationPickerSelector = @"basedNationID"; }
}

- (IBAction)setNationPickerObject:(id)object
{
	nationPickerObject = object;
}

- (IBAction)pickNation:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[nationPickerSelector substringToIndex:1] capitalizedString],
											 [nationPickerSelector substringFromIndex:1]]);
	
	[nationPickerObject performSelector:thisSelector withObject:[[[nationPickerController arrangedObjects] objectAtIndex:[nationPickerController selectionIndex]] rowID]];
	
	[nationPicker closeSheet:self];
}

- (IBAction)showStadiumPicker:(id)sender
{
	stadiumPickerSelector = @"";
	[stadiumPicker openSheet:self];
	if ([sender tag]==1)		{ stadiumPickerSelector = @"stadiumID"; }
	else if ([sender tag]==2)	{ stadiumPickerSelector = @"oldStadiumID"; }
	else if ([sender tag]==3)	{ stadiumPickerSelector = @"newStadiumID"; }
	else if ([sender tag]==4)	{ stadiumPickerSelector = @"alternativeStadiumID"; }
	else if ([sender tag]==5)	{ stadiumPickerSelector = @"nearbyStadiumID"; }
	else if ([sender tag]==6)	{ stadiumPickerSelector = @"firstMatchStadiumID"; }
	else if ([sender tag]==7)	{ stadiumPickerSelector = @"nationalStadiumID"; }
}

- (IBAction)setStadiumPickerObject:(id)object { stadiumPickerObject = object; }

- (IBAction)pickStadium:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[stadiumPickerSelector substringToIndex:1] capitalizedString],
											 [stadiumPickerSelector substringFromIndex:1]]);
	
	[stadiumPickerObject performSelector:thisSelector withObject:[[[stadiumPickerController arrangedObjects] objectAtIndex:[stadiumPickerController selectionIndex]] rowID]];
	
	[stadiumPicker closeSheet:self];
}

- (IBAction)showCompetitionPicker:(id)sender
{
	competitionPickerSelector = @"";
	[competitionPicker openSheet:self];
	if ([sender tag]==1)		{ competitionPickerSelector = @"competitionID"; }
	else if ([sender tag]==2)	{ competitionPickerSelector = @"divisionID"; }
	else if ([sender tag]==3)	{ competitionPickerSelector = @"lastDivisionID"; }
	else if ([sender tag]==4)	{ competitionPickerSelector = @"nextDivisionID"; }
	else if ([sender tag]==5)	{ competitionPickerSelector = @"otherDivisionID"; }
	else if ([sender tag]==6)	{ competitionPickerSelector = @"continentalCupID"; }
	else if ([sender tag]==7)	{ competitionPickerSelector = @"futureContinentalCupID"; }
	else if ([sender tag]==8)	{ competitionPickerSelector = @"firstMatchCompetitionID"; }
}	

- (IBAction)setCompetitionPickerObject:(id)object
{
	competitionPickerObject = object;
}

- (IBAction)pickCompetition:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[competitionPickerSelector substringToIndex:1] capitalizedString],
											 [competitionPickerSelector substringFromIndex:1]]);
	
	[competitionPickerObject performSelector:thisSelector withObject:[[[competitionPickerController arrangedObjects] objectAtIndex:[competitionPickerController selectionIndex]] rowID]];
	
	[competitionPicker closeSheet:self];
}

- (IBAction)showCityPicker:(id)sender
{
	cityPickerSelector = @"";
	[cityPicker openSheet:self];
	if ([sender tag]==1)		{ cityPickerSelector = @"cityID"; }
	else if ([sender tag]==2)	{ cityPickerSelector = @"capitalID"; }
	else if ([sender tag]==3)	{ cityPickerSelector = @"cityOfBirthID"; }
}	

- (IBAction)setCityPickerObject:(id)object
{
	cityPickerObject = object;
}

- (IBAction)pickCity:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[cityPickerSelector substringToIndex:1] capitalizedString],
											 [cityPickerSelector substringFromIndex:1]]);
	
	[cityPickerObject performSelector:thisSelector withObject:[[[cityPickerController arrangedObjects] objectAtIndex:[cityPickerController selectionIndex]] rowID]];
	
	[cityPicker closeSheet:self];
}

- (IBAction)deleteHistory:(id)sender { [[self mutableArrayValueForKey:@"recentlyViewed"] removeAllObjects]; }

@end
