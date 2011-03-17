//
//  EditorController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// sections - corresponding to button tags
#define EDS_AWARDS			1
#define EDS_CITIES			2
#define EDS_CLUBS			3
#define EDS_COMPETITIONS	4
#define EDS_CONTINENTS		5
#define EDS_CURRENCIES		6
#define EDS_DERBIES			7
#define EDS_INJURIES		8
#define EDS_LANGUAGES		9
#define EDS_LOCAL_AREAS		10
#define EDS_MEDIA			11
#define EDS_NATIONS			12
#define EDS_PEOPLE			13
#define EDS_SPONSORS		14
#define EDS_STADIUMS		15
#define EDS_STADIUM_CHANGES	16
#define EDS_WEATHER			17

#define EDITOR_SECTIONS		17

@class Award, City, Club, Competition, Continent, Currency, Derby, Injury, Language, LocalArea, Media,
Nation, Person, Sponsor, Stadium, StadiumChange, Weather;

@interface EditorController : NSObject {
	IBOutlet NSView *awardSearchView, *awardGeneralView, *awardRulesView, *awardViewContainer;
	
	Award *selectedAward;
	City *selectedCity;
	Club *selectedClub;
	Competition *selectedCompetition;
	Continent *selectedContinent;
	Currency *selectedCurrency;
	Derby *selectedDerby;
	Injury *selectedInjury;
	Language *selectedLanguage;
	LocalArea *selectedLocalArea;
	Media *selectedMedia;
	Nation *selectedNation;
	Person *selectedPerson;
	Sponsor *selectedSponsor;
	Stadium *selectedStadium;
	StadiumChange *selectedStadiumChange;
	Weather *selectedWeather;
	
	int currentSection;
	
	NSMutableArray *awardSections, *clubSections, *mediaSections, *nationSections, *personSections;
	NSMutableArray *searchResults;
}

- (void)showAwards:(id)sender;

- (void)selectSection:(int)newSection;
- (void)selectEntitySection:(id)sender;

- (NSArray *)awardSectionStrings;

@property(readwrite,assign) int currentSection;
@property(readwrite,assign) Award *selectedAward;
@property(readwrite,assign) City *selectedCity;
@property(readwrite,assign) Club *selectedClub;
@property(readwrite,assign) Competition *selectedCompetition;
@property(readwrite,assign) Continent *selectedContinent;
@property(readwrite,assign) Currency *selectedCurrency;
@property(readwrite,assign) Derby *selectedDerby;
@property(readwrite,assign) Injury *selectedInjury;
@property(readwrite,assign) Language *selectedLanguage;
@property(readwrite,assign) LocalArea *selectedLocalArea;
@property(readwrite,assign) Media *selectedMedia;
@property(readwrite,assign) Nation *selectedNation;
@property(readwrite,assign) Person *selectedPerson;
@property(readwrite,assign) Sponsor *selectedSponsor;
@property(readwrite,assign) Stadium *selectedStadium;
@property(readwrite,assign) StadiumChange *selectedStadiumChange;
@property(readwrite,assign) Weather *selectedWeather;

@property(readwrite,copy) NSMutableArray *searchResults; 

@end
