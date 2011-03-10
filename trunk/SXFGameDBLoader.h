//
//  SXFGameDBLoader.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/09.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SXFGameDB.h"

@interface SXFGameDBLoader : NSObject {

}

+ (SXFGameDB *)readFileFromData:(NSData *)data withController:(Controller *)controller;

@end
