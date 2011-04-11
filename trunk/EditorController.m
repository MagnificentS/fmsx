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

#import "CityIDTransformer.h"
#import "ClubIDTransformer.h"
#import "CompetitionIDTransformer.h"
#import "MediaIDTransformer.h"
#import "NationIDTransformer.h"
#import "PersonIDTransformer.h"
#import "StadiumIDTransformer.h"


@implementation EditorController

@synthesize currentSection, selectedAward, selectedCity, selectedClub, selectedCompetition, selectedContinent,
selectedCurrency, selectedDerby, selectedInjury, selectedLanguage, selectedLocalArea, selectedMedia, selectedNation,
selectedPerson, selectedSponsor, selectedStadium, selectedStadiumChange, selectedWeather, searchResults;

- (id)init
{
	[super init];
	
	searchResults = [[NSMutableArray alloc] init];
	
	id cityIDTransformer = [[[CityIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:cityIDTransformer forName:@"CityIDTransformer"];
	id clubIDTransformer = [[[ClubIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:clubIDTransformer forName:@"ClubIDTransformer"];
	id competitionIDTransformer = [[[CompetitionIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:competitionIDTransformer forName:@"CompetitionIDTransformer"];
	id mediaIDTransformer = [[[MediaIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:mediaIDTransformer forName:@"MediaIDTransformer"];
	id nationIDTransformer = [[[NationIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:nationIDTransformer forName:@"NationIDTransformer"];
	id personIDTransformer = [[[PersonIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:personIDTransformer forName:@"PersonIDTransformer"];
	id stadiumIDTransformer = [[[StadiumIDTransformer alloc] init] autorelease];
	[NSValueTransformer setValueTransformer:stadiumIDTransformer forName:@"StadiumIDTransformer"];
	
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
	
	SXEditorEntityViewController *viewController = [[SXEditorEntityViewController alloc] initWithNibName:nibToLoad bundle:nil];
	[[[NSApp delegate] contentController] replacePlaceholder:[[[[NSApp delegate] contentController] editorViewController] editorPlaceholderView] withView:[viewController view]];
}

- (void)selectSection:(int)newSection andPerson:(Person *)person
{
	// leave without doing anything if it's an invalid section
	if (newSection <= 0 || newSection > EDITOR_SECTIONS) { return; }
	
	[[[NSApp delegate] editorController] setCurrentSection:newSection];
	
	// remove previous search results
	[searchResults removeAllObjects];
	
	NSString *nibToLoad = @"Editor_Person";
	
	SXEditorEntityViewController *viewController = [[SXEditorEntityViewController alloc] initWithNibName:nibToLoad bundle:nil];
	[[[NSApp delegate] contentController] replacePlaceholder:[[[[NSApp delegate] contentController] editorViewController] editorPlaceholderView] withView:[viewController view]];
	
	// select current person
	[self setSelectedPerson:person];
	
	// change view
	[[[NSApp delegate] contentController] replacePlaceholder:[viewController personMainViewContainer] withView:[viewController personEntityView]];
}

@end
