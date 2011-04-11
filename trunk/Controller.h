//
//  Controller.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define DEFAULT_GRAPHICS_LOCATION		@"~/Documents/Sports Interactive/Football Manager 2011/graphics"
#define DEFAULT_SHORTLIST_LOCATION		@"~/Documents/Sports Interactive/Football Manager 2011/shortlists"
#define DEFAULT_GAME_LOCATION			@"~/Documents/Sports Interactive/Football Manager 2011/games"
#define DEFAULT_LANGDB_LOCATION			@"/Applications/Sports Interactive/Football Manager 2011/data/db/1100/lang_db.dat"
#define DEFAULT_STEAM_LANGDB_LOCATION	@"~/Library/Application Support/Steam/SteamApps/Common/Football Manager 2011/data/db/1100/lang_db.dat"
#define DEFAULT_FM_LOCATION				@"/Applications/Sports Interactive/Football Manager 2011"
#define DEFAULT_STEAM_FM_LOCATION		@"~/Library/Application Support/Steam/SteamApps/Common/Football Manager 2011"

@class ContentController;
@class Database;
@class SXFGameInfo;
@class SXFGameDB;
@class SXFSaveGameSummary;
@class SXGraphicsController;
@class FMDate;
@class LangDB;
@class EditorController;

@interface Controller : NSObject {
	IBOutlet NSPanel *donatePanel;
	IBOutlet ContentController *contentController;
	IBOutlet NSArrayController *awardsController, *citiesController, *clubsController, *competitionsController,
			 *continentsController, *currenciesController, *injuriesController, *languagesController, *localAreasController,
			 *mediaController, *nationsController, *peopleController, *stadiumsController, *stadiumChangesController,
			 *teamsController, *weatherController;
	
	Database *database;
	LangDB *langDB;
	SXFGameDB *gameDB;
	SXFGameInfo *gameInfo;
	SXFSaveGameSummary *saveGameSummary;
	SXGraphicsController *graphics;
	EditorController *editorController;
	
	NSWindowController *preferencesWindowController;
	NSThread *gameDBThread;
	NSThread *parseGraphicsThread;
	NSString *gamePath, *status;
	int statusMaxValue, statusValue;
	
	NSMutableDictionary *fileInfos;
	NSMutableDictionary *infoStrings;
	
	FMDate *currentDate, *startDate;
	unsigned short gameDBVersion;
	int databaseChanges, timesSaved, startBuildVersion, currentBuildVersion, saveStartOffset, gameID, mainFileLength;
	
	BOOL idle, dataLoaded, compressed, langDBLoaded, showDetails;
}

- (IBAction)openGame:(id)sender;
- (IBAction)saveGame:(id)sender;
- (void)loadGame:(NSString *)path;
- (void)writeGame:(NSString *)savePath;
- (void)resetDB;
- (void)showPreferences:(id)sender;
- (void)changeLangDbLocation:(id)sender;
- (void)changeGraphicsLocation:(id)sender;
- (void)changeGameLocation:(id)sender;
- (void)changeLangDBLanguage:(id)sender;
- (void)setAutomaticUpdates:(id)sender;
- (void)setAutomaticDownloads:(id)sender;
- (void)launchURL:(id)sender;

- (void)setDonateLater:(id)sender;
- (void)setDonateStopAsking:(id)sender;

@property(assign,readwrite) ContentController *contentController;
@property(assign,readwrite) Database *database;
@property(assign,readwrite) EditorController *editorController;
@property(assign,readwrite) LangDB *langDB;
@property(assign,readwrite) SXFGameDB *gameDB;
@property(assign,readwrite) SXFGameInfo *gameInfo;
@property(assign,readwrite) SXFSaveGameSummary *saveGameSummary;
@property(assign,readwrite) SXGraphicsController *graphics;
@property(copy,readwrite) NSString *gamePath, *status;
@property(copy,readwrite) FMDate *currentDate;
@property(copy,readwrite) NSMutableDictionary *infoStrings;
@property(assign,readwrite) unsigned short gameDBVersion;
@property(assign,readwrite) int databaseChanges, timesSaved, startBuildVersion, currentBuildVersion, gameID, statusMaxValue, statusValue;
@property(assign,readwrite) BOOL idle, dataLoaded, langDBLoaded, showDetails;
@property(assign,readwrite) NSArrayController *awardsController, *citiesController, *clubsController, *competitionsController,
*continentsController, *currenciesController, *injuriesController, *languagesController, *localAreasController,
*mediaController, *nationsController, *peopleController, *stadiumsController, *stadiumChangesController,
*teamsController, *weatherController;

@end
