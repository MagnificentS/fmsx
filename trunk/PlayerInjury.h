//
//  PlayerInjury.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ShortFixture.h"
#import "FMDate.h"

// receive types
#define IRT_UNKNOWN		0
#define IRT_MATCH		1
#define IRT_TRAINING	2
#define IRT_PUB			3

@interface PlayerInjury : NSObject {
	char receiveType;
	BOOL beenToPhysio;
	short daysUntilLightTraining, daysUntilFullTraining;
	int injuryID;
	NSData *unknownData1;
	FMDate *injuredDate;
	ShortFixture *fixture;
}

@property(assign,readwrite) char receiveType;
@property(assign,readwrite) BOOL beenToPhysio;
@property(assign,readwrite) short daysUntilLightTraining, daysUntilFullTraining;
@property(assign,readwrite) int injuryID;
@property(assign,readwrite) ShortFixture *fixture;
@property(assign,readwrite) FMDate *injuredDate;
@property(readwrite,copy) NSData *unknownData1;

+ (NSString *)receiveTypeStringWithType:(int)val;

@end
