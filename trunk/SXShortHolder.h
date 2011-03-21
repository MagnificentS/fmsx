//
//  SXShortHolder.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/21.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXShortHolder : NSObject {
	short shortValue;
}

@property(readwrite,assign) short shortValue;

+ (SXShortHolder *)holderWithShort:(short)val;

@end
