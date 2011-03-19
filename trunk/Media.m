//
//  Media.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/29.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Media.h"

@implementation Media

@synthesize databaseClass, nameGender, period, scope, style, fake,
cityID, localAreaID, continentID, rowID, UID, lastPublishedDate,
competitions, nations, clubs, linkedMedia, name, URL, types,
journalists, newMediaClub;

- (id)init
{
	[super init];
	
	name = @"---";
	newMediaClub = [[MediaClub alloc] init];
	
	return self;
}

- (void)dealloc
{
	[newMediaClub release];
	
	[super dealloc];
}

- (void)setNewCompetitionID:(int)val
{
	if (val<0) { return; }
	
	int newCompID = [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.competitions"] objectAtIndex:val] UID];
	[[self mutableArrayValueForKey:@"competitions"] addObject:[NSNumber numberWithInt:newCompID]];
}

- (void)setNewJournalistID:(int)val
{
	if (val<0) { return; }
	
	[[self mutableArrayValueForKey:@"journalists"] addObject:[NSNumber numberWithInt:val]];
}

- (void)setNewLinkedMediaID:(int)val
{
	if (val<0) { return; }
	
	[[self mutableArrayValueForKey:@"linkedMedia"] addObject:[NSNumber numberWithInt:val]];
}

- (void)setNewNationID:(int)val
{
	if (val<0) { return; }
	
	[[self mutableArrayValueForKey:@"nations"] addObject:[NSNumber numberWithInt:val]];
}

- (NSArray *)styleStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Not Set", @"general 'not set' option"),
						NSLocalizedString(@"Tabloid", @"media style"),
						NSLocalizedString(@"Broadsheet", @"media style"),
						nil];
	return strings;
}

- (NSArray *)scopeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Invalid", @"general 'invalid' option"),
						NSLocalizedString(@"Club", @"media scope"),
						NSLocalizedString(@"Local", @"media scope"),
						NSLocalizedString(@"Regional", @"media scope"),
						NSLocalizedString(@"National", @"media scope"),
						NSLocalizedString(@"Continental", @"media scope"),
						NSLocalizedString(@"Worldwide", @"media scope"),
						NSLocalizedString(@"Competition", @"media scope"),
						nil];
	return strings;
}

- (NSArray *)periodStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Invalid", @"general 'invalid' option"),
						NSLocalizedString(@"Anytime", @"media period"),
						NSLocalizedString(@"Weekday Morning", @"media period"),
						NSLocalizedString(@"Sunday",nil),
						NSLocalizedString(@"Weekly", @"media period"),
						NSLocalizedString(@"Monthly", @"media period"),
						NSLocalizedString(@"Bi-Monthly", @"media period"),
						NSLocalizedString(@"Quarterly", @"media period"),
						NSLocalizedString(@"Yearly", @"media period"),
						NSLocalizedString(@"Weekday Evening", @"media period"),
						NSLocalizedString(@"Monday",nil),
						NSLocalizedString(@"Tuesday",nil),
						NSLocalizedString(@"Wednesday",nil),
						NSLocalizedString(@"Thursday",nil),
						NSLocalizedString(@"Friday",nil),
						NSLocalizedString(@"Saturday",nil),
						nil];
	return strings;
}

- (NSArray *)typeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Not Set", @"general 'not set' option"),
						NSLocalizedString(@"Newspaper", @"media type"),
						NSLocalizedString(@"Magazine", @"media type"),
						NSLocalizedString(@"Fanzine", @"media type"),
						NSLocalizedString(@"Radio", @"media type"),
						NSLocalizedString(@"TV", @"media type"),
						NSLocalizedString(@"Website", @"media type"),
						NSLocalizedString(@"Bookmaker", @"media type"),
						NSLocalizedString(@"Injury Sponsor", @"media type"),
						NSLocalizedString(@"Kit Sponsor", @"media type"),
						nil];
	return strings;
}

- (NSString *)cityString
{
	if (cityID>-1) { return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.cities"] objectAtIndex:cityID] name]; }
	return @"---";
}

- (NSString *)localAreaString
{
	if (localAreaID>-1) { return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:localAreaID] name]; }
	return @"---";
}

- (NSString *)typeString
{
	NSMutableString *str = [[[NSMutableString alloc] init] autorelease];
	
	for (NSNumber *type in types)
	{
		if ([str length]>0) { [str appendString:@" / "]; }
		
		if ([type intValue]==0) { [str appendString:NSLocalizedString(@"Not Set", @"general 'not set' option")]; }
		else if ([type intValue]==1) { [str appendString:NSLocalizedString(@"Newspaper", @"media type")]; }
		else if ([type intValue]==2) { [str appendString:NSLocalizedString(@"Magazine", @"media type")]; }
		else if ([type intValue]==3) { [str appendString:NSLocalizedString(@"Fanzine", @"media type")]; }
		else if ([type intValue]==4) { [str appendString:NSLocalizedString(@"Radio", @"media type")]; }
		else if ([type intValue]==5) { [str appendString:NSLocalizedString(@"TV", @"media type")]; }
		else if ([type intValue]==6) { [str appendString:NSLocalizedString(@"Website", @"media type")]; }
		else if ([type intValue]==7) { [str appendString:NSLocalizedString(@"Bookmaker", @"media type")]; }
		else if ([type intValue]==8) { [str appendString:NSLocalizedString(@"Injury Sponsor", @"media type")]; }
		else if ([type intValue]==9) { [str appendString:NSLocalizedString(@"Kit Sponsor", @"media type")]; }
		else { [str appendString:@"Unknown"]; }
	}
	
	if ([types count]>0) { return str; }
	
	return @"None";
}

- (void)addNewClub
{
	if ([newMediaClub clubID]>0) { [[self mutableArrayValueForKey:@"clubs"] addObject:newMediaClub]; }
}

@end
