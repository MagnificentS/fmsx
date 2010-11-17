//
//  Controller.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define DEFAULT_GRAPHICS_LOCATION	@"~/Documents/Sports Interactive/Football Manager 2011/graphics"
#define DEFAULT_SHORTLIST_LOCATION	@"~/Documents/Sports Interactive/Football Manager 2011/shortlists"
#define DEFAULT_GAME_LOCATION		@"~/Documents/Sports Interactive/Football Manager 2011/games"
#define DEFAULT_LANGDB_LOCATION		@"/Applications/Sports Interactive/Football Manager 2011/data/db/1100/lang_db.dat"

@class ContentController;
@class Database;
@class FMDate;

@interface Controller : NSObject {
	IBOutlet NSPanel *donatePanel;
	IBOutlet ContentController *contentController;
	IBOutlet NSArrayController *awardsController, *citiesController, *clubsController, *competitionsController,
			 *continentsController, *currenciesController, *injuriesController, *languagesController, *localAreasController,
			 *mediaController, *nationsController, *peopleController, *stadiumsController, *stadiumChangesController,
			 *teamsController, *weatherController;
	
	Database *database;
	
	NSWindowController *preferencesWindowController;
	NSThread *gameDBThread;
	NSThread *parseGraphicsThread;
	NSString *gamePath;
	
	NSMutableDictionary *infoStrings;
	
	FMDate *currentDate, *startDate;
	unsigned short gameDBVersion;
	int databaseChanges, timesSaved, startBuildVersion, currentBuildVersion, saveStartOffset, gameID;
	
	BOOL idle, dataLoaded, compressed;
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

@property(assign,readwrite) Database *database;
@property(copy,readwrite) NSString *gamePath;
@property(copy,readwrite) FMDate *currentDate;
@property(copy,readwrite) NSMutableDictionary *infoStrings;
@property(assign,readwrite) unsigned short gameDBVersion;
@property(assign,readwrite) int databaseChanges, timesSaved, startBuildVersion, currentBuildVersion, gameID;
@property(assign,readwrite) BOOL idle, dataLoaded;
@property(assign,readwrite) NSArrayController *awardsController, *citiesController, *clubsController, *competitionsController,
*continentsController, *currenciesController, *injuriesController, *languagesController, *localAreasController,
*mediaController, *nationsController, *peopleController, *stadiumsController, *stadiumChangesController,
*teamsController, *weatherController;

@end
