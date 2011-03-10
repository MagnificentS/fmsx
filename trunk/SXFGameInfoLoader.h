//
//  SXFGameInfoLoader.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXFGameInfo.h"

@interface SXFGameInfoLoader : NSObject {

}

+ (SXFGameInfo *)readFileFromData:(NSData *)data;

@end
