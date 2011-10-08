//
//  StadiumChange.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/04.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StadiumChange.h"


@implementation StadiumChange

@synthesize rowID, UID, databaseClass, alternativeStadiumID, oldStadiumID, 
newStadiumID, teamID, newCapacity, leaveDate, moveInDate, oldStadium, 
alternativeStadium, newStadium, name, type, unknownData1;

- (id)init
{
	[super init];
	
	name = @"---";
	
	return self;
}

- (NSArray *)typeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Invalid", @"general 'invalid' option"),
						NSLocalizedString(@"Stadium Change", @"stadium change type"),
						NSLocalizedString(@"Capacity Change", @"stadium change type"),
						nil];
	return strings;
}

- (NSString *)typeString
{
	if (type==SCT_STADIUM_CHANGE) { return @"Stadium Change"; }
	else if (type==SCT_CAPACITY_CHANGE) { return @"Capacity Change"; }
	
	return @"---";
}
- (NSString *)oldStadiumString
{
	if (oldStadiumID>-1) { return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:oldStadiumID] name]; }
	return @"---";
}

- (NSString *)name
{
	NSMutableString *changeName = [NSMutableString stringWithString:@""];
	
	if (oldStadiumID>-1) { [changeName appendString:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:oldStadiumID] name]]; }
	else { return @"---"; }
	
	if (type==SCT_STADIUM_CHANGE) { 
		[changeName appendString:@" - "];
		if (newStadiumID==oldStadiumID) { [changeName appendString:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:alternativeStadiumID] name]]; }
		else if (newStadiumID>-1) { [changeName appendString:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:newStadiumID] name]]; }
		else if (alternativeStadiumID>-1) { [changeName appendString:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.stadiums"] objectAtIndex:alternativeStadiumID] name]]; }
	}
	else if (type==SCT_CAPACITY_CHANGE) { [changeName appendString:@" Capacity Change"]; }
	
	return changeName;
}

@end
