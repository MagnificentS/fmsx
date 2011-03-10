//
//  SXFSaveGameSummaryLoader.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXFSaveGameSummary.h"

@interface SXFSaveGameSummaryLoader : NSObject {

}

+ (SXFSaveGameSummary *)readFileFromData:(NSData *)data;

@end
