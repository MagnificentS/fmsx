//
//  CompetitionLoader.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/30.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Loader.h"

@interface Loader (CompetitionLoader)

+ (id)readCompetitionFromData:(NSData *)data atOffset:(unsigned int *)byteOffset version:(short)version;

@end
