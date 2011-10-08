//
//  SXFGameDB.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFGameDB.h"

@implementation SXFGameDB

@synthesize currentDate, startDate, version, databaseChanges, saveStartOffset, saveEndOffset, database;

- (id)init
{
	[super init];
	
	database = [[Database alloc] init];

	return self;
}

- (void)dealloc
{
	[database release];
	
	[super dealloc];
}

@end
