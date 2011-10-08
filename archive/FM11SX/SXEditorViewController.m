//
//  SXEditorViewController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/17.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXEditorViewController.h"
#import "Controller.h"
#import "ContentController.h"
#import "EditorController.h"

@implementation SXEditorViewController

@synthesize editorPlaceholderView, cityPicker, clubPicker, competitionPicker, mediaPicker, 
nationPicker, peoplePicker, stadiumPicker, localAreaPicker;

- (void)awakeFromNib
{
	[cityPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[clubPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[competitionPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[localAreaPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[mediaPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[nationPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[peoplePicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
	[stadiumPicker setParentWindow:[[[NSApp delegate] contentController] mainWindow]];
}

- (void)selectSection:(id)sender
{
	[[[NSApp delegate] editorController] selectSection:[sender tag]];
}

@end
