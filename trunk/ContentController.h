//
//  ContentController.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MGScopeBarDelegateProtocol.h"
#import <BWToolkitFramework/BWToolkitFramework.h>

// Keys for our sample data.
#define MGSB_GROUP_LABEL			@"Label"			// string
#define MGSB_GROUP_SEPARATOR		@"HasSeparator"		// BOOL as NSNumber
#define MGSB_GROUP_SELECTION_MODE	@"SelectionMode"	// MGScopeBarGroupSelectionMode (int) as NSNumber
#define MGSB_GROUP_ITEMS			@"Items"			// array of dictionaries, each containing the following keys:
#define MGSB_ITEM_IDENTIFIER		@"Identifier"		// string
#define MGSB_ITEM_NAME				@"Name"				// string

@class Controller;

@interface ContentController : NSObject <MGScopeBarDelegate> {
	IBOutlet Controller *controller;
	IBOutlet MGScopeBar *clubScopeBar, *personScopeBar, *nationScopeBar, *awardScopeBar, *mediaScopeBar;
	IBOutlet NSOutlineView *mainOutlineView;
	IBOutlet NSView *gameInfoView;
	IBOutlet NSBox *mainContainer;
	
	
	
	
	IBOutlet NSBox *mainViewContainer;
	IBOutlet NSView *editorView, *scoutView, *IDLookupView;
	IBOutlet NSView *placeholderView;
	NSMutableArray *entityIndexArray;
	
	
	
	
	
	IBOutlet NSBox *awardContainer;
	IBOutlet BWGradientBox *awardHeaderBackground;
	IBOutlet NSTableView *awardTable;
	IBOutlet NSView *awardSearchView, *awardGeneralView, *awardRulesView, *awardMainView;
	IBOutlet NSArrayController *awardController;
	
	IBOutlet NSTableView *cityTable;
	IBOutlet NSView *citySearchView, *cityGeneralView;
	IBOutlet NSArrayController *cityController;
	
	IBOutlet NSBox *clubContainer;
	IBOutlet BWGradientBox *clubHeaderBackground;
	IBOutlet NSTableView *clubTable, *clubAlternateKitsTable, *clubKitTable;
	IBOutlet NSView *clubSearchView, *clubGeneralView, *clubTacticsView, *clubMainView, *clubTrainingView,
	*clubCoefficientView, *clubScoutingKnowledgeView, *clubRegionalDivisionsView, *clubSponsorView, *clubIDPCView,
	*clubShortlistedPeopleView, *clubAlternateKitView, *clubFinanceView, *clubStaffView, *clubTeamsView,
	*clubRelationshipsView, *clubKitView, *clubLBCView, *clubFacilitiesView;
	IBOutlet NSArrayController *clubController;
	
	IBOutlet NSBox *nationContainer;
	IBOutlet BWGradientBox *nationHeaderBackground;
	IBOutlet NSTableView *nationTable, *nationAlternateKitsTable;
	IBOutlet NSView *nationSearchView, *nationGeneralView, *nationMainView, *nationRelationshipsView;
	IBOutlet NSArrayController *nationController;
	
	IBOutlet NSTableView *competitionTable;
	IBOutlet BWGradientBox *competitionHeaderBackground;
	IBOutlet NSView *competitionSearchView, *competitionGeneralView;
	IBOutlet NSArrayController *competitionController;
	
	IBOutlet NSTableView *continentTable;
	IBOutlet NSView *continentSearchView, *continentGeneralView;
	IBOutlet NSArrayController *continentController;
	
	IBOutlet NSTableView *currencyTable;
	IBOutlet NSView *currencySearchView, *currencyGeneralView;
	IBOutlet NSArrayController *currencyController;
	
	IBOutlet NSTableView *derbyTable;
	IBOutlet NSView *derbySearchView, *derbyGeneralView;
	IBOutlet NSArrayController *derbyController;
	
	IBOutlet NSTableView *injuryTable;
	IBOutlet NSView *injurySearchView, *injuryGeneralView;
	IBOutlet NSArrayController *injuryController;
	
	IBOutlet NSTableView *languageTable;
	IBOutlet NSView *languageSearchView, *languageGeneralView;
	IBOutlet NSArrayController *languageController;
	
	IBOutlet NSTableView *localAreaTable;
	IBOutlet NSView *localAreaSearchView, *localAreaGeneralView;
	IBOutlet NSArrayController *localAreaController;
	
	IBOutlet NSBox *mediaContainer;
	IBOutlet NSTableView *mediaTable;
	IBOutlet NSView *mediaSearchView, *mediaGeneralView, *mediaAssociationsView, *mediaMainView;
	IBOutlet NSArrayController *mediaController;
	
	IBOutlet NSBox *personContainer;
	IBOutlet NSTableView *peopleTable;
	IBOutlet NSView *peopleSearchView, *peopleGeneralView, *actualPersonView,
	*actualPlayerView, *actualNonPlayerView, *officialView, *journalistView,
	*retiredPersonView, *humanView, *personStatsView, *playerStatsView, *nonPlayerStatsView,
	*actualStaffView, *playerInjuryView, *playerBanView, *playerFormView, *contractView, *ppmView,
	*personRelationshipsView, *agentView;
	IBOutlet NSArrayController *peopleController;
	
	IBOutlet NSTableView *sponsorTable;
	IBOutlet NSView *sponsorSearchView, *sponsorGeneralView;
	IBOutlet NSArrayController *sponsorController;
	
	IBOutlet NSTableView *stadiumTable;
	IBOutlet NSView *stadiumSearchView, *stadiumGeneralView;
	IBOutlet NSArrayController *stadiumController;
	
	IBOutlet NSTableView *stadiumChangeTable;
	IBOutlet NSView *stadiumChangeSearchView, *stadiumChangeGeneralView;
	IBOutlet NSArrayController *stadiumChangeController;
	
	IBOutlet NSTableView *weatherTable;
	IBOutlet NSView *weatherSearchView, *weatherGeneralView;
	IBOutlet NSArrayController *weatherController;
	
	// relationship adder
	IBOutlet NSComboBox *relationshipType;
	IBOutlet NSTextField *levelField;
	
	// Pickers
	IBOutlet NSArrayController *nationPickerController;
	IBOutlet BWSheetController *nationPicker;
	id nationPickerObject;
	NSString *nationPickerSelector;
	
	IBOutlet NSArrayController *competitionPickerController;
	IBOutlet BWSheetController *competitionPicker;
	id competitionPickerObject;
	NSString *competitionPickerSelector;
	
	IBOutlet NSArrayController *cityPickerController;
	IBOutlet BWSheetController *cityPicker;
	id cityPickerObject;
	NSString *cityPickerSelector;
	
	IBOutlet NSArrayController *stadiumPickerController;
	IBOutlet BWSheetController *stadiumPicker;
	id stadiumPickerObject;
	NSString *stadiumPickerSelector;
	
	IBOutlet NSArrayController *personPickerController;
	IBOutlet BWSheetController *personPicker;
	id personPickerObject;
	NSString *personPickerSelector;
	
	IBOutlet NSArrayController *mediaPickerController;
	IBOutlet BWSheetController *mediaPicker;
	id mediaPickerObject;
	NSString *mediaPickerSelector;
	
	
	IBOutlet NSArrayController *shortlistController;
	IBOutlet NSView *shortlistView;
	
	NSMutableArray *sections, *awardSections, *clubSections, *nationSections, *personSections, *scoutResults, 
	*activeShortlist, *clubScoutResults, *staffScoutResults, *playerScoutResults, *recentlyViewed,
	*mediaSections;
	NSMutableDictionary *selectedRows;
	
	NSString *locationString;
}

- (void)setFavourites;
- (void)reloadOutlineView;
- (void)selectItem:(id)object;
- (void)addToFavourites:(id)sender;
- (IBAction)showGameInfo:(id)sender;

- (IBAction)deleteHistory:(id)sender;

- (IBAction)showNationPicker:(id)sender;
- (IBAction)setNationPickerObject:(id)object;
- (IBAction)pickNation:(id)sender;
- (IBAction)showCompetitionPicker:(id)sender;
- (IBAction)setCompetitionPickerObject:(id)object;
- (IBAction)pickCompetition:(id)sender;
- (IBAction)showStadiumPicker:(id)sender;
- (IBAction)setStadiumPickerObject:(id)object;
- (IBAction)pickStadium:(id)sender;
- (IBAction)showCityPicker:(id)sender;
- (IBAction)setCityPickerObject:(id)object;
- (IBAction)pickCity:(id)sender;
- (IBAction)showPersonPicker:(id)sender;
- (IBAction)setPersonPickerObject:(id)object;
- (IBAction)pickPerson:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)setMediaPickerObject:(id)object;
- (IBAction)pickMedia:(id)sender;

- (void)replacePlaceholder:(NSView *)placeholder withView:(NSView *)view;

- (void)addRelationship:(id)sender;

@property(readonly,assign) NSArrayController *awardController, *cityController, *clubController, *nationController, 
*competitionController, *continentController, *injuryController, *currencyController, 
*languageController, *localAreaController, *mediaController, *peopleController, *derbyController,
*sponsorController, *stadiumController, *stadiumChangeController, *weatherController;
@property(readonly,assign) NSBox *clubContainer, *personContainer, *mainContainer;
@property(readonly,assign) NSView *placeholderView, *gameInfoView, *awardSearchView, 
*awardGeneralView, *awardRulesView, *awardMainView, *citySearchView, *cityGeneralView, *continentSearchView, 
*continentGeneralView, *currencyGeneralView, *currencySearchView, *agentView,
*injuryGeneralView, *injurySearchView, *languageGeneralView, *languageSearchView,
*localAreaGeneralView, *localAreaSearchView, *stadiumGeneralView, *stadiumSearchView,
*weatherGeneralView, *weatherSearchView, *mediaGeneralView, *mediaSearchView,
*stadiumChangeGeneralView, *stadiumChangeSearchView, *clubGeneralView, *clubMainView,
*clubSearchView, *clubTacticsView, *clubTrainingView, *clubCoefficientView,
*peopleSearchView, *peopleGeneralView, *competitionGeneralView, *competitionSearchView,
*actualPersonView, *actualPlayerView, *sponsorGeneralView, *sponsorSearchView,
*nationGeneralView, *nationMainView, *nationSearchView, *personRelationshipsView,
*clubRelationshipsView, *nationRelationshipsView, *derbyGeneralView, *derbySearchView,
*clubKitView, *clubLBCView, *clubFacilitiesView;

@property(readwrite,copy) NSString *locationString;
@property(readwrite,copy) NSMutableArray *recentlyViewed, *entityIndexArray;
@property(readwrite,copy) NSMutableDictionary *selectedRows;

- (IBAction)selectEditorView:(id)sender;
- (IBAction)selectScoutView:(id)sender;
- (IBAction)selectIDLookupView:(id)sender;

@end
