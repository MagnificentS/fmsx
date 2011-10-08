//
//  PlayerReplacementLoader.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/17.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PlayerReplacement.h"

@interface PlayerReplacementLoader : NSObject {

}

+ (PlayerReplacement *)readFromData:(NSData *)data atOffset:(unsigned int *)byteOffset;

@end
