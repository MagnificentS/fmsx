//
//  Continent.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/31.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Continent.h"
#import "Controller.h"
#import "SXGraphicsController.h"

@implementation Continent

@synthesize databaseClass, nameGender, federationNameGender, shortFederationNameGender,
regionalStrength, continentSelected, rowID, UID, name, threeLetterName, continentialityName, 
federationName, federationShortName, infos, hasInfos, unknownChar1;

- (id)init
{
	[super init];
	
	name = @"---";
	threeLetterName = @"---";
	continentialityName = @"---";
	federationName = @"---";
	federationShortName = @"---";
	
	return self;
}

- (NSString *)logoPath
{
	return [[[[NSApp delegate] graphics] continentLogos] objectForKey:[NSNumber numberWithInt:UID]];
}

- (NSString *)bgLogoPath
{
	return [[[[NSApp delegate] graphics] continentBGLogos] objectForKey:[NSNumber numberWithInt:UID]];
}

@end
