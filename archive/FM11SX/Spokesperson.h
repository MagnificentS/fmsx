//
//  Spokesperson.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Spokesperson : NSObject {
	int associatedClubID;
}

@property(assign,readwrite) int associatedClubID;

@end
