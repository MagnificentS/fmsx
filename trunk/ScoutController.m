//
//  ScoutController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/02/16.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "ScoutController.h"
#import "Controller.h"
#import "Person.h"
#import "Database.h"
#import "SupportFunctions.h"
#import "FMString.h"
#import "DatabaseTypes.h"

@implementation ContentController (ScoutController)

- (void)awakeScout
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
	
	[self setShowPlayerScoutNameColumn:TRUE];
	[self setShowPlayerScoutStatusColumn:TRUE];
	[self setShowPlayerScoutTeamColumn:TRUE];
	[self setShowPlayerScoutAgeColumn:TRUE];
	[self setShowPlayerScoutPositionColumn:TRUE];
	[self setShowPlayerScoutCAColumn:TRUE];
	[self setShowPlayerScoutPAColumn:TRUE];
	[self setShowPlayerScoutHomeRepColumn:TRUE];
	[self setShowPlayerScoutWorldRepColumn:TRUE];
	[self setShowPlayerScoutCurrentRepColumn:TRUE];
	[self setShowPlayerScoutConditionColumn:TRUE];
	[self setShowPlayerScoutGPColumn:TRUE];
	[self setShowPlayerScoutValueColumn:TRUE];
	[self setShowPlayerScoutAskingPriceColumn:TRUE];
	[self setShowPlayerScoutNationColumn:TRUE];
	[self setShowPlayerScoutHeightColumn:FALSE];
	[self setShowPlayerScoutWeightColumn:FALSE];
	[self setShowPlayerScoutAdaptabilityColumn:FALSE];
	[self setShowPlayerScoutAmbitionColumn:FALSE];
	[self setShowPlayerScoutControversyColumn:FALSE];
	[self setShowPlayerScoutLoyaltyColumn:FALSE];
	[self setShowPlayerScoutPressureColumn:FALSE];
	[self setShowPlayerScoutProfessionalismColumn:FALSE];
	[self setShowPlayerScoutSportsmanshipColumn:FALSE];
	[self setShowPlayerScoutTemperamentColumn:FALSE];
	[self setShowPlayerScoutFullCapsColumn:FALSE];
	[self setShowPlayerScoutFullGoalsColumn:FALSE];
	[self setShowPlayerScoutU21CapsColumn:FALSE];
	[self setShowPlayerScoutU21GoalsColumn:FALSE];
	[self setShowPlayerScoutManagerRoleColumn:FALSE];
	[self setShowPlayerScoutAssistantManagerRoleColumn:FALSE];
	[self setShowPlayerScoutCoachRoleColumn:FALSE];
	[self setShowPlayerScoutFitnessCoachRoleColumn:FALSE];
	[self setShowPlayerScoutGoalkeepingCoachRoleColumn:FALSE];
	[self setShowPlayerScoutPhysioRoleColumn:FALSE];
	[self setShowPlayerScoutScoutRoleColumn:FALSE];
	[self updatePlayerScoutColumns:self];
}

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

- (IBAction)updatePlayerScoutColumns:(id)sender
{
	NSLog(@"Updating Columns...");
	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"playerscoutstatuscolumn"] setHidden:!showPlayerScoutStatusColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"name"] setHidden:!showPlayerScoutNameColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"nation"] setHidden:!showPlayerScoutNationColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"team"] setHidden:!showPlayerScoutTeamColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"age"] setHidden:!showPlayerScoutAgeColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"position"] setHidden:!showPlayerScoutPositionColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"ca"] setHidden:!showPlayerScoutCAColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"pa"] setHidden:!showPlayerScoutPAColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"homeRep"] setHidden:!showPlayerScoutHomeRepColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"currentRep"] setHidden:!showPlayerScoutCurrentRepColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"worldRep"] setHidden:!showPlayerScoutWorldRepColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"condition"] setHidden:!showPlayerScoutConditionColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"gp"] setHidden:!showPlayerScoutGPColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"value"] setHidden:!showPlayerScoutValueColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"askingPrice"] setHidden:!showPlayerScoutAskingPriceColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"height"] setHidden:!showPlayerScoutHeightColumn];
	[[playerScoutResultsTable tableColumnWithIdentifier:@"weight"] setHidden:!showPlayerScoutWeightColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"adaptability"] setHidden:!showPlayerScoutAdaptabilityColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"ambition"] setHidden:!showPlayerScoutAmbitionColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"controversy"] setHidden:!showPlayerScoutControversyColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"loyalty"] setHidden:!showPlayerScoutLoyaltyColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"pressure"] setHidden:!showPlayerScoutPressureColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"professionalism"] setHidden:!showPlayerScoutProfessionalismColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"sportsmanship"] setHidden:!showPlayerScoutSportsmanshipColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"temperament"] setHidden:!showPlayerScoutTemperamentColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"fullCaps"] setHidden:!showPlayerScoutFullCapsColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"fullGoals"] setHidden:!showPlayerScoutFullGoalsColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"u21Caps"] setHidden:!showPlayerScoutU21CapsColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"u21Goals"] setHidden:!showPlayerScoutU21GoalsColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"managerRole"] setHidden:!showPlayerScoutManagerRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"assistantManagerRole"] setHidden:!showPlayerScoutAssistantManagerRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"coachRole"] setHidden:!showPlayerScoutCoachRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"goalkeepingCoachRole"] setHidden:!showPlayerScoutGoalkeepingCoachRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"fitnessCoachRole"] setHidden:!showPlayerScoutFitnessCoachRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"physioRole"] setHidden:!showPlayerScoutPhysioRoleColumn];	
	[[playerScoutResultsTable tableColumnWithIdentifier:@"scoutRole"] setHidden:!showPlayerScoutScoutRoleColumn];	
	
}

@end
