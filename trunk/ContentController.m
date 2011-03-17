//
//  ContentController.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
#import "SXFGameDB.h"
#import "Award.h"
#import "Club.h"
#import "Colour.h"
#import "Person.h"
#import "Team.h"
#import "Contract.h"
#import "Controller.h"
#import "DatabaseTypes.h"
#import "Database.h"
#import "FMString.h"
#import "LangDB.h"
#import "ContentController.h"
#import "PlayerStatsTransformer.h"
#import "PlayerRatingTransformer.h"
#import "SupportFunctions.h"
#import "SXOutlineViewCell.h"
#import "SXMainMediaController.h"
#import "SXScoutViewController.h"

@implementation ContentController

@synthesize selectedRows, editorViewController, mainWindow, placeholderView, locationString;

- (id)init
{
	[super init];
	
	selectedRows = [[NSMutableDictionary alloc] init];
	
	id playerStatsTransformer = [[[PlayerStatsTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerStatsTransformer forName:@"PlayerStatsTransformer"];
	id playerRatingTransformer = [[[PlayerRatingTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:playerRatingTransformer forName:@"PlayerRatingTransformer"];
	
	return self;
}

- (void)dealloc
{
	[selectedRows release];
	
	[super dealloc];
}

- (IBAction)showNationPicker:(id)sender
{
	nationPickerSelector = @"";
	[[editorViewController nationPicker] openSheet:self];
	if ([sender tag]==1) { nationPickerSelector = @"nationID"; }
	else if ([sender tag]==2) { nationPickerSelector = @"basedNationID"; }
	
	else if ([sender tag]==3) { nationPickerSelector = @"newNationID"; }
}

- (IBAction)setNationPickerObject:(id)object
{
	nationPickerObject = object;
}

- (IBAction)pickNation:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[nationPickerSelector substringToIndex:1] capitalizedString],
											 [nationPickerSelector substringFromIndex:1]]);
	
	[nationPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showStadiumPicker:(id)sender
{
	stadiumPickerSelector = @"";
	[[editorViewController stadiumPicker] openSheet:self];
	if ([sender tag]==1)		{ stadiumPickerSelector = @"stadiumID"; }
	else if ([sender tag]==2)	{ stadiumPickerSelector = @"oldStadiumID"; }
	else if ([sender tag]==3)	{ stadiumPickerSelector = @"newStadiumID"; }
	else if ([sender tag]==4)	{ stadiumPickerSelector = @"alternativeStadiumID"; }
	else if ([sender tag]==5)	{ stadiumPickerSelector = @"nearbyStadiumID"; }
	else if ([sender tag]==6)	{ stadiumPickerSelector = @"firstMatchStadiumID"; }
	else if ([sender tag]==7)	{ stadiumPickerSelector = @"nationalStadiumID"; }
}

- (IBAction)setStadiumPickerObject:(id)object { stadiumPickerObject = object; }

- (IBAction)pickStadium:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[stadiumPickerSelector substringToIndex:1] capitalizedString],
											 [stadiumPickerSelector substringFromIndex:1]]);
	
	[stadiumPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showCompetitionPicker:(id)sender
{
	competitionPickerSelector = @"";
	[[editorViewController competitionPicker] openSheet:self];
	if ([sender tag]==1)		{ competitionPickerSelector = @"competitionID"; }
	else if ([sender tag]==2)	{ competitionPickerSelector = @"divisionID"; }
	else if ([sender tag]==3)	{ competitionPickerSelector = @"lastDivisionID"; }
	else if ([sender tag]==4)	{ competitionPickerSelector = @"nextDivisionID"; }
	else if ([sender tag]==5)	{ competitionPickerSelector = @"otherDivisionID"; }
	else if ([sender tag]==6)	{ competitionPickerSelector = @"continentalCupID"; }
	else if ([sender tag]==7)	{ competitionPickerSelector = @"futureContinentalCupID"; }
	else if ([sender tag]==8)	{ competitionPickerSelector = @"firstMatchCompetitionID"; }
	else if ([sender tag]==9)	{ competitionPickerSelector = @"newCompetitionID"; }
}	

- (IBAction)setCompetitionPickerObject:(id)object
{
	competitionPickerObject = object;
}

- (IBAction)pickCompetition:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[competitionPickerSelector substringToIndex:1] capitalizedString],
											 [competitionPickerSelector substringFromIndex:1]]);
	
	[competitionPickerObject performSelector:thisSelector withObject:[sender intValue]];
}

- (IBAction)showCityPicker:(id)sender
{
	cityPickerSelector = @"";
	[[editorViewController cityPicker] openSheet:self];
	if ([sender tag]==1)		{ cityPickerSelector = @"cityID"; }
	else if ([sender tag]==2)	{ cityPickerSelector = @"capitalID"; }
	else if ([sender tag]==3)	{ cityPickerSelector = @"cityOfBirthID"; }
}	

- (IBAction)setCityPickerObject:(id)object
{
	cityPickerObject = object;
}

- (IBAction)pickCity:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[cityPickerSelector substringToIndex:1] capitalizedString],
											 [cityPickerSelector substringFromIndex:1]]);
	
	[cityPickerObject performSelector:thisSelector withObject:[sender intValue]];
}

- (IBAction)showPersonPicker:(id)sender
{
	personPickerSelector = @"";
	[[editorViewController peoplePicker] openSheet:self];
	if ([sender tag]==1)		{ personPickerSelector = @"newJournalistID"; }
	else if ([sender tag]==2)	{ personPickerSelector = @"newClientID"; }
}	

- (IBAction)setPersonPickerObject:(id)object
{
	personPickerObject = object;
}

- (IBAction)pickPerson:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[personPickerSelector substringToIndex:1] capitalizedString],
											 [personPickerSelector substringFromIndex:1]]);
	
	[personPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)showMediaPicker:(id)sender
{
	mediaPickerSelector = @"";
	[[editorViewController mediaPicker] openSheet:self];
	if ([sender tag]==1)		{ mediaPickerSelector = @"newLinkedMediaID"; }
	else if ([sender tag]==2)	{ mediaPickerSelector = @"media"; }
}	

- (IBAction)setMediaPickerObject:(id)object
{
	mediaPickerObject = object;
}

- (IBAction)pickMedia:(id)sender
{
	SEL thisSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:",
											 [[mediaPickerSelector substringToIndex:1] capitalizedString],
											 [mediaPickerSelector substringFromIndex:1]]);
	
	[mediaPickerObject performSelector:thisSelector withObject:[sender intValue]];
	
}

- (IBAction)selectEditorView:(id)sender
{
	if (![[NSApp delegate] dataLoaded]) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Game Not Loaded",@"error - game not loaded") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:@"The editor can't be displayed before a game is loaded"];
		[alert runModal];
		return;
	}
	
	editorViewController = [[SXEditorViewController alloc] initWithNibName:@"Editor" bundle:nil];
	[self replacePlaceholder:placeholderView withView:[editorViewController view]];
}

- (IBAction)selectScoutView:(id)sender
{
	if (![[NSApp delegate] dataLoaded]) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Game Not Loaded",@"error - game not loaded") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:@"The scout can't be displayed before a game is loaded"];
		[alert runModal];
		return;
	}
	
	SXScoutViewController *scoutViewController = [[[SXScoutViewController alloc] init] autorelease];
	[self replacePlaceholder:placeholderView withView:[scoutViewController view]];
}

- (IBAction)selectIDLookupView:(id)sender
{

}

- (void)replacePlaceholder:(NSView *)placeholder withView:(NSView *)view
{
	NSParameterAssert(placeholder != nil);
	NSParameterAssert(view != nil);
	
	int nViews = [[placeholder subviews] count];
	
	for (int i = 0; i < nViews; i++)
	{
		[[[placeholder subviews] objectAtIndex:0] removeFromSuperview];
	}
	[placeholder addSubview:view];
}
@end
