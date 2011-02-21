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

// scout search file types
#define SCTY_PLAYER		0
#define SCTY_STAFF		1
#define SCTY_CLUB		2

#define SXS_VERSION		1

@class Controller;

@interface ContentController : NSObject <MGScopeBarDelegate> {
	IBOutlet Controller *controller;
	IBOutlet MGScopeBar *clubScopeBar, *personScopeBar, *nationScopeBar, *awardScopeBar;
	IBOutlet NSOutlineView *mainOutlineView;
	IBOutlet NSView *gameInfoView;
	IBOutlet NSBox *mainContainer;
	
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
	
	IBOutlet NSTableView *mediaTable;
	IBOutlet NSView *mediaSearchView, *mediaGeneralView;
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
	
	// Scout
	IBOutlet NSSegmentedControl *scoutSectionControl;
	IBOutlet NSTabView	*scoutSectionTabView;
	NSString *currentPlayerExpression;
	NSString *currentStaffExpression;
	NSString *currentClubExpression;
	
	// Club Scout
	IBOutlet NSSearchField *clubScoutCompSearchField, *clubScoutNationSearchField, *clubScoutClubSearchField;
	IBOutlet NSTableView *clubScoutResultsTable;
	
	// Staff Scout
	IBOutlet NSSearchField *staffTextSearchField;
	IBOutlet NSTableView *staffScoutResultsTable;
	IBOutlet NSPredicateEditor *staffScoutPersonalAttributeEditor, *staffScoutStatEditor;
	IBOutlet NSComboBox *staffScoutContractExpiryBox;
	IBOutlet NSButton *staffScoutRegenButton, *staffScoutNonRegenButton, *staffScoutFemaleButton, 
	*staffScoutMaleButton, *staffScoutShowECStaffOnlyBox;
	
	// Player Scout
	IBOutlet NSSearchField *playerTextSearchField;
	IBOutlet NSPredicateEditor *playerScoutPersonalAttributeEditor, *playerScoutTechnicalAttributeEditor,
	*playerScoutPhysicalAttributeEditor, *playerScoutMentalAttributeEditor;
	IBOutlet NSComboBox *playerScoutContractExpiryBox, *playerScoutTransferStatusBox;
	IBOutlet NSPopUpButton *playerScoutPositionBox;
	IBOutlet NSTableView *playerScoutResultsTable;
	IBOutlet NSPanel *playerScoutPreviewPanel;
	IBOutlet NSButton *playerScoutRegenButton, *playerScoutNonRegenButton, *playerScoutFemaleButton, 
	*playerScoutMaleButton, *playerScoutShowECPlayersOnlyBox, *playerScoutShowInjuredBox, *playerScoutShowBannedBox;
	
	// scout column states
	BOOL showPlayerScoutNameColumn, showPlayerScoutStatusColumn, showPlayerScoutTeamColumn, showPlayerScoutAgeColumn, 
		showPlayerScoutPositionColumn, showPlayerScoutCAColumn, showPlayerScoutPAColumn, showPlayerScoutHomeRepColumn, 
		showPlayerScoutWorldRepColumn, showPlayerScoutCurrentRepColumn, showPlayerScoutConditionColumn, showPlayerScoutGPColumn, 
		showPlayerScoutValueColumn, showPlayerScoutAskingPriceColumn, showPlayerScoutNationColumn, showPlayerScoutHeightColumn,
		showPlayerScoutWeightColumn, showPlayerScoutAdaptabilityColumn, showPlayerScoutAmbitionColumn, showPlayerScoutControversyColumn, 
		showPlayerScoutLoyaltyColumn, showPlayerScoutPressureColumn, showPlayerScoutProfessionalismColumn, showPlayerScoutSportsmanshipColumn, 
		showPlayerScoutTemperamentColumn, showPlayerScoutFullCapsColumn, showPlayerScoutFullGoalsColumn, showPlayerScoutU21CapsColumn, 
		showPlayerScoutU21GoalsColumn, showPlayerScoutManagerRoleColumn, showPlayerScoutAssistantManagerRoleColumn,
		showPlayerScoutCoachRoleColumn, showPlayerScoutGoalkeepingCoachRoleColumn, showPlayerScoutFitnessCoachRoleColumn, 
		showPlayerScoutPhysioRoleColumn, showPlayerScoutScoutRoleColumn,
		showPlayerScoutAccelerationColumn, showPlayerScoutAgilityColumn, showPlayerScoutBalanceColumn, showPlayerScoutInjuryPronenessColumn, 
		showPlayerScoutJumpingColumn, showPlayerScoutNaturalFitnessColumn, showPlayerScoutPaceColumn, showPlayerScoutStaminaColumn, 
		showPlayerScoutStrengthColumn, showPlayerScoutAggressionColumn, showPlayerScoutAnticipationColumn, showPlayerScoutBraveryColumn, 
		showPlayerScoutComposureColumn, showPlayerScoutConcentrationColumn, showPlayerScoutConsistencyColumn, showPlayerScoutCreativityColumn, 
		showPlayerScoutDecisionsColumn, showPlayerScoutDeterminationColumn, showPlayerScoutDirtinessColumn, showPlayerScoutFlairColumn, 
		showPlayerScoutImportantMatchesColumn, showPlayerScoutInfluenceColumn, showPlayerScoutOffTheBallColumn, showPlayerScoutPositioningColumn, 
		showPlayerScoutTeamworkColumn, showPlayerScoutWorkRateColumn, showPlayerScoutThrowingColumn, showPlayerScoutTendencyToPunchColumn, 
		showPlayerScoutAerialAbilityColumn, showPlayerScoutCommandOfAreaColumn, showPlayerScoutCommunicationColumn, showPlayerScoutEccentricityColumn, 
		showPlayerScoutHandlingColumn, showPlayerScoutKickingColumn, showPlayerScoutOneOnOnesColumn, showPlayerScoutReflexesColumn, 
		showPlayerScoutRushingOutColumn, showPlayerScoutCornersColumn, showPlayerScoutCrossingColumn, showPlayerScoutDribblingColumn, 
		showPlayerScoutFinishingColumn, showPlayerScoutFirstTouchColumn, showPlayerScoutFreeKicksColumn, showPlayerScoutHeadingColumn, 
		showPlayerScoutLongShotsColumn, showPlayerScoutLongThrowsColumn, showPlayerScoutMarkingColumn, showPlayerScoutPassingColumn, 
		showPlayerScoutPenaltyTakingColumn, showPlayerScoutTacklingColumn, showPlayerScoutTechniqueColumn, showPlayerScoutVersatilityColumn, 
		showPlayerScoutLeftFootColumn, showPlayerScoutRightFootColumn;
	
	BOOL showStaffScoutNameColumn, showStaffScoutTeamColumn, showStaffScoutAgeColumn, showStaffScoutCAColumn, showStaffScoutPAColumn, showStaffScoutControversyColumn, 
		showStaffScoutHomeRepColumn, showStaffScoutWorldRepColumn, showStaffScoutCurrentRepColumn, showStaffScoutNationColumn, showStaffScoutAdaptabilityColumn, showStaffScoutAmbitionColumn, 
		showStaffScoutLoyaltyColumn, showStaffScoutPressureColumn, showStaffScoutProfessionalismColumn, showStaffScoutSportsmanshipColumn, showStaffScoutTemperamentColumn, showStaffScoutFullCapsColumn, 
		showStaffScoutFullGoalsColumn, showStaffScoutU21CapsColumn, showStaffScoutU21GoalsColumn, showStaffScoutManagerRoleColumn, showStaffScoutAssistantManagerRoleColumn, showStaffScoutCoachRoleColumn, 
		showStaffScoutFitnessCoachRoleColumn, showStaffScoutGoalkeepingCoachRoleColumn, showStaffScoutPhysioRoleColumn, showStaffScoutScoutRoleColumn, showStaffScoutAttackingCoachingColumn, showStaffScoutCoachingTechniqueColumn, 
		showStaffScoutDefendingColumn, showStaffScoutFitnessColumn, showStaffScoutGoalkeepersColumn, showStaffScoutManManagementColumn, showStaffScoutMentalColumn, showStaffScoutOutfieldPlayersColumn, 
		showStaffScoutTacticalColumn, showStaffScoutTechnicalColumn, showStaffScoutWorkingWithYoungstersColumn, showStaffScoutAttackingColumn, showStaffScoutDepthColumn, showStaffScoutDirectnessColumn, 
		showStaffScoutDirtinessAllowanceColumn, showStaffScoutFlamboyancyColumn, showStaffScoutFlexibilityColumn, showStaffScoutFreeRolesColumn, showStaffScoutMarkingColumn, showStaffScoutOffsideColumn, 
		showStaffScoutPressingColumn, showStaffScoutSittingBackColumn, showStaffScoutSquadRotationColumn, showStaffScoutTempoColumn, showStaffScoutUseOfPlaymakerColumn, showStaffScoutUseOfSubsColumn, 
		showStaffScoutWidthColumn, showStaffScoutBusinessColumn, showStaffScoutBuyingPlayersColumn, showStaffScoutDeterminationColumn, showStaffScoutHardnessOfTrainingColumn, showStaffScoutInterferenceColumn, 
		showStaffScoutJudgingPlayerAbilityColumn, showStaffScoutJudgingPlayerPotentialColumn, showStaffScoutLevelOfDisciplineColumn, showStaffScoutMindGamesColumn, showStaffScoutMotivatingColumn, showStaffScoutPatienceColumn, 
		showStaffScoutPhysiotherapyColumn, showStaffScoutResourcesColumn, showStaffScoutTacticalKnowledgeColumn, showStaffScoutJobColumn; 
	
	BOOL showClubScoutNameColumn, showClubScoutCompetitionColumn, showClubScoutPlayerCountColumn, showClubScoutAverageCAColumn, showClubScoutAveragePAColumn, showClubScoutAverageAgeColumn, 
		showClubScoutReputationColumn, showClubScoutYouthSetupColumn, showClubScoutTrainingFacilitiesColumn, showClubScoutBalanceColumn, showClubScoutSeasonTransferBudgetColumn, showClubScoutRemainingTransferBudgetColumn;
	
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
	
	
	IBOutlet NSArrayController *shortlistController;
	IBOutlet NSView *shortlistView;
	
	NSMutableArray *sections, *awardSections, *clubSections, *nationSections, *personSections, *scoutResults, 
	*activeShortlist, *clubScoutResults, *staffScoutResults, *playerScoutResults, *recentlyViewed;
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

// Scout Functions
- (void)awakeScout;
- (IBAction)scoutClubs:(id)sender;
- (IBAction)scoutStaff:(id)sender;
- (IBAction)scoutPlayers:(id)sender;
- (void)exportPlayersToCSV:(NSMutableArray *)array;
- (IBAction)loadSearch:(id)sender;
- (IBAction)saveSearch:(id)sender;
- (IBAction)updatePlayerScoutColumns:(id)sender;
- (IBAction)updateStaffScoutColumns:(id)sender;
- (IBAction)updateClubScoutColumns:(id)sender;
- (IBAction)importShortlist:(id)sender;
- (IBAction)exportShortlist:(id)sender;
- (IBAction)saveAllScoutResultsToShortlist:(id)sender;
- (IBAction)saveSelectedScoutResultsToShortlist:(id)sender;
- (void)saveShortlist:(NSArray *)players atPath:(NSString *)path;


- (void)addRelationship:(id)sender;

- (void)performSpaceKeyPress:(id)sender;


@property(readonly,assign) NSArrayController *awardController, *cityController, *clubController, *nationController, 
*competitionController, *continentController, *injuryController, *currencyController, 
*languageController, *localAreaController, *mediaController, *peopleController, *derbyController,
*sponsorController, *stadiumController, *stadiumChangeController, *weatherController;
@property(readonly,assign) NSBox *clubContainer, *personContainer, *mainContainer;
@property(readonly,assign) NSView *gameInfoView, *awardSearchView, 
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

@property(readwrite,assign) BOOL showPlayerScoutNameColumn, showPlayerScoutStatusColumn, showPlayerScoutTeamColumn, showPlayerScoutAgeColumn, 
showPlayerScoutPositionColumn, showPlayerScoutCAColumn, showPlayerScoutPAColumn, showPlayerScoutHomeRepColumn, 
showPlayerScoutWorldRepColumn, showPlayerScoutCurrentRepColumn, showPlayerScoutConditionColumn, showPlayerScoutGPColumn, 
showPlayerScoutValueColumn, showPlayerScoutAskingPriceColumn, showPlayerScoutNationColumn, showPlayerScoutHeightColumn, showPlayerScoutWeightColumn,
showPlayerScoutAdaptabilityColumn, showPlayerScoutAmbitionColumn, showPlayerScoutControversyColumn, showPlayerScoutLoyaltyColumn, 
showPlayerScoutPressureColumn, showPlayerScoutProfessionalismColumn, showPlayerScoutSportsmanshipColumn, showPlayerScoutTemperamentColumn,
showPlayerScoutFullCapsColumn, showPlayerScoutFullGoalsColumn, showPlayerScoutU21CapsColumn, showPlayerScoutU21GoalsColumn,
showPlayerScoutManagerRoleColumn, showPlayerScoutAssistantManagerRoleColumn,
showPlayerScoutCoachRoleColumn, showPlayerScoutGoalkeepingCoachRoleColumn, showPlayerScoutFitnessCoachRoleColumn, 
showPlayerScoutPhysioRoleColumn, showPlayerScoutScoutRoleColumn,
showPlayerScoutAccelerationColumn, showPlayerScoutAgilityColumn, showPlayerScoutBalanceColumn, showPlayerScoutInjuryPronenessColumn, 
showPlayerScoutJumpingColumn, showPlayerScoutNaturalFitnessColumn, showPlayerScoutPaceColumn, showPlayerScoutStaminaColumn, 
showPlayerScoutStrengthColumn, showPlayerScoutAggressionColumn, showPlayerScoutAnticipationColumn, showPlayerScoutBraveryColumn, 
showPlayerScoutComposureColumn, showPlayerScoutConcentrationColumn, showPlayerScoutConsistencyColumn, showPlayerScoutCreativityColumn, 
showPlayerScoutDecisionsColumn, showPlayerScoutDeterminationColumn, showPlayerScoutDirtinessColumn, showPlayerScoutFlairColumn, 
showPlayerScoutImportantMatchesColumn, showPlayerScoutInfluenceColumn, showPlayerScoutOffTheBallColumn, showPlayerScoutPositioningColumn, 
showPlayerScoutTeamworkColumn, showPlayerScoutWorkRateColumn, showPlayerScoutThrowingColumn, showPlayerScoutTendencyToPunchColumn, 
showPlayerScoutAerialAbilityColumn, showPlayerScoutCommandOfAreaColumn, showPlayerScoutCommunicationColumn, showPlayerScoutEccentricityColumn, 
showPlayerScoutHandlingColumn, showPlayerScoutKickingColumn, showPlayerScoutOneOnOnesColumn, showPlayerScoutReflexesColumn, 
showPlayerScoutRushingOutColumn, showPlayerScoutCornersColumn, showPlayerScoutCrossingColumn, showPlayerScoutDribblingColumn, 
showPlayerScoutFinishingColumn, showPlayerScoutFirstTouchColumn, showPlayerScoutFreeKicksColumn, showPlayerScoutHeadingColumn, 
showPlayerScoutLongShotsColumn, showPlayerScoutLongThrowsColumn, showPlayerScoutMarkingColumn, showPlayerScoutPassingColumn, 
showPlayerScoutPenaltyTakingColumn, showPlayerScoutTacklingColumn, showPlayerScoutTechniqueColumn, showPlayerScoutVersatilityColumn, 
showPlayerScoutLeftFootColumn, showPlayerScoutRightFootColumn,
showStaffScoutNameColumn, showStaffScoutTeamColumn, showStaffScoutAgeColumn, showStaffScoutCAColumn, showStaffScoutPAColumn, showStaffScoutControversyColumn, 
showStaffScoutHomeRepColumn, showStaffScoutWorldRepColumn, showStaffScoutCurrentRepColumn, showStaffScoutNationColumn, showStaffScoutAdaptabilityColumn, showStaffScoutAmbitionColumn, 
showStaffScoutLoyaltyColumn, showStaffScoutPressureColumn, showStaffScoutProfessionalismColumn, showStaffScoutSportsmanshipColumn, showStaffScoutTemperamentColumn, showStaffScoutFullCapsColumn, 
showStaffScoutFullGoalsColumn, showStaffScoutU21CapsColumn, showStaffScoutU21GoalsColumn, showStaffScoutManagerRoleColumn, showStaffScoutAssistantManagerRoleColumn, showStaffScoutCoachRoleColumn, 
showStaffScoutFitnessCoachRoleColumn, showStaffScoutGoalkeepingCoachRoleColumn, showStaffScoutPhysioRoleColumn, showStaffScoutScoutRoleColumn, showStaffScoutAttackingCoachingColumn, showStaffScoutCoachingTechniqueColumn, 
showStaffScoutDefendingColumn, showStaffScoutFitnessColumn, showStaffScoutGoalkeepersColumn, showStaffScoutManManagementColumn, showStaffScoutMentalColumn, showStaffScoutOutfieldPlayersColumn, 
showStaffScoutTacticalColumn, showStaffScoutTechnicalColumn, showStaffScoutWorkingWithYoungstersColumn, showStaffScoutAttackingColumn, showStaffScoutDepthColumn, showStaffScoutDirectnessColumn, 
showStaffScoutDirtinessAllowanceColumn, showStaffScoutFlamboyancyColumn, showStaffScoutFlexibilityColumn, showStaffScoutFreeRolesColumn, showStaffScoutMarkingColumn, showStaffScoutOffsideColumn, 
showStaffScoutPressingColumn, showStaffScoutSittingBackColumn, showStaffScoutSquadRotationColumn, showStaffScoutTempoColumn, showStaffScoutUseOfPlaymakerColumn, showStaffScoutUseOfSubsColumn, 
showStaffScoutWidthColumn, showStaffScoutBusinessColumn, showStaffScoutBuyingPlayersColumn, showStaffScoutDeterminationColumn, showStaffScoutHardnessOfTrainingColumn, showStaffScoutInterferenceColumn, 
showStaffScoutJudgingPlayerAbilityColumn, showStaffScoutJudgingPlayerPotentialColumn, showStaffScoutLevelOfDisciplineColumn, showStaffScoutMindGamesColumn, showStaffScoutMotivatingColumn, showStaffScoutPatienceColumn, 
showStaffScoutPhysiotherapyColumn, showStaffScoutResourcesColumn, showStaffScoutTacticalKnowledgeColumn, showStaffScoutJobColumn,
showClubScoutNameColumn, showClubScoutCompetitionColumn, showClubScoutPlayerCountColumn, showClubScoutAverageCAColumn, showClubScoutAveragePAColumn, showClubScoutAverageAgeColumn, 
showClubScoutReputationColumn, showClubScoutYouthSetupColumn, showClubScoutTrainingFacilitiesColumn, showClubScoutBalanceColumn, showClubScoutSeasonTransferBudgetColumn, showClubScoutRemainingTransferBudgetColumn;

@property(readwrite,copy) NSString *locationString, *currentPlayerExpression, *currentStaffExpression, *currentClubExpression;
@property(readwrite,copy) NSMutableArray *scoutResults, *clubScoutResults, *staffScoutResults, 
*playerScoutResults, *recentlyViewed;
@property(readwrite,copy) NSMutableDictionary *selectedRows;

@end
