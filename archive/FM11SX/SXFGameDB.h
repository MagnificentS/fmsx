//
//  SXFGameDB.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Database.h"
#import "FMDate.h"

@interface SXFGameDB : NSObject {
	short version;
	int databaseChanges, saveStartOffset, saveEndOffset;
	
	Database *database;
	FMDate *currentDate, *startDate;
}

@property(assign,readwrite) short version;
@property(assign,readwrite) int databaseChanges, saveStartOffset, saveEndOffset;

@property(assign,readwrite) Database *database;
@property(assign,readwrite) FMDate *currentDate, *startDate;

@end
