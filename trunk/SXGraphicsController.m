//
//  SXGraphicsController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/18.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXGraphicsController.h"
#import "Controller.h"
#import "SupportFunctions.h"

@implementation SXGraphicsController

- (id)init
{
	[super init];
	
	graphicsFMFInfos = [[NSMutableDictionary alloc] init];
	
	return self;
}

- (void)dealloc
{
	[graphicsFMFInfos release];
	
	[super dealloc];
}

- (void)parseGraphics
{
	// parse any graphics.fmf file there is in the FM directory first
	NSString *graphicsFMFPath = [NSString stringWithFormat:@"%@/data/graphics.fmf",[[NSUserDefaults standardUserDefaults] stringForKey:@"fmLocation"]];
	
}

@end
