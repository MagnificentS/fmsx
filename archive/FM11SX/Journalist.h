//
//  Journalist.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/11/22.
//  Copyright 2009 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// character traits
#define JCT_UNKNOWN			0x01
#define JCT_EXPERIENCED		0x02
#define JCT_CUNNING			0x04
#define JCT_NICE			0x08
#define JCT_DISHONEST		0x10
#define JCT_ILL_TEMPERED	0x20
#define JCT_DULL			0x40

// writing styles
#define JWS_SENSATIONALIST	0
#define JWS_FACTUAL			1
#define JWS_BLAND			2
#define JWS_FLAMBOYANT		3

@interface Journalist : NSObject {
	unsigned char characterFlags;
	char curiosity, honesty, styleOfWriting;
	int currentEmployerID, favouriteClubID;
}

- (NSArray *)styleOfWritingStrings;

@property(assign,readwrite) unsigned char characterFlags;
@property(assign,readwrite) char curiosity, honesty, styleOfWriting;
@property(assign,readwrite) int currentEmployerID, favouriteClubID;

- (BOOL)characterExperienced;
- (void)setCharacterExperienced:(BOOL)val;
- (BOOL)characterCunning;
- (void)setCharacterCunning:(BOOL)val;
- (BOOL)characterNice;
- (void)setCharacterNice:(BOOL)val;
- (BOOL)characterDishonest;
- (void)setCharacterDishonest:(BOOL)val;
- (BOOL)characterIllTempered;
- (void)setCharacterIllTempered:(BOOL)val;
- (BOOL)characterDull;
- (void)setCharacterDull:(BOOL)val;

@end
