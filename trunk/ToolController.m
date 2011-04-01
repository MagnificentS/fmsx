//
//  ToolController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/12.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "ToolController.h"
#import "SXFGameDB.h"
#import "Club.h"
#import "DatabaseTypes.h"
#import "Team.h"
#import "FMFArchiver.h"

@implementation ToolController

- (IBAction)IDLookup:(id)sender
{
	NSString *result;
	
	unsigned int lookupID = [sender intValue];
	if (lookupID < 0) { return; }
	
	// check alliterations
	if ([[controller valueForKeyPath:@"gameDB.database.goodAlliterations"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.goodAlliterations"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[goodAlliterationRowIDField setStringValue:result];
	if ([[controller valueForKeyPath:@"gameDB.database.badAlliterations"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.badAlliterations"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[badAlliterationRowIDField setStringValue:result];
		
	// check awards
	if ([[controller valueForKeyPath:@"gameDB.database.awards"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[awardRowIDField setStringValue:result];
	
	if ([[[controller langDB] awardLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[awardUIDField setStringValue:[[[[controller langDB] awardLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [awardUIDField setStringValue:@"---"]; }
	
	// check cities
	if ([[controller valueForKeyPath:@"gameDB.database.cities"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.cities"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[cityRowIDField setStringValue:result];
	
	if ([[[controller langDB] cityLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[cityUIDField setStringValue:[[[[controller langDB] cityLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [cityUIDField setStringValue:@"---"]; }
	
	// check clubs
	if ([[controller valueForKeyPath:@"gameDB.database.clubs"] count]>lookupID) {
		result = [[[[controller valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:lookupID] teamContainer] name];
	}
	else { result = @"---"; }
	[clubRowIDField setStringValue:result];
		
	if ([[[controller langDB] clubLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[clubUIDField setStringValue:[[[[controller langDB] clubLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [clubUIDField setStringValue:@"---"]; }
	
	// check competitions
	if ([[controller valueForKeyPath:@"gameDB.database.competitions"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[competitionRowIDField setStringValue:result];
	
	if ([[[controller langDB] compLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[competitionUIDField setStringValue:[[[[controller langDB] compLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [competitionUIDField setStringValue:@"---"]; }
	
	// check continents
	if ([[controller valueForKeyPath:@"gameDB.database.continents"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.continents"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[continentRowIDField setStringValue:result];
	
	if ([[[controller langDB] continentLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[continentUIDField setStringValue:[[[[controller langDB] continentLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [continentUIDField setStringValue:@"---"]; }
	
	// check currencies
	if ([[controller valueForKeyPath:@"gameDB.database.currencies"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.currencies"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[currencyRowIDField setStringValue:result];
		
	// check injuries
	if ([[controller valueForKeyPath:@"gameDB.database.injuries"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.injuries"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[injuryRowIDField setStringValue:result];
	
	if ([[[controller langDB] injuryLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[injuryUIDField setStringValue:[[[[controller langDB] injuryLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [injuryUIDField setStringValue:@"---"]; }

	// check languages
	if ([[controller valueForKeyPath:@"gameDB.database.languages"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.languages"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[languageRowIDField setStringValue:result];
		
	// check local areas
	if ([[controller valueForKeyPath:@"gameDB.database.localAreas"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[localAreaRowIDField setStringValue:result];
	
	if ([[[controller langDB] localAreaLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[localAreaUIDField setStringValue:[[[[controller langDB] localAreaLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [localAreaUIDField setStringValue:@"---"]; }
	
	// check media
	if ([[controller valueForKeyPath:@"gameDB.database.media"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.media"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[mediaRowIDField setStringValue:result];
		
	// check first names
	if ([[controller valueForKeyPath:@"gameDB.database.firstNames"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.firstNames"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[firstNameRowIDField setStringValue:result];
		
	// check surnames
	if ([[controller valueForKeyPath:@"gameDB.database.surnames"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.surnames"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[surnameRowIDField setStringValue:result];
		
	// check common names
	if ([[controller valueForKeyPath:@"gameDB.database.commonNames"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.commonNames"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[commonNameRowIDField setStringValue:result];
		
	// check people
	if ([[controller valueForKeyPath:@"gameDB.database.people"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.people"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[personRowIDField setStringValue:result];
	
	// check nations
	if ([[controller valueForKeyPath:@"gameDB.database.nations"] count]>lookupID) {
		result = [[[[controller valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:lookupID] teamContainer] name];
	}
	else { result = @"---"; }
	[nationRowIDField setStringValue:result];
		
	// check stadiums
	if ([[controller valueForKeyPath:@"gameDB.database.stadiums"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[stadiumRowIDField setStringValue:result];
		
	if ([[[controller langDB] stadiumLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[stadiumUIDField setStringValue:[[[[controller langDB] stadiumLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [stadiumUIDField setStringValue:@"---"]; }
	
	// check sponsors
	if ([[controller valueForKeyPath:@"gameDB.database.sponsors"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.sponsors"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[sponsorRowIDField setStringValue:result];
		
	// check stage names
	if ([[controller valueForKeyPath:@"gameDB.database.stageNames"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.stageNames"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[stageNameRowIDField setStringValue:result];
	
	if ([[[controller langDB] stageNameLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[stageNameUIDField setStringValue:[[[[controller langDB] stageNameLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [stageNameUIDField setStringValue:@"---"]; }
	
	// check teams
	if ([[controller valueForKeyPath:@"gameDB.database.teams"] count]>lookupID) {
		if (![[[[controller valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:lookupID] name] isEqualToString:@"---"]) {
			result = [[[controller valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:lookupID] name];
		}
		else {
			NSString *teamName;
			int teamID = [[[controller valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:lookupID] teamContainerID];
			if ([[[controller valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:lookupID] databaseClass]==DBC_TEAM) {
				teamName = [[[[controller valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:teamID] teamContainer] name];
			}
			else if ([[[controller valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:lookupID] databaseClass]==DBC_NATIONAL_TEAM) {
				teamName = [[[[controller valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:teamID] teamContainer] name];
			}
			result = [NSString stringWithFormat:@"%@ Team",teamName];
		}
	}
	else { result = @"---"; }
	[teamRowIDField setStringValue:result];
		
	// check weather
	if ([[controller valueForKeyPath:@"gameDB.database.weather"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.weather"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[weatherRowIDField setStringValue:result];
	
	// check descriptions
	if ([[controller valueForKeyPath:@"gameDB.database.descriptions"] count]>lookupID &&
		[[[[controller valueForKeyPath:@"gameDB.database.descriptions"] objectAtIndex:lookupID] names] count] > 0) {
		result = [[[[controller valueForKeyPath:@"gameDB.database.descriptions"] objectAtIndex:lookupID] names] componentsJoinedByString:@","];
	}
	else { result = @"---"; }
	[descriptionRowIDField setStringValue:result];
	
	if ([[[controller langDB] descriptionLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[descriptionUIDField setStringValue:[[[[[controller langDB] descriptionLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"names"] componentsJoinedByString:@","]];
	}
	else { [descriptionUIDField setStringValue:@"---"]; }
	
	// check stadium changes
	if ([[controller valueForKeyPath:@"gameDB.database.stadiumChanges"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.stadiumChanges"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[stadiumChangeRowIDField setStringValue:result];
	
	// check agreements
	if ([[controller valueForKeyPath:@"gameDB.database.agreements"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.agreements"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[agreementRowIDField setStringValue:result];
	
	if ([[[controller langDB] agreementLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[agreementUIDField setStringValue:[[[[controller langDB] agreementLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [agreementUIDField setStringValue:@"---"]; }
	
	// check derbies
	if ([[controller valueForKeyPath:@"gameDB.database.derbies"] count]>lookupID) {
		result = [[[controller valueForKeyPath:@"gameDB.database.derbies"] objectAtIndex:lookupID] name];
	}
	else { result = @"---"; }
	[derbyRowIDField setStringValue:result];
	
	if ([[[controller langDB] derbyLang] objectForKey:[NSNumber numberWithInt:lookupID]]!=nil) {
		[derbyUIDField setStringValue:[[[[controller langDB] derbyLang] objectForKey:[NSNumber numberWithInt:lookupID]] objectForKey:@"name"]];
	}
	else { [derbyUIDField setStringValue:@"---"]; }
	
}

- (IBAction)extractLangDBFile:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"dat",nil]];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		[LangDB extractLangDB:[op filename]];
	}
	
	NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:NSLocalizedString(@"lang_db.dat succesfully extracted",@"info message")] defaultButton:@"OK" alternateButton:nil 
									   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"",@"info message")];
	[alert runModal];
}

- (IBAction)extractFMFFile:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"fmf",@"fm",nil]];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		[FMFArchiver extractFMF:[op filename]];
	}
	
	NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:NSLocalizedString(@"File succesfully extracted",@"info message")] defaultButton:@"OK" alternateButton:nil 
									   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"",@"info message")];
	[alert runModal];
}

@end
