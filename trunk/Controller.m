//
//  Controller.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"
#import "ContentController.h"
#import "LanguageIDs.h"
#import "GameVersions.h"
#import "FMDateLoader.h"
#import "FMString.h"
#import "Database.h"
#import "SupportFunctions.h"
#import "SXzlib.h"
#import "SXGeneralViewController.h"
#import "SXLanguagesViewController.h"
#import "SXUpdatesViewController.h"
#import "MBPreferencesController.h"
#import <Sparkle/SUUpdater.h>

@implementation Controller

@synthesize database, gamePath, idle, dataLoaded, infoStrings, awardsController, citiesController, clubsController,
continentsController, currenciesController, injuriesController, languagesController, localAreasController, gameID,
mediaController, nationsController, peopleController, stadiumsController, stadiumChangesController, competitionsController,
teamsController, weatherController, currentDate, gameDBVersion, databaseChanges, timesSaved, startBuildVersion, currentBuildVersion;

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
	
	
	infoStrings = [[NSMutableDictionary alloc] init];
	database = [[Database alloc] init];
	[database setController:self];
	
	idle = TRUE;
	
	return self;
}

- (void)dealloc
{
	[infoStrings release];
	[database release];
	
	[super dealloc];
}

- (void)awakeFromNib
{
	SXGeneralViewController *general = [[SXGeneralViewController alloc] initWithNibName:@"PreferencesGeneral" bundle:nil];
	[general setController:self];
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
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"parseGraphics"]==TRUE) { [parseGraphicsThread start]; }
		
		// Start game database load thread
		[gameDBThread start];
	}
}

- (void)loadGame:(NSString *)path
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	BOOL isNewFormat = TRUE;
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadLangDB"]==TRUE) { 
		[database setStatus:NSLocalizedString(@"loading lang_db.dat", @"editor status")];
		[database readLangDB:[[NSUserDefaults standardUserDefaults] stringForKey:@"lang_db_location"]]; 
	}
		
	unsigned int fileLength, gameLength;
	
	[self setIdle:FALSE];
	[database setStatus:NSLocalizedString(@"Reading file header...", @"editor status")];
	
	// Create file data object
	NSData *fileData;
	unsigned int i;
	unsigned int byteOffset = 0; // Offset which dictates where data should be read from
	unsigned int fileOffset = 0;
	
	// Load the file into memory
	NSData *gameData = [[NSData alloc] initWithContentsOfFile:path];
	gameLength = [gameData length];
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
	byteOffset += 11;
	
	// Now check if game is compressed by reading bytes
	[gameData getBytes:&compressed range:NSMakeRange(byteOffset, 1)]; byteOffset += 1;
	// Notify log as appropriate
	if (compressed) { NSLog(@"File Compressed"); }
	else { NSLog(@"File Not Compressed"); } 

	[database setStatus:NSLocalizedString(@"Reading game_info.dat...", @"editor status")];
#pragma mark game_info.dat
	if (compressed) {
		// If file is compressed, inflate it.
		fileData = [[NSData alloc] initWithData:[[gameData subdataWithRange:NSMakeRange(byteOffset, ([gameData length] - byteOffset))] zlibInflate]];
		byteOffset += [[fileData zlibDeflate] length];
		NSLog(@"File inflated");
	}
	else {
		// Otherwise set file length (minus already decided offset)
		fileData = [[NSData alloc] initWithData:[gameData subdataWithRange:NSMakeRange(byteOffset, ([gameData length] - byteOffset))]];
		fileLength = [fileData length];
		[gameData release];
	}
	
	// If file length is wrong (i.e. something bad has happened, exit).
	if ([fileData length] == 0) { 
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}

	//	0x02 unknown
	//	0x04 file type (CString)
	//	0x02 file version
	//	0x09 unknown
	
	// Skip 17 bytes in the new file length (as comment above)
	fileOffset += 17;
	
	char marker;
	[fileData getBytes:&marker range:NSMakeRange(fileOffset,1)];	fileOffset += 1;
	
	// Marker indicates subdirectory. Once reached, read.
	while (marker==6)
	{
		// Read subdirectory
		[FMString readFromData:fileData atOffset:&fileOffset];	
		[fileData getBytes:&marker range:NSMakeRange(fileOffset,1)];	
		fileOffset += 1;
	}
	
	//	0x03 unknown
	//	another 0x01 in fm11
	//	0x04 unknown (-1)
	//	0x01 unknown
	
	// Skip 9 bytes (as comment above)
	fileOffset += 9;
	
	// Start Date
	[FMDateLoader readFromData:fileData atOffset:&fileOffset];
	
	[fileData getBytes:&gameID range:NSMakeRange(fileOffset, 4)]; fileOffset += 4;
	
	//	unknown (Not sure what this is for?)
	fileOffset += 2515;
	
	[fileData getBytes:&timesSaved range:NSMakeRange(fileOffset, 4)]; fileOffset += 4;
	
	// 0x04	???
	// 0x04 date
	fileOffset += 8;
	
	[fileData getBytes:&startBuildVersion range:NSMakeRange(fileOffset, 4)]; fileOffset += 4;
	[fileData getBytes:&currentBuildVersion range:NSMakeRange(fileOffset, 4)]; fileOffset += 4;
	
	fileOffset += 10;
	
	// Log current progress
	NSLog(@"game_info.dat: %d of %d [%d of %d] read",fileOffset,[fileData length],byteOffset,[gameData length]);
	
	// Output current status to user
	[database setStatus:NSLocalizedString(@"Reading save_game_summary.dat...", @"editor status")];
#pragma mark save_game_summary.dat
	
	// Again if compressed, expand file
	if (compressed) {
		[fileData release];
		fileData = [[NSData alloc] initWithData:[[gameData subdataWithRange:NSMakeRange(byteOffset, ([gameData length] - byteOffset))] zlibInflate]];
		byteOffset += [[fileData zlibDeflate] length];
		fileOffset = 0;
	}
	// Check that worked...
	if ([fileData length] == 0) {
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
	//	0x02 unknown
	//	0x04 file type
	//	0x02 file version
	//	0x01 unknown
	
	// Skip 9 bytes (as comment above)
	fileOffset += 9;
	
	// Store number of leagues active for later
	[infoStrings setObject:[FMString readFromData:fileData atOffset:&fileOffset] forKey:@"leaguesActive"];
	// Likewise with current game version
	[infoStrings setObject:[FMString readFromData:fileData atOffset:&fileOffset] forKey:@"FMVersion"];
	
	// Store human manager's and current employment status
	for (i=1;i<=16;i++) {
		[infoStrings setObject:[FMString readFromData:fileData atOffset:&fileOffset] forKey:[NSString stringWithFormat:@"manager%dname",i]];
		[infoStrings setObject:[FMString readFromData:fileData atOffset:&fileOffset] forKey:[NSString stringWithFormat:@"manager%dclub",i]];
	}
	
	// Read last saved date (TBC)
	[FMDateLoader readFromData:fileData atOffset:&fileOffset];
	
	//	0x04 unknown
	//	0x04 no. of managers
	
	// Skip 8 bytes (as comment above)
	fileOffset += 8;
	
	NSLog(@"save_game_summary.dat: %d of %d [%d of %d] read",fileOffset,[fileData length],byteOffset,[gameData length]);
	
	[database setStatus:NSLocalizedString(@"Reading game_db.dat header...", @"editor status")];
#pragma mark game_db.dat
	
	// Again, if compressed, expand
	if (compressed) {
		[fileData release];
		fileData = [[NSData alloc] initWithData:[[gameData subdataWithRange:NSMakeRange(byteOffset, ([gameData length] - byteOffset))] zlibInflate]];
		fileLength = [fileData length];
		[gameData release];
	//	byteOffset += [[fileData zlibDeflate] length];
		fileOffset = 0;
	}
	
	// Check that worked...
	if ([fileData length] == 0) { 
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
	//	0x02 unknown
	//	0x04 file type
	
	// Skip 6 bytes (as comment above)
	fileOffset += 6;
	
	//Red current game database version
	[fileData getBytes:&gameDBVersion range:NSMakeRange(fileOffset, 2)]; fileOffset += 2;
	NSLog(@"Game Version: %d at %d",gameDBVersion, fileOffset);
	
	//Check version is compatiable with supported versions
	if (gameDBVersion != FM2011_11_1 && gameDBVersion != FM2011_11_2) { 
		NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:NSLocalizedString(@"Incompatible Database Version - %hu",@"error"),gameDBVersion] defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"The version of FM this game was saved under is not compatible with this editor",@"error message")];
		NSLog(@"Incompatible Database Version.");
		[alert runModal];
		
		[SupportFunctions showErrorWindow:@"Error Loading Game" withInfo:@"Your game could not be loaded"];
		[self setIdle:TRUE]; return;
	}
	
	//	0x06 unknown
	
	// Skip 6 bytes (as comment above)
	fileOffset += 6;
	
	// Read in current saved date
	currentDate = [FMDateLoader readFromData:fileData atOffset:&fileOffset];
	[infoStrings setObject:[[currentDate date] descriptionWithCalendarFormat:@"%d/%m/%Y" timeZone:nil locale:nil] forKey:@"currentGameDate"];
	NSLog(@"Current Date: %@",[currentDate date]);
	
	// 0x01 unknown
	
	// Skip a byte (as comment above)
	fileOffset += 1;
	
	// Read the game start date
	startDate = [FMDateLoader readFromData:fileData atOffset:&fileOffset];
	[infoStrings setObject:[[startDate date] descriptionWithCalendarFormat:@"%d/%m/%Y" timeZone:nil locale:nil] forKey:@"gameStartDate"];
	NSLog(@"Start Date: %@",[startDate date]);
	
	// 0x02 unknown
	
	// Skip two bytes (as comment above)
	fileOffset += 2;
	
	// Read unknown date
	FMDate *unknownDate4 = [FMDateLoader readFromData:fileData atOffset:&fileOffset];
	NSLog(@"Unknown Date 4: %@",[unknownDate4 date]);
	
	// 0x01 unknown
	// Skip a byte (as comment above)
	fileOffset += 1;
	
	// Read uknown date
	FMDate *unknownDate5 = [FMDateLoader readFromData:fileData atOffset:&fileOffset];
	NSLog(@"Unknown Date 5: %@",[unknownDate5 date]);
	
	[fileData getBytes:&databaseChanges range:NSMakeRange(fileOffset, 4)]; fileOffset += 4;
	
	if (isNewFormat) { fileOffset += 1526; }
	else {
	
		// 0x1537 unknown
	
		// Skip bytes (as comment above)
		fileOffset += 1537;
	
		if (gameDBVersion>FM2010_10_0_1) {
			fileOffset += 4;
		}
	}
	
	//////////////////////////////////
	// Tidy up
	[pool drain];
	
	pool = [[NSAutoreleasePool alloc] init];
	
	saveStartOffset = fileOffset;
	
	if (!compressed) { saveStartOffset += 18; }
	
	// read game DB
	id dbResult = [database readGameDB:fileData atOffset:&fileOffset];
	
	NSLog(@"%@",[dbResult objectAtIndex:2]);
	if ([[dbResult className] isEqualToString:@"NSArray"] ||
		[[dbResult className] isEqualToString:@"NSCFArray"]) {
		[SupportFunctions showErrorWindow:@"Error Loading Game" 
								 withInfo:[NSString stringWithFormat:@"Your game could not be loaded\n\nType: %@\nEntity: %d\nOffset: %d\nInfo: %@",
												[dbResult objectAtIndex:0],
												[[dbResult objectAtIndex:1] intValue],
												[[dbResult objectAtIndex:2] intValue],
												[dbResult objectAtIndex:3]
										   ]];
		[self setIdle:TRUE]; return;
	}
	
	if (!compressed) { [database setSaveEndOffset:([database saveEndOffset] + 18)]; }
	
	NSLog(@"game_db.dat: %d of %d [%d of %d] read",fileOffset,fileLength,byteOffset,gameLength);
	
	[fileData release];
	
	[self setIdle:TRUE];
	[self setDataLoaded:TRUE];
	
	[contentController setFavourites];
	[contentController reloadOutlineView];
	
	[pool drain];
	
	/////////////////////////////////
}

- (IBAction)saveGame:(id)sender
{
	BOOL canSave = YES;
	
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
	[database setStatus:NSLocalizedString(@"Preparing To Save...", @"editor status")];
	[self setIdle:FALSE];
	
	// Begin backup operation
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backupBeforeSave"]) {
		[database setStatus:NSLocalizedString(@"Backing up original...", @"editor status")];
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
	
	[database setStatus:NSLocalizedString(@"saving header...", @"editor status")];
	
	NSMutableData *saveData = [[NSMutableData alloc] init];
	
	[saveData appendData:[originalFile subdataWithRange:NSMakeRange(0,saveStartOffset)]];
	
	[database saveGameDB:saveData];
	
	[database setStatus:NSLocalizedString(@"saving excess...", @"editor status")];
	
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
	
	[database setStatus:NSLocalizedString(@"sorting offsets...", @"editor status")];
	
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
	
	[database setStatus:NSLocalizedString(@"saving offsets...", @"editor status")];
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
	
	parseGraphicsThread = [[NSThread alloc] initWithTarget:database selector:@selector(parseGraphics:) object:[[NSUserDefaults standardUserDefaults] stringForKey:@"graphicsLocation"]];
	gameDBThread = [[NSThread alloc] initWithTarget:self selector:@selector(loadGame:) object:filename];
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"parseGraphics"]==TRUE) { [parseGraphicsThread start]; }
	[gameDBThread start];
	
	return fileExists;
}

- (void)launchURL:(id)sender
{
	NSURL *URL;
	
	if ([sender tag]==0) { URL = [NSURL URLWithString:@"http://www.fmscout.com"]; }
	else if ([sender tag]==1) { URL = [NSURL URLWithString:@"http://www.sigames.com"]; }
	else if ([sender tag]==2) { URL = [NSURL URLWithString:@"http://code.google.com/p/fm10sx/wiki/UserManual"]; }
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


@end
