//
//  SXScoutViewController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/14.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXScoutViewController.h"
#import "Controller.h"

@implementation SXScoutViewController

- (void)awakeFromNib
{
	[playerFilters setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[staffFilters setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[clubColumns setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[playerColumns setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[staffColumns setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
}

@end
