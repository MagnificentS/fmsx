//
//  Journalist.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 littleblue. All rights reserved.
//

#import "Journalist.h"

@implementation Journalist

@synthesize currentEmployerID, characterFlags, favouriteClubID, curiosity, honesty, styleOfWriting;

- (NSArray *)styleOfWritingStrings
{
	NSArray *strings = [NSArray arrayWithObjects:
						NSLocalizedString(@"Sensationalist",@"journalist style of writing"),
						NSLocalizedString(@"Factual",@"journalist style of writing"),
						NSLocalizedString(@"Bland",@"journalist style of writing"),
						NSLocalizedString(@"Flamboyant",@"journalist style of writing"),
						nil];
	return strings;
}

- (BOOL)characterExperienced { 
	if (characterFlags & JCT_EXPERIENCED) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterExperienced:(BOOL)val {
	if (characterFlags & JCT_EXPERIENCED) {
		if (!val) { characterFlags = (characterFlags ^ JCT_EXPERIENCED); }
	}
	else { characterFlags = (characterFlags | JCT_EXPERIENCED); }
}

- (BOOL)characterCunning { 
	if (characterFlags & JCT_CUNNING) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterCunning:(BOOL)val {
	if (characterFlags & JCT_CUNNING) {
		if (!val) { characterFlags = (characterFlags ^ JCT_CUNNING); }
	}
	else { characterFlags = (characterFlags | JCT_CUNNING); }
}

- (BOOL)characterNice { 
	if (characterFlags & JCT_NICE) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterNice:(BOOL)val {
	if (characterFlags & JCT_NICE) {
		if (!val) { characterFlags = (characterFlags ^ JCT_NICE); }
	}
	else { characterFlags = (characterFlags | JCT_NICE); }
}

- (BOOL)characterDishonest { 
	if (characterFlags & JCT_DISHONEST) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterDishonest:(BOOL)val {
	if (characterFlags & JCT_DISHONEST) {
		if (!val) { characterFlags = (characterFlags ^ JCT_DISHONEST); }
	}
	else { characterFlags = (characterFlags | JCT_DISHONEST); }
}

- (BOOL)characterIllTempered { 
	if (characterFlags & JCT_ILL_TEMPERED) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterIllTempered:(BOOL)val {
	if (characterFlags & JCT_ILL_TEMPERED) {
		if (!val) { characterFlags = (characterFlags ^ JCT_ILL_TEMPERED); }
	}
	else { characterFlags = (characterFlags | JCT_ILL_TEMPERED); }
}

- (BOOL)characterDull { 
	if (characterFlags & JCT_DULL) { return TRUE; } 
	return FALSE; 
}
- (void)setCharacterDull:(BOOL)val {
	if (characterFlags & JCT_DULL) {
		if (!val) { characterFlags = (characterFlags ^ JCT_DULL); }
	}
	else { characterFlags = (characterFlags | JCT_DULL); }
}

@end
