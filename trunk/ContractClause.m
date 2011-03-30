//
//  ContractClause.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/20.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ContractClause.h"


@implementation ContractClause

@synthesize fee, type, info;

- (NSArray *)typeStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Minimum Fee Release",@"contract clause"),
						NSLocalizedString(@"Relegation Release",@"contract clause"),
						NSLocalizedString(@"Non-Promotion Release",@"contract clause"),
						NSLocalizedString(@"Yearly Wage Rise (%)",@"contract clause"),
						NSLocalizedString(@"Promotion Wage Increase (%)",@"contract clause"),
						NSLocalizedString(@"Relegation Wage Decrease (%)",@"contract clause"),
						NSLocalizedString(@"Manager/Coach Job Release",@"contract clause"),
						NSLocalizedString(@"Unknown Type - 7",@"contract clause"),
						NSLocalizedString(@"Sell On Fee (%)",@"contract clause"),
						NSLocalizedString(@"Sell On Fee Profit (%)",@"contract clause"),
						NSLocalizedString(@"Seasonal Landmark Goal Bonus",@"contract clause"),
						NSLocalizedString(@"One Year Extension After League Games (Final Season)",@"contract clause"),
						NSLocalizedString(@"Match Highest Earner",@"contract clause"),
						NSLocalizedString(@"Wage After Reaching Club Career League Games",@"contract clause"),
						NSLocalizedString(@"Top Division Promotion Wage Rise (%)",@"contract clause"),
						NSLocalizedString(@"Top Division Relegation Wage Drop (%)",@"contract clause"),
						NSLocalizedString(@"Minimum Fee Release (Foreign Clubs)",@"contract clause"),
						NSLocalizedString(@"Minimum Fee Release (Higher Division Clubs)",@"contract clause"),
						nil];
	return strings;
}

- (NSString *)typeString
{
	if (type==CCT_MIN_FEE_RELEASE) { return NSLocalizedString(@"Minimum Fee Release",@"contract clause"); }
	else if (type==CCT_RELEGATION_RELEASE) { return NSLocalizedString(@"Relegation Release",@"contract clause"); }
	else if (type==CCT_NON_PROMOTION_RELEASE) { return NSLocalizedString(@"Non-Promotion Release",@"contract clause"); }
	else if (type==CCT_YEARLY_WAGE_RISE_PERCENTAGE) { return NSLocalizedString(@"Yearly Wage Rise (%)",@"contract clause"); }
	else if (type==CCT_PROMOTION_WAGE_INCREASE) { return NSLocalizedString(@"Promotion Wage Increase (%)",@"contract clause"); }
	else if (type==CCT_RELEGATION_WAGE_DECREASE) { return NSLocalizedString(@"Relegation Wage Decrease (%)",@"contract clause"); }
	else if (type==CCT_MANAGER_COACH_JOB_RELEASE) { return NSLocalizedString(@"Manager/Coach Job Release",@"contract clause"); }
	else if (type==CCT_SELL_ON_FEE_PERCENTAGE) { return NSLocalizedString(@"Sell On Fee (%)",@"contract clause"); }
	else if (type==CCT_SELL_ON_FEE_PROFIT_PERCENTAGE) { return NSLocalizedString(@"Sell On Fee Profit (%)",@"contract clause"); }
	else if (type==CCT_SEASONAL_LANDMARK_GOAL_BONUS) { return NSLocalizedString(@"Seasonal Landmark Goal Bonus",@"contract clause"); }
	else if (type==CCT_ONE_YEAR_EXTENSION_AFTER_LEAGUE_GAMES_FINAL_SEASON) { return NSLocalizedString(@"One Year Extension After League Games (Final Season)",@"contract clause"); }
	else if (type==CCT_MATCH_HIGHEST_EARNER) { return NSLocalizedString(@"Match Highest Earner",@"contract clause"); }
	else if (type==CCT_WAGE_AFTER_REACHING_CLUB_CAREER_LEAGUE_GAMES) { return NSLocalizedString(@"Wage After Reaching Club Career League Games",@"contract clause"); }
	else if (type==CCT_TOP_DIVISION_PROMOTION_WAGE_RISE) { return NSLocalizedString(@"Top Division Promotion Wage Rise (%)",@"contract clause"); }
	else if (type==CCT_TOP_DIVISION_RELEGATION_WAGE_DROP) { return NSLocalizedString(@"Top Division Relegation Wage Drop (%)",@"contract clause"); }
	else if (type==CCT_MIN_FEE_RELEASE_FOREIGN_CLUBS) { return NSLocalizedString(@"Minimum Fee Release (Foreign Clubs)",@"contract clause"); }
	else if (type==CCT_MIN_FEE_RELEASE_HIGHER_DIVISION_CLUBS) { return NSLocalizedString(@"Minimum Fee Release (Higher Division Clubs)",@"contract clause"); }
		
	return [NSString stringWithFormat:@"Unknown - %d",type];
}

@end
