//
//  DebugController.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DebugController.h"
#import "DatabaseTypes.h"
#import "Club.h"
#import "FMString.h"
#import "Team.h"
#import "Nation.h"
#import "LanguageIDs.h"
#import "LangDB.h"
#import "SupportFunctions.h"
#import "SXzlib.h"
#import "FMFArchiver.h"

@implementation DebugController

- (IBAction)IDLookup:(id)sender
{
	NSString *result;
	
	unsigned int lookupID = [sender intValue];
	if (lookupID >= 0) {
		// check alliterations
		if ([[controller valueForKeyPath:@"database.goodAlliterations"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.goodAlliterations"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[goodAlliterationLookupField setStringValue:result];
		if ([[controller valueForKeyPath:@"database.badAlliterations"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.badAlliterations"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[badAlliterationLookupField setStringValue:result];
		
		// check awards
		if ([[controller valueForKeyPath:@"database.awards"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.awards"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[awardLookupField setStringValue:result];
		
		// check cities
		if ([[controller valueForKeyPath:@"database.cities"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.cities"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[cityLookupField setStringValue:result];
		
		// check clubs
		if ([[controller valueForKeyPath:@"database.clubs"] count]>lookupID) {
			result = [[[[controller valueForKeyPath:@"database.clubs"] objectAtIndex:lookupID] teamContainer] name];
		}
		else { result = @"---"; }
		[clubLookupField setStringValue:result];
		
		// check competitions
		if ([[controller valueForKeyPath:@"database.competitions"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.competitions"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[competitionLookupField setStringValue:result];
		
		// check continents
		if ([[controller valueForKeyPath:@"database.continents"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.continents"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[continentLookupField setStringValue:result];
		
		// check currencies
		if ([[controller valueForKeyPath:@"database.currencies"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.currencies"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[currencyLookupField setStringValue:result];
		
		// check injuries
		if ([[controller valueForKeyPath:@"database.injuries"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.injuries"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[injuryLookupField setStringValue:result];
		
		// check languages
		if ([[controller valueForKeyPath:@"database.languages"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.languages"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[languageLookupField setStringValue:result];
		
		// check local areas
		if ([[controller valueForKeyPath:@"database.localAreas"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.localAreas"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[localAreaLookupField setStringValue:result];
		
		// check media
		if ([[controller valueForKeyPath:@"database.media"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.media"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[mediaLookupField setStringValue:result];
		
		// check first names
		if ([[controller valueForKeyPath:@"database.firstNames"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.firstNames"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[firstNameLookupField setStringValue:result];
		
		// check surnames
		if ([[controller valueForKeyPath:@"database.surnames"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.surnames"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[surnameLookupField setStringValue:result];
		
		// check common names
		if ([[controller valueForKeyPath:@"database.commonNames"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.commonNames"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[commonNameLookupField setStringValue:result];
		
		// check people
		if ([[controller valueForKeyPath:@"database.people"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.people"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[personLookupField setStringValue:result];
		
		// check nations
		if ([[controller valueForKeyPath:@"database.nations"] count]>lookupID) {
			result = [[[[controller valueForKeyPath:@"database.nations"] objectAtIndex:lookupID] teamContainer] name];
		}
		else { result = @"---"; }
		[nationLookupField setStringValue:result];
		
		// check stadiums
		if ([[controller valueForKeyPath:@"database.stadiums"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.stadiums"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[stadiumLookupField setStringValue:result];
		
		// check sponsors
		if ([[controller valueForKeyPath:@"database.sponsors"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.sponsors"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[sponsorLookupField setStringValue:result];
		
		// check stage names
		if ([[controller valueForKeyPath:@"database.stageNames"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.stageNames"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[stageNameLookupField setStringValue:result];
		
		// check teams
		if ([[controller valueForKeyPath:@"database.teams"] count]>lookupID) {
			if (![[[[controller valueForKeyPath:@"database.teams"] objectAtIndex:lookupID] name] isEqualToString:@"---"]) {
				result = [[[controller valueForKeyPath:@"database.teams"] objectAtIndex:lookupID] name];
			}
			else {
				NSString *teamName;
				int teamID = [[[controller valueForKeyPath:@"database.teams"] objectAtIndex:lookupID] teamContainerID];
				if ([[[controller valueForKeyPath:@"database.teams"] objectAtIndex:lookupID] databaseClass]==DBC_TEAM) {
					teamName = [[[[controller valueForKeyPath:@"database.clubs"] objectAtIndex:teamID] teamContainer] name];
				}
				else if ([[[controller valueForKeyPath:@"database.teams"] objectAtIndex:lookupID] databaseClass]==DBC_NATIONAL_TEAM) {
					teamName = [[[[controller valueForKeyPath:@"database.nations"] objectAtIndex:teamID] teamContainer] name];
				}
				result = [NSString stringWithFormat:@"%@ Team",teamName];
			}
		}
		else { result = @"---"; }
		[teamLookupField setStringValue:result];
		
		// check weather
		if ([[controller valueForKeyPath:@"database.weather"] count]>lookupID) {
			result = [[[controller valueForKeyPath:@"database.weather"] objectAtIndex:lookupID] name];
		}
		else { result = @"---"; }
		[weatherLookupField setStringValue:result];
		
		// check descriptions
		if ([[controller valueForKeyPath:@"database.descriptions"] count]>lookupID &&
			[[[[controller valueForKeyPath:@"database.descriptions"] objectAtIndex:lookupID] names] count] > 0) {
			result = [[[[controller valueForKeyPath:@"database.descriptions"] objectAtIndex:lookupID] names] componentsJoinedByString:@","];
		}
		else { result = @"---"; }
		[descriptionLookupField setStringValue:result];
	}
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

- (IBAction)convertFMDateToHuman:(id)sender
{
	int year = [FMYearBox intValue];
	if (year<1900) { year = 2010; }
	
	int day = [FMDayBox intValue];
	if (day<0 || day>366) { day = 0; }
	
	NSDate *jan1 = [[NSDate alloc] initWithString:[NSString stringWithFormat:@"%d-01-01 01:45:00 +0000",year]];
	int seconds = 86400 * day;
	NSDate *actualDate = [[[NSDate alloc] initWithTimeInterval:seconds sinceDate:jan1] autorelease];
	
	[humanDateResultBox setDateValue:actualDate];
	[jan1 release];
}

- (IBAction)convertHumanDateToFM:(id)sender
{
	NSDate *date = [humanDateBox dateValue];
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	
	NSDateComponents *components =
	[gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit) fromDate:date];
	
	int year = [components year];
	
	NSDate *jan1 = [[NSDate alloc] initWithString:[NSString stringWithFormat:@"%d-01-01 01:45:00 +0000",year]];
	int days = [date timeIntervalSinceDate:jan1] / 86400;
	
	[gregorian release];
	
	[FMDayResultBox setIntValue:days];
	[FMYearResultBox setStringValue:[NSString stringWithFormat:@"%X",year]];
}

@end
