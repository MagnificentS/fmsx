//
//  LocationDays.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/15.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "Club.h"
#import "Nation.h"
#import "LocationDays.h"
#import "Team.h"

@implementation LocationDays

@synthesize between15And21Only, days, locationUID, unknownChar1;

- (NSString *)locationString
{
	if (unknownChar1 & 0x01) {
		for (Nation *object in [[NSApp delegate] valueForKeyPath:@"gameDB.database.nations"])
		{
			if ([object UID]==locationUID) { return [[object teamContainer] name]; }
		}
		
		for (Club *object in [[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"])
		{
			if ([object UID]==locationUID) { return [[object teamContainer] name]; }
		}
	}
	else if (locationUID < [[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] count]) {
		return [[[[NSApp delegate] valueForKeyPath:@"gameDB.database.teams"] objectAtIndex:locationUID] teamString];
	}
	
	return [NSString stringWithFormat:@"%d - %d",unknownChar1,locationUID];
}

@end
