//
//  SXFSaveGameSummary.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFSaveGameSummary.h"

@implementation SXFSaveGameSummary

@synthesize nManagers, infoStrings;

- (NSString *)managers
{
	NSMutableString *string = [NSMutableString string];
	
	for (int i=1;i<=nManagers;i++) {
		if (![[infoStrings objectForKey:[NSString stringWithFormat:@"manager%dname",i]] isEqualToString:@"---"]) {
			if ([string length]>0) { [string appendString:@", "]; }
			[string appendFormat:@"%@ (%@)",[infoStrings objectForKey:[NSString stringWithFormat:@"manager%dname",i]],
			 [infoStrings objectForKey:[NSString stringWithFormat:@"manager%dclub",i]]];
		}
	}
	return [NSString stringWithString:string];
}

@end
