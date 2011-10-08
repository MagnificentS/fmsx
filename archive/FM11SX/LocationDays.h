//
//  LocationDays.h
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/15.
//  Copyright 2010 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LocationDays : NSObject {
	short days;
	int locationUID;
	BOOL between15And21Only;
	
	// flags seen 0x01, 0x02, 0x04
	unsigned char unknownChar1;
}

@property(readwrite,assign) unsigned char unknownChar1;
@property(readwrite,assign) short days;
@property(readwrite,assign) int locationUID;
@property(readwrite,assign) BOOL between15And21Only;

@end
