//
//  SXGraphicsController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/18.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXGraphicsController : NSObject {
	NSMutableDictionary *graphicsFMFInfos;
	
	NSMutableDictionary *homeKits, *awayKits, *thirdKits;
	NSMutableDictionary *smallClubLogos, *clubLogos, *hugeClubLogos;
	NSMutableDictionary *smallCompetitionLogos, *competitionLogos, *hugeCompetitionLogos;
	NSMutableDictionary *smallNationLogos, *nationLogos, *hugeNationLogos, *nationFlags;
	NSMutableDictionary *smallContinentLogos, *continentLogos, *hugeContinentLogos;
	NSMutableDictionary *personPhotos, *smallPersonPhotos;
}

- (void)parseGraphics;

@end
