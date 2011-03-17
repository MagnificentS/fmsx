//
//  SXEditorEntityViewController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXEditorEntityViewController.h"
#import "Controller.h"
#import "ContentController.h"

#import "Award.h"

@implementation SXEditorEntityViewController

@synthesize awardMainViewContainer, awardEntityView, awardGeneralView, awardRulesView, awardSectionView;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if (aTableView==awardsTable) { 
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { return [[[[NSApp delegate] editorController] searchResults] count]; }
		return [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] count]; 
	}
	
	// section tables
	else if (aTableView==awardSectionsTable) { return 2; }
	
	return 0;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	NSString *columnName = [aTableColumn identifier];
	
	if (aTableView==awardsTable) {
		Award *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:rowIndex]; }
		
		if ([columnName isEqualToString:@"uid"])			{ return [NSNumber numberWithInt:[object UID]]; }
		else if ([columnName isEqualToString:@"name"])		{ return [object name]; }
		else if ([columnName isEqualToString:@"nation"])	{ return [object nationString]; }
		else if ([columnName isEqualToString:@"continent"]) { return [object continentString]; }
	}
	
	else if (aTableView==awardSectionsTable) { 
		if (rowIndex==0)		{ return @"General"; }
		else if (rowIndex==1)	{ return @"Rules"; }
	}
	
	return @"--Invalid--";
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(id)aCell forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	if (aTableView==awardsTable) {
		Award *object;
		
		if ([[[[NSApp delegate] editorController] searchResults] count]>0) { object = [[[[NSApp delegate] editorController] searchResults] objectAtIndex:rowIndex]; }
		else { object = [[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:rowIndex]; }
		
		[aCell setDrawsBackground:YES];
		[aCell setBackgroundColor:[[object colour] backgroundColour]];
		[aCell setTextColor:[[object colour] foregroundColour]];
	}
}

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
	if ([aNotification object]==awardSectionsTable) {
		if ([awardSectionsTable selectedRow]==0) {
			[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardGeneralView];
		}
		else if ([awardSectionsTable selectedRow]==1) {
			[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardRulesView];
		}
	}
}

- (void)selectFromTable
{
	int currentSection = [[[NSApp delegate] editorController] currentSection];
	
	// set to -1 as failsafe
	int selectionIndex = -1;
	
	NSString *arrayString, *classString;
	
	if (currentSection==EDS_AWARDS) { 
		selectionIndex = [awardsTable selectedRow]; 
		arrayString = @"gameDB.database.awards";
		classString = @"award";
	}
	
	// override selection index if there is a search
	if ([[[[NSApp delegate] editorController] searchResults] count]>0) { 
		selectionIndex = [[[NSApp delegate] valueForKeyPath:arrayString] indexOfObjectIdenticalTo:[[[[NSApp delegate] editorController] searchResults] objectAtIndex:selectionIndex]];
	}
	
	if (selectionIndex==-1) { return; }
	
	[[[[NSApp delegate] editorController] searchResults] removeAllObjects];
	
	SEL selectionSelector = NSSelectorFromString([NSString stringWithFormat:@"setSelected%@:",[classString capitalizedString]]);
	[[[NSApp delegate] editorController] performSelector:selectionSelector withObject:[[[NSApp delegate] valueForKeyPath:arrayString] objectAtIndex:selectionIndex]];
	
	SEL containerViewSelector = NSSelectorFromString([NSString stringWithFormat:@"%@MainViewContainer",classString]);
	SEL entityViewSelector = NSSelectorFromString([NSString stringWithFormat:@"%@EntityView",classString]);
	 
	[[[NSApp delegate] contentController] replacePlaceholder:[self performSelector:containerViewSelector] withView:[self performSelector:entityViewSelector]];
	 
	// any extra things that need doing after the view is set
	if (currentSection==EDS_AWARDS) { 
		// make the default section the general view
		[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardGeneralView];
		
		// set header colour
		[awardHeaderBox setFillStartingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] backgroundColour]];
		[awardHeaderBox setFillEndingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
		[awardBGBox setFillColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
	}
	
	[self reloadEntityTable:[[[NSApp delegate] editorController] currentSection]];
}

- (void)controlTextDidEndEditing:(NSNotification *)aNotification
{
	int currentSection = [[[NSApp delegate] editorController] currentSection];
	NSString *searchVariable;
	NSString *searchArray;
	
	if (currentSection==EDS_AWARDS) { 
		searchVariable = @"name";
		searchArray = @"gameDB.database.awards";
	}
	
	[[[[NSApp delegate] editorController] searchResults] removeAllObjects];
	
	if ([[[aNotification object] stringValue] length] < 1) { return; }
	
	NSString *searchString = [NSString stringWithFormat:@"%@ contains[cd] '%@'",searchVariable,[[aNotification object] stringValue]];
	[[[[NSApp delegate] editorController] searchResults] addObjectsFromArray:[[[NSApp delegate] valueForKeyPath:searchArray] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:searchString]]];
	
	[self reloadEntityTable:currentSection];
}

- (IBAction)showCityPicker:(id)sender { [[[NSApp delegate] contentController] showCityPicker:sender]; }
- (IBAction)showCompetitionPicker:(id)sender { [[[NSApp delegate] contentController] showCompetitionPicker:sender]; }
- (IBAction)showMediaPicker:(id)sender { [[[NSApp delegate] contentController] showMediaPicker:sender]; }
- (IBAction)showNationPicker:(id)sender { [[[NSApp delegate] contentController] showNationPicker:sender]; }
- (IBAction)showPersonPicker:(id)sender { [[[NSApp delegate] contentController] showPersonPicker:sender]; }
- (IBAction)showStadiumPicker:(id)sender { [[[NSApp delegate] contentController] showStadiumPicker:sender]; }

- (void)reloadEntityTable:(int)section
{
	if (section==EDS_AWARDS)				{ [awardsTable reloadData]; }
//	else if (section==EDS_CITIES)			{ [citiesTable reloadData]; }
//	else if (section==EDS_CLUBS)			{ [clubsTable reloadData]; }
//	else if (section==EDS_COMPETITIONS)		{ [competitionsTable reloadData]; }
//	else if (section==EDS_CONTINENTS)		{ [continentsTable reloadData]; }
//	else if (section==EDS_CURRENCIES)		{ [currenciesTable reloadData]; }
//	else if (section==EDS_DERBIES)			{ [derbiesTable reloadData]; }
//	else if (section==EDS_INJURIES)			{ [injuriesTable reloadData]; }
//	else if (section==EDS_LANGUAGES)		{ [languagesTable reloadData]; }
//	else if (section==EDS_LOCAL_AREAS)		{ [localAreasTable reloadData]; }
//	else if (section==EDS_MEDIA)			{ [mediaTable reloadData]; }
//	else if (section==EDS_NATIONS)			{ [nationsTable reloadData]; }
//	else if (section==EDS_PEOPLE)			{ [peopleTable reloadData]; }
//	else if (section==EDS_SPONSORS)			{ [sponsorsTable reloadData]; }
//	else if (section==EDS_STADIUMS)			{ [stadiumsTable reloadData]; }
//	else if (section==EDS_STADIUM_CHANGES)	{ [stadiumChangesTable reloadData]; }
//	else if (section==EDS_WEATHER)			{ [weatherTable reloadData]; }	
}

@end
