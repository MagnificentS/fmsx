//
//  StaffTendency.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/26.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "StaffTendency.h"

@implementation StaffTendency

@synthesize type, level;

+ (NSString *)typeStringWithType:(int)val
{
	if (val==1) { return NSLocalizedString(@"Signs domestic-based players",@"staff tendency type"); }
	else if (val==2) { return NSLocalizedString(@"Spends alot on youth signings",@"staff tendency type"); }
	else if (val==3) { return NSLocalizedString(@"Signs alot of youth players",@"staff tendency type"); }
	else if (val==4) { return NSLocalizedString(@"Signs young players for first team",@"staff tendency type"); }
	else if (val==5) { return NSLocalizedString(@"Uses budget on one player",@"staff tendency type"); }
	else if (val==6) { return NSLocalizedString(@"Has a large senior squad",@"staff tendency type"); }
	else if (val==15) { return NSLocalizedString(@"Will use young players in low-priority cup matches",@"staff tendency type"); }
	else if (val==16) { return NSLocalizedString(@"Will not have substitute goalkeeper",@"staff tendency type"); }
	else if (val==17) { return NSLocalizedString(@"Will make early tactical changes",@"staff tendency type"); }
	else if (val==18) { return NSLocalizedString(@"Will use zonal marking for set pieces",@"staff tendency type"); }
	else if (val==19) { return NSLocalizedString(@"Will fit players into preferred tactic",@"staff tendency type"); }
	else if (val==20) { return NSLocalizedString(@"Will use target man",@"staff tendency type"); }
	else if (val==21) { return NSLocalizedString(@"Will use counter-attacking",@"staff tendency type"); }
	
	return [NSString stringWithFormat:@"Unknown: %d",val];
}

@end
