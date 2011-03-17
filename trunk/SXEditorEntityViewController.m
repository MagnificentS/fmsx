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
	
	NSString *arrayString;
	
	// merge stuff into here later so there arent 2 checks of type
	if (currentSection==EDS_AWARDS) { 
		selectionIndex = [awardsTable selectedRow]; 
		arrayString = @"gameDB.database.awards";
	}
	
	// override selection index if there is a search
	if ([[[[NSApp delegate] editorController] searchResults] count]>0) { 
		selectionIndex = [[[NSApp delegate] valueForKeyPath:arrayString] indexOfObjectIdenticalTo:[[[[NSApp delegate] editorController] searchResults] objectAtIndex:selectionIndex]];
	}
	
	if (selectionIndex==-1) { return; }
	
	[[[[NSApp delegate] editorController] searchResults] removeAllObjects];
	
	// move this up and make this dynamic as above
	if (currentSection==EDS_AWARDS) { 
		[[[NSApp delegate] editorController] setSelectedAward:[[[NSApp delegate] valueForKeyPath:@"gameDB.database.awards"] objectAtIndex:selectionIndex]]; 
		[[[NSApp delegate] contentController] replacePlaceholder:awardMainViewContainer withView:awardEntityView];
		[[[NSApp delegate] contentController] replacePlaceholder:awardSectionView withView:awardGeneralView];
		
		// set header colour
		[awardHeaderBox setFillStartingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] backgroundColour]];
		[awardHeaderBox setFillEndingColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
		[awardBGBox setFillColor:[[[[[NSApp delegate] editorController] selectedAward] colour] foregroundColour]];
		
		[awardsTable reloadData];
	}
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
	
	if (currentSection==EDS_AWARDS) { [awardsTable reloadData]; }
}

- (IBAction)showCityPicker:(id)sender { [[[NSApp delegate] contentController] showCityPicker:sender]; }
- (IBAction)showCompetitionPicker:(id)sender { [[[NSApp delegate] contentController] showCompetitionPicker:sender]; }
- (IBAction)showMediaPicker:(id)sender { [[[NSApp delegate] contentController] showMediaPicker:sender]; }
- (IBAction)showNationPicker:(id)sender { [[[NSApp delegate] contentController] showNationPicker:sender]; }
- (IBAction)showPersonPicker:(id)sender { [[[NSApp delegate] contentController] showPersonPicker:sender]; }
- (IBAction)showStadiumPicker:(id)sender { [[[NSApp delegate] contentController] showStadiumPicker:sender]; }

@end
