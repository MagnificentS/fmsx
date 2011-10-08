//
//  City.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/24.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "City.h"
#import "Nation.h"
#import "LocalArea.h"

@implementation City

@synthesize databaseClass, nameGender, attraction, citizensNameGender, inhabitants, 
unknownChar1, nationID, weatherID, spokenLanguageID, localAreaID, altitude, latitude,
longitude, citizensName, rowID, UID, name;

- (id)init
{
	[super init];
	
	name = @"---";
	
	return self;
}

- (NSArray *)inhabitantsStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Not Set", @"general 'not set' option"),
						NSLocalizedString(@"0 - 1,000", @"city inhabitants"),
						NSLocalizedString(@"1,001 - 2,500", @"city inhabitants"),
						NSLocalizedString(@"2,501 - 5,000", @"city inhabitants"),
						NSLocalizedString(@"5,001 - 10,000", @"city inhabitants"),
						NSLocalizedString(@"10,001 - 25,000", @"city inhabitants"),
						NSLocalizedString(@"25,001 - 50,000", @"city inhabitants"),
						NSLocalizedString(@"50,001 - 100,000", @"city inhabitants"),
						NSLocalizedString(@"100,001 - 250,000", @"city inhabitants"),
						NSLocalizedString(@"250,001 - 500,000", @"city inhabitants"),
						NSLocalizedString(@"500,001 - 1,000,000", @"city inhabitants"),
						NSLocalizedString(@"1,000,001 - 2,500,000", @"city inhabitants"),
						NSLocalizedString(@"2,500,001 - 5,000,000", @"city inhabitants"),
						NSLocalizedString(@"5,000,001 - 10,000,000", @"city inhabitants"),
						NSLocalizedString(@"10,000,001 - 20,000,000", @"city inhabitants"),
						NSLocalizedString(@"Over 20,000,000", @"city inhabitants"),
						nil];
	return strings;
}

- (NSString *)localAreaString
{
	if (localAreaID>-1) { return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.localAreas"] objectAtIndex:localAreaID] name]; }
	return @"---";	
}
- (NSString *)nationString
{
	if (nationID>-1) { return [[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"] objectAtIndex:nationID] teamContainer] name]; }
	return @"---";
}

@end