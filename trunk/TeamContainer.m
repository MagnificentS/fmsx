//
//  TeamContainer.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Database.h"
#import "TeamContainer.h"
#import "Team.h"
#import "Colour.h"

@implementation TeamContainer

@synthesize name, shortName, colours, teams, relationships, alternativeStadiums, 
alternateKits, teamContainerType, nameGender, shortNameGender, attacking, depth, directness, 
flamboyancy, flexibility, freeRoles, marking, offside, pressing, sittingBack, tempo, 
useOfPlaymaker, width, preferredFormation, preferredFormation2, defensiveFormation, 
attackingFormation, controller, bTeams, unknowns2, transferInfos, physios, coaches;

- (NSArray *)teamObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in teams) {
		if ([item intValue] < [[[controller database] teams] count]) {
			[array addObject:[[[controller database] teams] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
}

- (NSArray *)bTeamObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in bTeams) {
		if ([item intValue] < [[[controller database] teams] count]) {
			[array addObject:[[[controller database] teams] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
} 
- (void)setBTeamObjects:(NSArray *)val
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (Team *item in val) {
		[array addObject:[NSNumber numberWithInt:[item rowID]]];
	}
	
	[self setBTeams:array];
	
	[array release];
}

- (void)removeBTeam:(int)val
{
	NSLog(@"B Teams before:%d",[bTeams count]);
	if ([bTeams containsObject:[NSNumber numberWithInt:val]]) {
		[[self mutableArrayValueForKey:@"bTeams"] removeObject:[NSNumber numberWithInt:val]];
	}
	NSLog(@"B Teams after:%d",[bTeams count]);
}

- (NSArray *)coachObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in coaches) {
		if ([item intValue] < [[[controller database] people] count]) {
			[array addObject:[[[controller database] people] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
}

- (NSArray *)physioObjects
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	
	for (id item in physios) {
		if ([item intValue] < [[[controller database] people] count]) {
			[array addObject:[[[controller database] people] objectAtIndex:[item intValue]]];
		}
	}
	
	return array;
}

- (NSImage *)defaultLogo {
	if ([colours count]>0) {
		int main = -1;
		int text = -1;
		int counter = 0;
		for (Colour *item in colours) {
			if ([item outfieldKit] && [item type]==AKT_TEXT && [item kitNumber]==AKN_HOME_KIT) {
				text = counter;
			}
			else if ([item outfieldKit] && [item type]==AKT_SHIRT && [item kitNumber]==AKN_HOME_KIT) {
				main = counter;
			}
			counter++;
		}
		if (main>=0) {
			return [[colours objectAtIndex:text] logoImageWithDefault:NO customStyle:[[colours objectAtIndex:main] kitStyle]];
		}
	}
	Colour *defaultColour = [[[Colour alloc] init] autorelease];
	return [defaultColour logoImageWithDefault:YES customStyle:-1];
}

- (NSImage *)defaultTitleBG {
	if ([colours count]>0) {
		int main = -1;
		int text = -1;
		int counter = 0;
		for (Colour *item in colours) {
			if ([item outfieldKit] && [item type]==AKT_TEXT && [item kitNumber]==AKN_HOME_KIT) {
				text = counter;
			}
			else if ([item outfieldKit] && [item type]==AKT_SHIRT && [item kitNumber]==AKN_HOME_KIT) {
				main = counter;
			}
			counter++;
		}
		if (main>=0) {
			return [[colours objectAtIndex:text] bgImageWithDefault:NO customStyle:[[colours objectAtIndex:main] kitStyle]];
		}
	}
	Colour *defaultColour = [[[Colour alloc] init] autorelease];
	return [defaultColour bgImageWithDefault:YES customStyle:-1];
}

- (NSColor *)bgColour 
{
	if ([colours count]>0) {
		int text = -1;
		int counter = 0;
		for (Colour *item in colours) {
			if ([item outfieldKit] && [item type]==AKT_TEXT && [item kitNumber]==AKN_HOME_KIT) {
				text = counter;
			}
			counter++;
		}
		if (text>=0) {
			return [[colours objectAtIndex:text] backgroundColour];
		}
	}
	
	return [NSColor whiteColor];
}

- (NSColor *)textColour 
{
	if ([colours count]>0) {
		int text = -1;
		int counter = 0;
		for (Colour *item in colours) {
			if ([item outfieldKit] && [item type]==AKT_TEXT && [item kitNumber]==AKN_HOME_KIT) {
				text = counter;
			}
			counter++;
		}
		if (text>=0) {
			return [[colours objectAtIndex:text] foregroundColour];
		}
	}
	
	return [NSColor blackColor];
}
- (NSColor *)trimColour 
{
	if ([colours count]>0) {
		int text = -1;
		int counter = 0;
		for (Colour *item in colours) {
			if ([item outfieldKit] && [item type]==AKT_TEXT && [item kitNumber]==AKN_HOME_KIT) {
				text = counter;
			}
			counter++;
		}
		if (text>=0) {
			return [[colours objectAtIndex:text] trimColour];
		}
	}
	
	return [NSColor whiteColor];
}

@end
