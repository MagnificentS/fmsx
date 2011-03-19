//
//  MediaClub.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MediaClub.h"


@implementation MediaClub

@synthesize clubID, URL, SXClubRowID;

- (id)init
{
	[super init];
	
	clubID = -1;
	
	return self;
}

- (void)setClubRowID:(int)val
{
	if (val<0 || val>[[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] count]) { return; }

	[self setSXClubRowID:val];
	[self setClubID:[[[[NSApp delegate] valueForKeyPath:@"gameDB.database.clubs"] objectAtIndex:val] UID]];
}

- (int)clubRowID
{
	return SXClubRowID;
}

@end
