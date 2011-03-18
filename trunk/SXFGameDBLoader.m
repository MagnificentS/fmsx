//
//  SXFGameDBLoader.m
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import "SXFGameDBLoader.h"
#import "FMDateLoader.h"
#import "GameVersions.h"
#import "Database.h"
#import "SupportFunctions.h"

@implementation SXFGameDBLoader

+ (void)readFileFromData:(NSData *)data intoObject:(SXFGameDB *)object
{
	unsigned int offset = 0;
	short sbuffer;
	int ibuffer;
	
	//	0x02 unknown
	//	0x04 file type (CString)
	offset += 6;
	
	[data getBytes:&sbuffer range:NSMakeRange(offset,2)];	offset += 2;
	[object setVersion:sbuffer];
	
	// Check version is compatiable with supported versions
	if ([object version]!= FM2011_11_1 && [object version] != FM2011_11_2) { 
		NSAlert *alert = [NSAlert alertWithMessageText:[NSString stringWithFormat:NSLocalizedString(@"Incompatible Database Version - %hu",@"error"),[object version]] defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"The version of FM this game was saved under is not compatible with this editor",@"error message")];
		NSLog(@"Incompatible Database Version.");
		[alert runModal];
		
		return;
	}
	
	//	0x06 unknown
	offset += 6;
	
	[object setCurrentDate:[FMDateLoader readFromData:data atOffset:&offset]];
	
	// 0x01 unknown
	offset += 1;
	
	[object setStartDate:[FMDateLoader readFromData:data atOffset:&offset]];
	
	// 0x02 unknown
	offset += 2;
	
	[FMDateLoader readFromData:data atOffset:&offset];
	
	// 0x01 unknown
	offset += 1;
	
	[FMDateLoader readFromData:data atOffset:&offset];
	
	[data getBytes:&ibuffer range:NSMakeRange(offset,4)];	offset += 4;
	[object setDatabaseChanges:ibuffer];
	
	offset += 1526;
	
	[object setSaveStartOffset:offset];
	
	id dbResult = [[object database] readGameDB:data atOffset:&offset];
	
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
		return;
	}
	
	NSLog(@"game_db.dat: %d of %d read",offset,[data length]);
}

@end
