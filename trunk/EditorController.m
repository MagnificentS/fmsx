//
//  EditorController.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "Award.h"
#import "Controller.h"
#import "ContentController.h"
#import "Database.h"
#import "EditorController.h"
#import "SXEditorEntityViewController.h"

@implementation EditorController

@synthesize currentSection, selectedAward, selectedCity, selectedClub, selectedCompetition, selectedContinent,
selectedCurrency, selectedDerby, selectedInjury, selectedLanguage, selectedLocalArea, selectedMedia, selectedNation,
selectedPerson, selectedSponsor, selectedStadium, selectedStadiumChange, selectedWeather, searchResults;

- (id)init
{
	[super init];
	
	searchResults = [[NSMutableArray alloc] init];
	
	return self;
}

- (void)dealloc
{
	[searchResults release];
	
	[super dealloc];
}

- (void)selectSection:(int)newSection
{
	// leave without doing anything if it's an invalid section
	if (newSection <= 0 || newSection > EDITOR_SECTIONS) { return; }
	
	[[[NSApp delegate] editorController] setCurrentSection:newSection];
	
	// remove previous search results
	[searchResults removeAllObjects];
	
	NSString *nibToLoad;
	if (newSection==EDS_AWARDS) { nibToLoad = @"Editor_Award"; }
	else if (newSection==EDS_CITIES) { nibToLoad = @"Editor_City"; }
	else if (newSection==EDS_CLUBS) { nibToLoad = @"Editor_Club"; }
	else if (newSection==EDS_COMPETITIONS) { nibToLoad = @"Editor_Competition"; }
	else if (newSection==EDS_CONTINENTS) { nibToLoad = @"Editor_Continent"; }
	else if (newSection==EDS_CURRENCIES) { nibToLoad = @"Editor_Currency"; }
	else if (newSection==EDS_DERBIES) { nibToLoad = @"Editor_Derby"; }
	else if (newSection==EDS_INJURIES) { nibToLoad = @"Editor_Injury"; }
	else if (newSection==EDS_LANGUAGES) { nibToLoad = @"Editor_Language"; }
	else if (newSection==EDS_LOCAL_AREAS) { nibToLoad = @"Editor_LocalArea"; }
	else if (newSection==EDS_MEDIA) { nibToLoad = @"Editor_Media"; }
	else if (newSection==EDS_NATIONS) { nibToLoad = @"Editor_Nation"; }
	else if (newSection==EDS_PEOPLE) { nibToLoad = @"Editor_Person"; }
	else if (newSection==EDS_SPONSORS) { nibToLoad = @"Editor_Sponsor"; }
	else if (newSection==EDS_STADIUMS) { nibToLoad = @"Editor_Stadium"; }
	else if (newSection==EDS_STADIUM_CHANGES) { nibToLoad = @"Editor_StadiumChange"; }
	else if (newSection==EDS_WEATHER) { nibToLoad = @"Editor_Weather"; }
	
	[NSBundle loadNibNamed:@"Editor_Award" owner:self];
	
	SXEditorEntityViewController *viewController = [[SXEditorEntityViewController alloc] initWithNibName:@"Editor_Award" bundle:nil];
	[[[NSApp delegate] contentController] replacePlaceholder:[[[[NSApp delegate] contentController] editorViewController] editorPlaceholderView] withView:[viewController view]];
}

@end
