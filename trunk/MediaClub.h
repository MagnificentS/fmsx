//
//  MediaClub.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MediaClub : NSObject {
	int clubID;
	int SXClubRowID;
	NSString *URL;
}

- (void)setClubRowID:(int)val;
- (int)clubRowID;

@property(assign,readwrite) int clubID, SXClubRowID;
@property(assign,readwrite) NSString *URL;

@end
