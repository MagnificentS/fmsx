//
//  Controller.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EditorController.h"

#import "Controller.h"
#import "ContentController.h"
#import "LangDBLoader.h"
#import "LanguageIDs.h"
#import "GameVersions.h"
#import "FMDateLoader.h"
#import "FMString.h"
#import "Database.h"
#import "SupportFunctions.h"

#import "SXFGameDB.h"
#import "SXFGameDBLoader.h"
#import "SXFGameInfo.h"
#import "SXFGameInfoLoader.h"
#import "SXFSaveGameSummary.h"
#import "SXFSaveGameSummaryLoader.h"
#import "SXGraphicsController.h"

#import "SXzlib.h"
#import "SXGeneralViewController.h"
#import "SXLanguagesViewController.h"
#import "SXUpdatesViewController.h"
#import "MBPreferencesController.h"
#import "SXScoutViewController.h"

#import <Sparkle/SUUpdater.h>

@implementation Controller

@synthesize database, gamePath, idle, dataLoaded, infoStrings, awardsController, citiesController, clubsController, saveGameSummary,
continentsController, currenciesController, injuriesController, languagesController, localAreasController, gameID, gameInfo, gameDB,
mediaController, nationsController, peopleController, stadiumsController, stadiumChangesController, competitionsController, langDB,
teamsController, weatherController, currentDate, gameDBVersion, databaseChanges, timesSaved, startBuildVersion, currentBuildVersion, 
langDBLoaded, status, statusMaxValue, statusValue, editorController, contentController, graphics;

- (id)init
{
	[super init];
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lang_db_location"]==nil ||
		![[NSFileManager defaultManager] fileExistsAtPath:[[NSUserDefaults standardUserDefaults] objectForKey:@"lang_db_location"]]) {
		[[NSUserDefaults standardUserDefaults] setObject:DEFAULT_LANGDB_LOCATION forKey:@"lang_db_location"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"graphicsLocation"]==nil ||
		![[NSFileManager defaultManager] fileExistsAtPath:[[NSUserDefaults standardUserDefaults] objectForKey:@"graphicsLocation"]]) {
		[[NSUserDefaults standardUserDefaults] setObject:DEFAULT_GRAPHICS_LOCATION forKey:@"graphicsLocation"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gameLocation"]==nil ||
		![[NSFileManager defaultManager] fileExistsAtPath:[[NSUserDefaults standardUserDefaults] objectForKey:@"gameLocation"]]) {
		[[NSUserDefaults standardUserDefaults] setObject:DEFAULT_GAME_LOCATION forKey:@"gameLocation"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"loadLangDB"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"loadLangDB"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"langDBLanguage"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:LID_ENGLISH] forKey:@"langDBLanguage"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"parseGraphics"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"parseGraphics"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"backupBeforeSave"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"backupBeforeSave"];
	}

	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"autoUpdate"] ||
		[[NSUserDefaults standardUserDefaults] boolForKey:@"autoDownload"]) {
		[[SUUpdater sharedUpdater] checkForUpdatesInBackground];
	}
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"autoUpdate"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"autoUpdate"];
		[[SUUpdater sharedUpdater] setAutomaticallyChecksForUpdates:[[NSUserDefaults standardUserDefaults] boolForKey:@"autoUpdate"]];
	}
	
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"autoDownload"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"autoDownload"];
		[[SUUpdater sharedUpdater] setAutomaticallyDownloadsUpdates:[[NSUserDefaults standardUserDefaults] boolForKey:@"autoDownload"]];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"hasDonated"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"hasDonated"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"donateLastAsked"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:[NSDate dateWithString:@"2010-01-01 10:45:32 +0000"] forKey:@"donateLastAsked"];
	}
	if ([[NSUserDefaults standardUserDefaults] objectForKey:@"donateNeverAsk"]==nil) {
		[[NSUserDefaults standardUserDefaults] setObject:@"No" forKey:@"donateNeverAsk"];
	}
	
	fileInfos = [[NSMutableDictionary alloc] init];

	gameDB = [[SXFGameDB alloc] init];
	gameInfo = [[SXFGameInfo alloc] init];
	saveGameSummary = [[SXFSaveGameSummary alloc] init];
	graphics = [[SXGraphicsController alloc] init];
	
	editorController = [[EditorController alloc] init];
	
	[self setIdle:TRUE];
	[self setDataLoaded:FALSE];
	
	return self;
}

- (void)dealloc
{
	[fileInfos release];
	
	[gameInfo release];
	[gameDB release];
	[saveGameSummary release];
	[graphics release];
	
	[editorController release];
	
	[super dealloc];
}

- (void)awakeFromNib
{
	SXGeneralViewController *general = [[SXGeneralViewController alloc] initWithNibName:@"PreferencesGeneral" bundle:nil];
	SXLanguagesViewController *languages = [[SXLanguagesViewController alloc] initWithNibName:@"PreferencesLanguages" bundle:nil];
	SXUpdatesViewController *updates = [[SXUpdatesViewController alloc] initWithNibName:@"PreferencesUpdates" bundle:nil];
	[[MBPreferencesController sharedController] setModules:[NSArray arrayWithObjects:general, updates, languages, nil]];
	
	[general release];
	[languages release];
	[updates release];
	
	if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"donateLastAsked"] timeIntervalSinceNow] < -604800 &&
		![[NSUserDefaults standardUserDefaults] boolForKey:@"donateNeverAsk"])
	{
		[donatePanel makeKeyAndOrderFront:self];
	}
	
	if ([[[[NSDate date] description] substringWithRange:NSMakeRange(5, 5)] isEqualToString:@"02-27"]) {
		NSAlert *alert = [NSAlert alertWithMessageText:@"Did You Know?" defaultButton:@"OK" alternateButton:@"Donate" 
										   otherButton:nil informativeTextWithFormat:@"Today is littleblue's birthday!\n\nlittleblue is the founder and main developer of FM11SX and is not feeling very young anymore so why not cheer her up by heading over to the FM11SX thread at http://community.sigames.com and wishing her a happy birthday?\n\nShe will also never say no to a box of chocolates! :o)"];
		NSLog(@"Happy Birthday littleblue!");
		int result = [alert runModal];
		if (result == 0) {
			[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=aoumi83%40gmail%2ecom&lc=GB&item_name=FM11SX&currency_code=GBP"]];
		}
	}
}

- (void)resetDB
{
	[self setDataLoaded:FALSE];
	[database release];
	database = [[Database alloc] init];
}

- (IBAction)openGame:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	
	// Set only files of type .fm to be visible 
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"fm",nil]];
	// Point file browser at know fm saved game location
	[op setDirectory:[[NSUserDefaults standardUserDefaults] stringForKey:@"gameLocation"]];
	
	int result = [op runModal];
	
	// Once the user selects a file
	if (result==NSFileHandlingPanelOKButton) {
		// Set the saved game path to be what they selected
		[self setGamePath:[op filename]];
		
		// Adds the path to the "open recent" menu in OS X
		[[NSDocumentController sharedDocumentController] noteNewRecentDocumentURL:[op URL]];
		
		// Check if saved game has been fully loaded (and releases any previously loaded files)
		if (dataLoaded) { [self resetDB]; }
		
		// setup gameDB thread
		gameDBThread = [[NSThread alloc] initWithTarget:self selector:@selector(loadGame:) object:gamePath];
		// start  graphics threads if required
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"parseGraphics"]==TRUE) { 
			parseGraphicsThread = [[NSThread alloc] initWithTarget:self selector:@selector(parseGraphics) object:nil];
			[parseGraphicsThread start]; 
			[parseGraphicsThread release];
		}
		
		// Start game database load thread
		[gameDBThread start];
		[gameDBThread release];
	}
}

- (void)loadGame:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) { 
		[self setStatus:NSLocalizedString(@"loading lang_db.dat", @"editor status")];
		langDB = [LangDBLoader readFromFile:[[NSUserDefaults standardUserDefaults] stringForKey:@"lang_db_location"]];
	}
		
	unsigned int gameLength;
	
	[self setIdle:FALSE];
	[self setStatus:NSLocalizedString(@"Reading file into memory...", @"editor status")];
	
	// Create file data object
	unsigned int byteOffset = 0; // Offset which dictates where data should be read from
	
	// Load the file into memory
	NSData *gameData = [[NSData alloc] initWithContentsOfFile:path];
	gameLength = [gameData length];
	[self setStatus:NSLocalizedString(@"Reading file header...", @"editor status")];
	
	NSLog(@"File loaded into memory.");
	
	// Skip first two bytes (2nd is endianness)
	byteOffset += 2;
	
	// Check that the file which wer are loading is a standard Football Manager saved game file
	if (![[SupportFunctions readCStringFromData:gameData atOffset:&byteOffset length:4] isEqualToString:@"fmf."]) {
		
		// If it isn't, alert user
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid File", @"error - invalid file") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This does not appear to be a valid FM savegame",@"error - not an FM game")];
		NSLog(@"This does not appear to be a valid FM savegame");
		[alert runModal];
		
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
	//	0x03 unknown
	//		FM08 - 02 00 00
	//		FM09 - 03 00 00
	//		FM10 - 03 00 00
	//		FM11 - 03 00 00
	//	0x04 fmf length
	//	0x04 unknown
	
	// Increment byte offset (as comment above)
	byteOffset += 3;
	
	[gameData getBytes:&mainFileLength range:NSMakeRange(byteOffset, 4)]; byteOffset += 4;
	
	// Increment byte offset (as comment above)
	byteOffset += 4;
	
	// Now check if game is compressed by reading bytes
	[gameData getBytes:&compressed range:NSMakeRange(byteOffset, 1)]; byteOffset += 1;
	// Notify log as appropriate
	if (compressed) { NSLog(@"File Compressed"); }
	else { NSLog(@"File Not Compressed"); } 

	[self setStatus:NSLocalizedString(@"Reading file contents...", @"editor status")];
	
	[SupportFunctions getFileInfosFromData:gameData atOffset:(mainFileLength+18) intoInfos:fileInfos];
	
	NSLog(@"%d sub-files found",[fileInfos count]);
	
#pragma mark game_info.dat
	[self setStatus:NSLocalizedString(@"Reading game_info.dat...", @"editor status")];
	
	if (compressed) {
		[self setGameInfo:[SXFGameInfoLoader readFileFromData:[[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"game_info.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"game_info.dat"] objectForKey:@"compressedFileLength"] intValue])] zlibInflate]]];
	}
	else {
		[self setGameInfo:[SXFGameInfoLoader readFileFromData:[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"game_info.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"game_info.dat"] objectForKey:@"fileLength"] intValue])]]];
	}
	
	if (!gameInfo) { 
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
#pragma mark save_game_summary.dat
	[self setStatus:NSLocalizedString(@"Reading save_game_summary.dat...", @"editor status")];
	
	if (compressed) {
		[self setSaveGameSummary:[SXFSaveGameSummaryLoader readFileFromData:[[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"save_game_summary.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"save_game_summary.dat"] objectForKey:@"compressedFileLength"] intValue])] zlibInflate]]];
	}
	else {
		[self setSaveGameSummary:[SXFSaveGameSummaryLoader readFileFromData:[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"save_game_summary.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"save_game_summary.dat"] objectForKey:@"fileLength"] intValue])]]];
	}
	
	if (!saveGameSummary) { 
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
#pragma mark game_db.dat
	[self setStatus:NSLocalizedString(@"Reading game_db.dat...", @"editor status")];
	
	if (compressed) {
		[SXFGameDBLoader readFileFromData:[[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"game_db.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"game_db.dat"] objectForKey:@"compressedFileLength"] intValue])] zlibInflate] intoObject:gameDB];
	}
	else {
		[SXFGameDBLoader readFileFromData:[gameData subdataWithRange:NSMakeRange(([[[fileInfos objectForKey:@"game_db.dat"] objectForKey:@"startOffset"] intValue] +18),[[[fileInfos objectForKey:@"game_db.dat"] objectForKey:@"fileLength"] intValue])] intoObject:gameDB];
		[gameDB setSaveStartOffset:([gameDB saveStartOffset]+18)];
		[[gameDB database] setSaveEndOffset:([gameDB saveEndOffset]+18)];
	}
	
	if (!gameDB) { 
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
	[gameData release];
	
	[self setIdle:TRUE];
	[self setDataLoaded:TRUE];
	
	[pool drain];
	
	
	/////////////////////////////////
}

- (IBAction)saveGame:(id)sender
{
	BOOL canSave = NO;
	
	if (!canSave) {
		// If not loaded, inform user
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Saving Disabled",@"error - saving is disabled") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"Game saving is currently disabled.",@"error - no game loaded")];
		[alert runModal];
		return;
	}
	
	// Can only use this function if game already successfully loaded
	if (!dataLoaded) {
		// If not loaded, inform user
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Game Not Loaded",@"error - no game loaded") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"You must load an FM savegame before you can save",@"error - no game loaded")];
		[alert runModal];
		return;
	}
	
	// Prompt user to set save location
	NSSavePanel *op = [NSSavePanel savePanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"fm",nil]];
	[op setDirectory:[[NSUserDefaults standardUserDefaults] stringForKey:@"gameLocation"]];
	[op setCanCreateDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		NSThread *saveDBThread = [[NSThread alloc] initWithTarget:self selector:@selector(writeGame:) object:[op filename]];
		// Spawn saveDBThread
		[saveDBThread start];
		[saveDBThread release];
	}
}

- (void)writeGame:(NSString *)savePath
{
	if (compressed) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Game cannot be saved",@"error") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"Only non-compressed save games can be saved at the moment",@"error info")];
		[alert runModal];
		return;
	}
	
	NSLog(@"initialising pool");
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSLog(@"opening file");
	
	NSData *originalFile = [[NSData alloc] initWithContentsOfFile:gamePath];
	
	NSLog(@"file opened");
	
	// Inform user of status
	[self setStatus:NSLocalizedString(@"Preparing To Save...", @"editor status")];
	[self setIdle:FALSE];
	
	// Begin backup operation
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backupBeforeSave"]) {
		[self setStatus:NSLocalizedString(@"Backing up original...", @"editor status")];
		NSString *backupPath = [NSString stringWithFormat:@"%@ Original.%@",[savePath stringByDeletingPathExtension],[savePath pathExtension]];
		int i = 1;
		while ([[NSFileManager defaultManager] fileExistsAtPath:backupPath]) {
			backupPath = [NSString stringWithFormat:@"%@ Original %d.%@",[savePath stringByDeletingPathExtension],i,[savePath pathExtension]];
			i++;
		}
		
		if (![[NSFileManager defaultManager] createFileAtPath:backupPath contents:originalFile attributes:nil]) {
			NSAlert *alert = [NSAlert alertWithMessageText:@"Backup Error" defaultButton:@"OK" alternateButton:nil 
											   otherButton:nil informativeTextWithFormat:@"The original game could not be backed up. The save has been aborted."];
			[alert runModal];
			[self setIdle:TRUE];
			[originalFile release];
			[pool drain];
			return;
		}
	}
	
	[self setStatus:NSLocalizedString(@"saving header...", @"editor status")];
	
	NSMutableData *saveData = [[NSMutableData alloc] init];
	
	[saveData appendData:[originalFile subdataWithRange:NSMakeRange(0,saveStartOffset)]];
	
	[database saveGameDB:saveData];
	
	[self setStatus:NSLocalizedString(@"saving excess...", @"editor status")];
	
	unsigned int originalFmf1length;
	
	// get original length
	[originalFile getBytes:&originalFmf1length range:NSMakeRange(9, 4)];
	
	// append rest of fmf 1 and fmf 2 header
	[saveData appendData:[originalFile subdataWithRange:NSMakeRange([database saveEndOffset],(originalFmf1length + 18) - [database saveEndOffset])]];
	
	// check the change between the two offsets
	unsigned int gameDBDifference = [saveData length] - (originalFmf1length + 18);
	
	// update fmf 1 length to account for change
	unsigned  int newFmf1length = originalFmf1length + gameDBDifference;
	// write back the new length
	[saveData replaceBytesInRange:NSMakeRange(9, 4) withBytes:&newFmf1length];
	
	[self setStatus:NSLocalizedString(@"sorting offsets...", @"editor status")];
	
	// now jump to fmf 2
	unsigned int offset = originalFmf1length + 9;
	
	// 0x01 ?
	// 0x01	endianness
	// 0x04 file type
	// 0x03 03 00 00 in FM10
	offset += 9;
	
	// decompress fmf 2
	NSMutableData *fmf2 = [[NSMutableData alloc] initWithData:[[originalFile subdataWithRange:NSMakeRange(offset, ([originalFile length] - offset))] zlibInflate]];
	
	// parse fmf 2 changing relevant offsets
	unsigned int fmf2Offset = 0;
	short count;
	NSString *filename, *extension;
	BOOL pastGameDB = FALSE;
	unsigned int ibuffer = 0;
	
	// header
	fmf2Offset += 4;
	
	[fmf2 getBytes:&count range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	for (int i=0; i<count; i++) {
		// filename
		filename = [FMString readFromData:fmf2 atOffset:&fmf2Offset];
		if ([filename isEqualToString:@"game_db"]) { pastGameDB = TRUE; }
		// extension
		extension = [FMString readFromData:fmf2 atOffset:&fmf2Offset];
		// start offset
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		if (![filename isEqualToString:@"game_db"]) {
			if (pastGameDB) {
				ibuffer += gameDBDifference; 
				[fmf2 replaceBytesInRange:NSMakeRange((fmf2Offset-4), 4) withBytes:&ibuffer];
			}
		}
		// compressed file length
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		if ([filename isEqualToString:@"game_db"]) { 
			ibuffer += gameDBDifference; 
			[fmf2 replaceBytesInRange:NSMakeRange((fmf2Offset-4), 4) withBytes:&ibuffer];
		}
		// file length
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		if ([filename isEqualToString:@"game_db"]) { 
			ibuffer += gameDBDifference; 
			[fmf2 replaceBytesInRange:NSMakeRange((fmf2Offset-4), 4) withBytes:&ibuffer];
		}
	}
	
	[fmf2 getBytes:&count range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	for (int i=0; i<count; i++) {
		// filename
		filename = [FMString readFromData:fmf2 atOffset:&fmf2Offset];
	}
	
	[fmf2 getBytes:&count range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	for (int i=0; i<count; i++) {
		// filename
		filename = [FMString readFromData:fmf2 atOffset:&fmf2Offset];
		// extension
		extension = [FMString readFromData:fmf2 atOffset:&fmf2Offset];
		// start offset
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		if (pastGameDB) { 
			ibuffer += gameDBDifference; 
			[fmf2 replaceBytesInRange:NSMakeRange((fmf2Offset-4), 4) withBytes:&ibuffer];
		}
		// compressed file length
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		// file length
		[fmf2 getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
	}
	
	[self setStatus:NSLocalizedString(@"saving offsets...", @"editor status")];
	// write fmf 2
	[saveData appendData:[fmf2 zlibDeflate]];
	
	[fmf2 release];
	
	if (![[NSFileManager defaultManager] createFileAtPath:savePath contents:saveData attributes:nil]) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Save Error",@"error - game could not be saved") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"The game could not be saved",@"error - game could not be saved")];
		[alert runModal];
	}
	[saveData release];
	[originalFile release];
	
	[self setIdle:TRUE];
	
	[pool drain];
}

#pragma mark Preferences Functions

- (void)showPreferences:(id)sender
{
	[[MBPreferencesController sharedController] showWindow:sender];
}

- (void)changeLangDbLocation:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setAllowedFileTypes:[NSArray arrayWithObjects:@"dat",nil]];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		
		if ([[[op filename] lastPathComponent] isEqualToString:@"lang_db.dat"]) {
			[[NSUserDefaults standardUserDefaults] setObject:[[op URL] path] forKey:@"lang_db_location"];
			
		}
	}
}
- (void)changeGraphicsLocation:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setCanChooseFiles:NO];
	[op setCanChooseDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		[[NSUserDefaults standardUserDefaults] setObject:[[op URL] path] forKey:@"graphicsLocation"];
	}
}
- (void)changeGameLocation:(id)sender
{
	NSOpenPanel *op = [NSOpenPanel openPanel];
	[op setCanChooseFiles:NO];
	[op setCanChooseDirectories:YES];
	int result = [op runModal];
	if (result==NSFileHandlingPanelOKButton) {
		[[NSUserDefaults standardUserDefaults] setObject:[[op URL] path] forKey:@"gameLocation"];
	}
}
- (void)changeLangDBLanguage:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:[[sender selectedItem] tag]] forKey:@"langDBLanguage"];
	[[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setAutomaticUpdates:(id)sender
{
	[[SUUpdater sharedUpdater] setAutomaticallyChecksForUpdates:[[NSUserDefaults standardUserDefaults] boolForKey:@"autoUpdate"]];
}
- (void)setAutomaticDownloads:(id)sender
{
	[[SUUpdater sharedUpdater] setAutomaticallyDownloadsUpdates:[[NSUserDefaults standardUserDefaults] boolForKey:@"autoDownload"]];
}

- (BOOL)application:(NSApplication *)theApplication openFile:(NSString *)filename
{
	// check it still exists
	BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filename];
	
//	10.6 >
//	[self setGamePath:[NSURL fileURLWithPath:filename]];
//	10.5
	[self setGamePath:filename];
	
	if (dataLoaded) { [self resetDB]; }
	
	gameDBThread = [[NSThread alloc] initWithTarget:self selector:@selector(loadGame:) object:filename];
	[gameDBThread start];
	[gameDBThread release];
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"parseGraphics"]==TRUE) { 
		parseGraphicsThread = [[NSThread alloc] initWithTarget:self selector:@selector(parseGraphics) object:nil];
		[parseGraphicsThread start]; 
		[parseGraphicsThread release];
	}
	
	return fileExists;
}

- (void)launchURL:(id)sender
{
	NSURL *URL;
	
	if ([sender tag]==0) { URL = [NSURL URLWithString:@"http://www.fmscout.com"]; }
	else if ([sender tag]==1) { URL = [NSURL URLWithString:@"http://www.sigames.com"]; }
	else if ([sender tag]==2) { URL = [NSURL URLWithString:@"http://code.google.com/p/fmsx/wiki/UserManual"]; }
	else if ([sender tag]==3) { URL = [NSURL URLWithString:@"https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=aoumi83%40gmail%2ecom&lc=GB&item_name=FM11SX&currency_code=GBP"]; }
	else if ([sender tag]==4) { URL = [NSURL URLWithString:@"http://www.fmcenter.co.uk"]; }
	
	[[NSWorkspace sharedWorkspace] openURL:URL];
}

- (void)setDonateLater:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"donateLastAsked"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[donatePanel close];
}
- (void)setDonateStopAsking:(id)sender
{
	[[NSUserDefaults standardUserDefaults] setObject:@"Yes" forKey:@"donateNeverAsk"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
	[donatePanel close];
}

- (void)parseGraphics
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSLog(@"parsing graphics...");
	[graphics parseGraphics];
	NSLog(@"parsed graphics with %d continents",[[graphics continentLogos] count]);
	
	[pool release];
}

@end
