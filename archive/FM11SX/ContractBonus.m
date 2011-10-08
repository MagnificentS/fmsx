//
//  ContractBonus.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/15.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "ContractBonus.h"

@implementation ContractBonus

@synthesize type, fee;

- (NSArray *)typeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Appearance Fee",@"contract bonus type"),
						NSLocalizedString(@"Goal Bonus",@"contract bonus type"),
						NSLocalizedString(@"Clean Sheet Bonus",@"contract bonus type"),
						NSLocalizedString(@"Team Of The Year Bonus (Division)",@"contract bonus type"),
						nil];
	return strings;
}

- (NSString *)typeString
{
	if (type==CBT_APPEARANCE_FEE) { return NSLocalizedString(@"Appearance Fee",@"contract bonus type"); }
	else if (type==CBT_GOAL_BONUS) { return NSLocalizedString(@"Goal Bonus",@"contract bonus type"); }
	else if (type==CBT_CLEAN_SHEET_BONUS) { return NSLocalizedString(@"Clean Sheet Bonus",@"contract bonus type"); }
	else if (type==CBT_TEAM_OF_THE_YEAR_BONUS_DIVISION) { return NSLocalizedString(@"Team Of The Year Bonus (Division)",@"contract bonus type"); }
	
	return [NSString stringWithFormat:@"Unknown - %d",type];
}

@end
