//
//  SXFSaveGameSummary.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXFSaveGameSummary : NSObject {
	int nManagers;
	
	NSMutableDictionary *infoStrings;
}

@property(assign,readwrite) int nManagers;
@property(copy,readwrite) NSMutableDictionary *infoStrings;

@end
