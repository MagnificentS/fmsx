//
//  SXFGameInfo.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXFGameInfo : NSObject {
	NSString *directory;
	int startBuildVersion, currentBuildVersion, timesSaved, gameID;
}

@property(assign,readwrite) int startBuildVersion, currentBuildVersion, timesSaved, gameID;
@property(copy,readwrite) NSString *directory;

@end
