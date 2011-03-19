//
//  SXEditorEntityViewController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EditorController.h"
#import <BWToolkitFramework/BWToolkitFramework.h>

@interface SXEditorEntityViewController : NSViewController {
	IBOutlet NSTableView	*awardsTable, *awardSectionsTable;
	IBOutlet NSBox			*awardBGBox;
	IBOutlet NSView			*awardMainViewContainer, *awardEntityView, *awardGeneralView, *awardRulesView, *awardSectionView;
	IBOutlet BWGradientBox	*awardHeaderBox;
	
	IBOutlet NSTableView	*citiesTable;
	IBOutlet NSView			*cityMainViewContainer, *cityEntityView;
	
	IBOutlet NSTableView	*competitionsTable;
	IBOutlet NSBox			*competitionBGBox;
	IBOutlet BWGradientBox	*competitionHeaderBox;
	IBOutlet NSView			*competitionMainViewContainer, *competitionEntityView;
	
	IBOutlet NSTableView	*continentsTable;
	IBOutlet NSView			*continentMainViewContainer, *continentEntityView;
	
	IBOutlet NSTableView	*currenciesTable;
	IBOutlet NSView			*currencyMainViewContainer, *currencyEntityView;
	
	IBOutlet NSTableView	*derbiesTable;
	IBOutlet NSView			*derbyMainViewContainer, *derbyEntityView;
	
	IBOutlet NSTableView	*injuriesTable;
	IBOutlet NSView			*injuryMainViewContainer, *injuryEntityView;
	
	IBOutlet NSTableView	*languagesTable;
	IBOutlet NSView			*languageMainViewContainer, *languageEntityView;
	
	IBOutlet NSTableView	*localAreasTable;
	IBOutlet NSView			*localAreaMainViewContainer, *localAreaEntityView;
	
	IBOutlet NSTableView	*sponsorsTable;
	IBOutlet NSView			*sponsorMainViewContainer, *sponsorEntityView;
	
	IBOutlet NSTableView	*mediaTable, *mediaSectionsTable;
	IBOutlet NSView			*mediaMainViewContainer, *mediaEntityView, *mediaGeneralView, *mediaAssociationsView, *mediaSectionView;
	IBOutlet BWSheetController *mediaNewClubPicker;
	
	IBOutlet NSTableView	*stadiumChangesTable;
	IBOutlet NSView			*stadiumChangeMainViewContainer, *stadiumChangeEntityView;
	
	IBOutlet NSTableView	*stadiumsTable;
	IBOutlet NSView			*stadiumMainViewContainer, *stadiumEntityView;
	
	IBOutlet NSTableView	*weatherTable;
	IBOutlet NSView			*weatherMainViewContainer, *weatherEntityView;
}

- (IBAction)showCityPicker:(id)sender;
- (IBAction)showClubPicker:(id)sender;
- (IBAction)showCompetitionPicker:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)showNationPicker:(id)sender;
- (IBAction)showPersonPicker:(id)sender;
- (IBAction)showStadiumPicker:(id)sender;

- (void)selectFromTable;
- (void)reloadEntityTable:(int)section;

@property(readwrite,assign) IBOutlet NSView	*awardMainViewContainer, *awardEntityView, *awardGeneralView, *awardRulesView, *awardSectionView,
*cityMainViewContainer, *cityEntityView, *continentMainViewContainer, *continentEntityView,
*currencyMainViewContainer, *currencyEntityView, *localAreaMainViewContainer, *localAreaEntityView,
*stadiumChangeMainViewContainer, *stadiumChangeEntityView, *derbyMainViewContainer, *derbyEntityView,
*injuryMainViewContainer, *injuryEntityView, *languageMainViewContainer, *languageEntityView,
*sponsorMainViewContainer, *sponsorEntityView, *stadiumMainViewContainer, *stadiumEntityView,
*weatherMainViewContainer, *weatherEntityView, *competitionMainViewContainer, *competitionEntityView,
*mediaMainViewContainer, *mediaEntityView, *mediaGeneralView, *mediaAssociationsView, *mediaSectionView;

@end
