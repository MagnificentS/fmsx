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

#define CLUB_SECTIONS [NSMutableArray arrayWithObjects:\
[NSDictionary dictionaryWithObjectsAndKeys:@"General",@"title",clubGeneralView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Alternative Stadiums",@"title",clubAlternativeStadiumsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Facilities",@"title",clubFacilitiesView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Finances",@"title",clubFinancesView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Kits & Colours",@"title",clubKitsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Regional Divisions",@"title",clubRegionalDivisionsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Relationships",@"title",clubRelationshipsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"IDPCs",@"title",clubIDPCView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Scouting Knowledges",@"title",clubScoutingKnowledgesView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Sponsors",@"title",clubSponsorsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Staff",@"title",clubStaffView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Tactics",@"title",clubTacticsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Training",@"title",clubTrainingView,@"view",nil],\
nil]


#define NATION_SECTIONS [NSMutableArray arrayWithObjects:\
[NSDictionary dictionaryWithObjectsAndKeys:@"General",@"title",nationGeneralView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Agents",@"title",nationAgentsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Alternative Stadiums",@"title",nationAlternativeStadiumsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Banned Players",@"title",nationBannedPlayersView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Coefficients",@"title",nationCoefficientsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"FIFA Ranking Matches",@"title",nationRankingMatchesView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"FIFA Ranking Points",@"title",nationRankingPointsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Future Regens",@"title",nationFutureRegenView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Human Player Pool",@"title",nationHumanPlayerPoolView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Kits & Colours",@"title",nationKitsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Nations Treated As EU",@"title",nationTreatedAsEUView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Nations Treated As Non-Foreign",@"title",nationTreatedAsNonForeignView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Relationships",@"title",nationRelationshipsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Shortlists",@"title",nationShortlistsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Spoken Languages",@"title",nationSpokenLanguagesView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Staff",@"title",nationStaffView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Tactics",@"title",nationTacticsView,@"view",nil],\
[NSDictionary dictionaryWithObjectsAndKeys:@"Transfer Preferences",@"title",nationTransferPreferencesView,@"view",nil],\
	nil]

@interface SXEditorEntityViewController : NSViewController {
	IBOutlet NSTableView	*awardsTable, *awardSectionsTable;
	IBOutlet NSBox			*awardBGBox;
	IBOutlet NSView			*awardMainViewContainer, *awardEntityView, *awardGeneralView, *awardRulesView, *awardSectionView;
	IBOutlet BWGradientBox	*awardHeaderBox;
	
	IBOutlet NSTableView	*citiesTable;
	IBOutlet NSView			*cityMainViewContainer, *cityEntityView;
	
	IBOutlet NSTableView	*clubsTable, *clubSectionsTable;
	IBOutlet BWGradientBox	*clubHeaderBox;
	IBOutlet NSBox			*clubBGBox;
	IBOutlet NSView			*clubMainViewContainer, *clubEntityView, *clubGeneralView, *clubSectionView, *clubTacticsView, 
	*clubRelationshipsView, *clubAlternativeStadiumsView, *clubKitsView, *clubStaffView,
	*clubScoutingKnowledgesView, *clubIDPCView, *clubRegionalDivisionsView, *clubSponsorsView,
	*clubTrainingView, *clubFacilitiesView, *clubFinancesView;
	
	IBOutlet BWSheetController *clubShirtPicker;
	IBOutlet BWSheetController *clubShortsPicker;
	IBOutlet BWSheetController *clubSocksPicker;	
	
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
	
	IBOutlet NSTableView	*nationsTable, *nationSectionsTable;
	IBOutlet BWGradientBox	*nationHeaderBox;
	IBOutlet NSBox			*nationBGBox;
	IBOutlet NSView			*nationMainViewContainer, *nationEntityView, *nationGeneralView, *nationSectionView,
	*nationBannedPlayersView, *nationAgentsView, *nationCoefficientsView, *nationHumanPlayerPoolView,
	*nationRankingPointsView, *nationShortlistsView, *nationTransferPreferencesView, *nationSpokenLanguagesView,
	*nationTreatedAsEUView, *nationTreatedAsNonForeignView, *nationRankingMatchesView, *nationFutureRegenView,
	*nationTacticsView, *nationStaffView, *nationRelationshipsView, *nationAlternativeStadiumsView,
	*nationKitsView;
	NSMutableArray *nationSections;
	
	IBOutlet BWSheetController *shirtPicker;
	IBOutlet BWSheetController *shortsPicker;
	IBOutlet BWSheetController *socksPicker;	
	
	IBOutlet NSTableView	*peopleTable, *peopleSectionsTable;
	IBOutlet NSView			*personMainViewContainer, *personEntityView, *personGeneralView, *personSectionView,
	*personActualPersonView, *personSpokespersonView, *personHumanView, *personRetiredPersonView, *personAgentView,
	*personJournalistView, *personOfficialView, *personOfficialPastGamesView, *personStatsView, *personActualStaffView,
	*personPreferredMovesView, *personPlayerView, *personNonPlayerView, *personNonPlayerStatsView, *personInjuriesView,
	*personBansView, *personPlayerFormsView, *personPlayerStatsView, *personRelationshipsView, *personContractsView,
	*personDebugPersonView;
	
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
*mediaMainViewContainer, *mediaEntityView, *mediaGeneralView, *mediaAssociationsView, *mediaSectionView,
*nationMainViewContainer, *nationEntityView, *nationGeneralView, *nationSectionView, *nationBannedPlayersView,
*nationAgentsView, *nationCoefficientsView, *nationRankingPointsView, *nationHumanPlayerPoolView,
*nationShortlistsView, *nationSpokenLanguagesView, *nationTransferPreferencesView, *nationTreatedAsEUView,
*nationTreatedAsNonForeignView, *nationRankingMatchesView, *nationFutureRegenView, *nationTacticsView,
*nationStaffView, *nationRelationshipsView, *nationAlternativeStadiumsView, *nationKitsView,
*personMainViewContainer, *personEntityView, *personGeneralView, *personSectionView, *personActualPersonView,
*personSpokespersonView, *personHumanView, *personRetiredPersonView, *personAgentView, *personJournalistView,
*personOfficialView, *personOfficialPastGamesView, *personStatsView, *personActualStaffView, *personPreferredMovesView,
*personPlayerView, *personNonPlayerView, *personNonPlayerStatsView, *personInjuriesView, *personBansView, *personPlayerFormsView,
*personPlayerStatsView, *personRelationshipsView, *personContractsView, *personDebugPersonView,
*clubMainViewContainer, *clubEntityView, *clubGeneralView, *clubSectionView, *clubTacticsView, *clubStaffView,
*clubRelationshipsView, *clubAlternativeStadiumsView, *clubKitsView, *clubScoutingKnowledgesView, *clubIDPCView, *clubRegionalDivisionsView,
*clubSponsorsView, *clubTrainingView, *clubFacilitiesView, *clubFinancesView;

@end
