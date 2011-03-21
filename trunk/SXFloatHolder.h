//
//  SXFloatHolder.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/21.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXFloatHolder : NSObject {
	float floatValue;
}

@property(readwrite,assign) float floatValue;

+ (SXFloatHolder *)holderWithFloat:(float)val;

@end
