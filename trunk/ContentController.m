//
//  ContentController.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "SXFGameDB.h"
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
#import "SXScoutViewController.h"

@implementation ContentController

@synthesize selectedRows, editorViewController, mainWindow, placeholderView, locationString;

- (id)init
{
	[super init];
	
	selectedRows = [[NSMutableDictionary alloc] init];
	
	id playerStatsTransformer = [[[PlayerStatsTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerStatsTransformer forName:@"PlayerStatsTransformer"];
	id playerRatingTransformer = [[[PlayerRatingTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerRatingTransformer forName:@"PlayerRatingTransformer"];
	
	return self;
}

- (void)dealloc
{
	[selectedRows release];
	
	[super dealloc];
}

#pragma mark Table Delegate

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	/*
	if (aTableView==clubKitTable) {
		if ([[aTableColumn identifier] isEqualToString:@"compcol"]) {
			int UID = [[aCell stringValue] intValue];
		
			if ([[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]]==nil) {
				[aCell setStringValue:@"---"];
			}
			else {
				[aCell setStringValue:[[[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
			}
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
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] count] && UID > -1) {
			[aCell setStringValue:[[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:UID] teamContainer] name]];
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
	else if ([[aTableColumn identifier] isEqualToString:@"clubIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:UID] name]];
		}
		else { [aCell setStringValue:@"---"]; }
	}
	else if ([[aTableColumn identifier] isEqualToString:@"comprowIDtxt"]) {
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
	else if ([[aTableColumn identifier] isEqualToString:@"compIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:UID] name]];
		}
		else if ([[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]]!=nil) {
			[aCell setStringValue:[[[[[NSApp delegate] langDB] compLang] objectForKey:[NSNumber numberWithInt:UID]] objectForKey:@"name"]];
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
	else if ([[aTableColumn identifier] isEqualToString:@"teamIDtxt"]) {
		int UID = [[aCell stringValue] intValue];
		
		if (UID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] count] && UID > -1) {
			[aCell setStringValue:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:UID] fullTeamString]];
		}
		else { [aCell setStringValue:@"---"]; }
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
	 */
}

- (void)selectItem:(id)object
{
	/*
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
	[[self performSelector:controllerSelector] setFilterPredicate:nil];
	
	[[self performSelector:controllerSelector] setSelectedObjects:[NSArray arrayWithObject:object]];
	
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
	else if ([[object className] isEqualToString:@"Media"]) {
		// setup scope bars
		NSMutableArray *mediaBarItems = [[NSMutableArray alloc] init];
		
		[mediaBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								  @"GeneralItem", MGSB_ITEM_IDENTIFIER, 
								  @"General", MGSB_ITEM_NAME, 
								  nil]];
		[mediaBarItems addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								  @"AssociationsItem", MGSB_ITEM_IDENTIFIER, 
								  @"Associations", MGSB_ITEM_NAME, 
								  nil]];
		
		[mediaScopeBar setDelegate:self];
		[mediaSections removeAllObjects];
		[mediaSections addObject:[NSDictionary dictionaryWithObjectsAndKeys:
								  [NSNumber numberWithInt:MGRadioSelectionMode], MGSB_GROUP_SELECTION_MODE, // single selection group.
								  mediaBarItems, MGSB_GROUP_ITEMS, 
								  nil]];
		[mediaScopeBar reloadData];
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
	*/
}

- (void)addRelationship:(id)sender
{
	
}

- (IBAction)showNationPicker:(id)sender
{
	nationPickerSelector = @"";
	[[editorViewController nationPicker] openSheet:self];
	if ([sender tag]==1) { nationPickerSelector = @"nationID"; }
	else if ([sender tag]==2) { nationPickerSelector = @"basedNationID"; }
	
	else if ([sender tag]==3) { nationPickerSelector = @"newNationID"; }
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
	
	[nationPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showStadiumPicker:(id)sender
{
	stadiumPickerSelector = @"";
	[[editorViewController stadiumPicker] openSheet:self];
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
	
	[stadiumPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showCompetitionPicker:(id)sender
{
	competitionPickerSelector = @"";
	[[editorViewController competitionPicker] openSheet:self];
	if ([sender tag]==1)		{ competitionPickerSelector = @"competitionID"; }
	else if ([sender tag]==2)	{ competitionPickerSelector = @"divisionID"; }
	else if ([sender tag]==3)	{ competitionPickerSelector = @"lastDivisionID"; }
	else if ([sender tag]==4)	{ competitionPickerSelector = @"nextDivisionID"; }
	else if ([sender tag]==5)	{ competitionPickerSelector = @"otherDivisionID"; }
	else if ([sender tag]==6)	{ competitionPickerSelector = @"continentalCupID"; }
	else if ([sender tag]==7)	{ competitionPickerSelector = @"futureContinentalCupID"; }
	else if ([sender tag]==8)	{ competitionPickerSelector = @"firstMatchCompetitionID"; }
	else if ([sender tag]==9)	{ competitionPickerSelector = @"newCompetitionID"; }
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
	
	[competitionPickerObject performSelector:thisSelector withObject:[sender intValue]];
}

- (IBAction)showCityPicker:(id)sender
{
	cityPickerSelector = @"";
	[[editorViewController cityPicker] openSheet:self];
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
	
	[cityPickerObject performSelector:thisSelector withObject:[sender intValue]];
}

- (IBAction)showPersonPicker:(id)sender
{
	personPickerSelector = @"";
	[[editorViewController peoplePicker] openSheet:self];
	if ([sender tag]==1)		{ personPickerSelector = @"newJournalistID"; }
	else if ([sender tag]==2)	{ personPickerSelector = @"newClientID"; }
}	

- (IBAction)setPersonPickerObject:(id)object
{
	personPickerObject = object;
}

- (IBAction)pickPerson:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[personPickerSelector substringToIndex:1] capitalizedString],
											 [personPickerSelector substringFromIndex:1]]);
	
	[personPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showMediaPicker:(id)sender
{
	mediaPickerSelector = @"";
	[[editorViewController mediaPicker] openSheet:self];
	if ([sender tag]==1)		{ mediaPickerSelector = @"newLinkedMediaID"; }
	else if ([sender tag]==2)	{ mediaPickerSelector = @"media"; }
}	

- (IBAction)setMediaPickerObject:(id)object
{
	mediaPickerObject = object;
}

- (IBAction)pickMedia:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[mediaPickerSelector substringToIndex:1] capitalizedString],
											 [mediaPickerSelector substringFromIndex:1]]);
	
	[mediaPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)deleteHistory:(id)sender { [[self mutableArrayValueForKey:@"recentlyViewed"] removeAllObjects]; }

/******* NEW ONES ******/
- (IBAction)selectEditorView:(id)sender
{
	editorViewController = [[SXEditorViewController alloc] initWithNibName:@"Editor" bundle:nil];
	[self replacePlaceholder:placeholderView withView:[editorViewController view]];
}

- (IBAction)selectScoutView:(id)sender
{
	SXScoutViewController *scoutViewController = [[[SXScoutViewController alloc] init] autorelease];
	[self replacePlaceholder:placeholderView withView:[scoutViewController view]];
}

- (IBAction)selectIDLookupView:(id)sender
{

}

- (void)replacePlaceholder:(NSView *)placeholder withView:(NSView *)view
{
	NSParameterAssert(placeholder != nil);
	NSParameterAssert(view != nil);
	
	int nViews = [[placeholder subviews] count];
	
	for (int i = 0; i < nViews; i++)
	{
		[[[placeholder subviews] objectAtIndex:0] removeFromSuperview];
	}
	[placeholder addSubview:view];
}
@end
