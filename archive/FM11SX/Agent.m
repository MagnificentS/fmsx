//
//  Agent.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/15.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "Agent.h"

@implementation Agent

@synthesize scope, patience, agentFeeDemands, willingnessToToutPlayers, clients, basedNationID,
sizeOfAgency, unknownDate1;

- (void)setNewClientID:(int)val
{
	if (val<0) { return; }
	
	[[self mutableArrayValueForKey:@"clients"] addObject:[NSNumber numberWithInt:val]];
}

- (NSArray *)scopeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"National", @"agent scope"),
						NSLocalizedString(@"Regional", @"agent scope"),
						NSLocalizedString(@"Continental", @"agent scope"),
						NSLocalizedString(@"Worldwide", @"agent scope"),
						nil];
	return strings;
}

@end
