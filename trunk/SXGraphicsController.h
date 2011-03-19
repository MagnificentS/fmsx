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
	NSMutableDictionary *competitionBGLogos, *smallCompetitionLogos, *competitionLogos, *hugeCompetitionLogos;
	NSMutableDictionary *smallNationLogos, *nationLogos, *hugeNationLogos, *nationFlags;
	NSMutableDictionary *continentBGLogos, *smallContinentLogos, *continentLogos, *hugeContinentLogos;
	NSMutableDictionary *personPhotos, *smallPersonPhotos;

	NSString *fileBase;
}

@property (copy,readwrite) NSMutableDictionary *homeKits, *awayKits, *thirdKits, *smallClubLogos,
*clubLogos, *hugeClubLogos, *smallCompetitionLogos, *competitionLogos, *hugeCompetitionLogos,
*smallNationLogos, *nationLogos, *hugeNationLogos, *nationFlags, *smallContinentLogos, 
*continentLogos, *hugeContinentLogos, *personPhotos, *smallPersonPhotos, *continentBGLogos,
*competitionBGLogos;

- (void)parseCustomGraphics;
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;

- (void)parseGraphics;

@end
