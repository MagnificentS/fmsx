//
//  Journalist.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 littleblue. All rights reserved.
//

#import "Journalist.h"

@implementation Journalist

@synthesize currentEmployerID, characterFlags, favouriteClubID, curiosity, honesty, styleOfWriting;

- (NSArray *)styleOfWritingStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Sensationalist",@"journalist style of writing"),
						NSLocalizedString(@"Factual",@"journalist style of writing"),
						NSLocalizedString(@"Bland",@"journalist style of writing"),
						NSLocalizedString(@"Flamboyant",@"journalist style of writing"),
						nil];
	return strings;
}

@end
