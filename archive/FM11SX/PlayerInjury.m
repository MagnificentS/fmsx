//
//  PlayerInjury.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/21.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "PlayerInjury.h"

@implementation PlayerInjury

@synthesize injuryID, fixture, daysUntilLightTraining, daysUntilFullTraining, beenToPhysio, receiveType,
unknownData1, injuredDate;

+ (NSString *)receiveTypeStringWithType:(int)val
{
	if (val==0) { return NSLocalizedString(@"Unknown",nil); }
	else if (val==1) { return NSLocalizedString(@"During match",@"injury receive type"); }
	else if (val==2) { return NSLocalizedString(@"In training",@"injury receive type"); }
	else if (val==3) { return NSLocalizedString(@"In pub",@"injury receive type"); }
	
	return [NSString stringWithFormat:@"Unknown: %d",val];
}


@end
