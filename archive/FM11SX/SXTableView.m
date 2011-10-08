//
//  SXTableView.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/23.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "SXTableView.h"

@implementation SXTableView

- (void)keyDown:(NSEvent *)event {
	NSString *chars = [event charactersIgnoringModifiers];
    
    if ([event type] == NSKeyDown && [chars length] == 1) {
        
        int val = [chars characterAtIndex:0];
        
		// if it's a space
        if (val == 32) {
            if ([[self delegate] respondsToSelector:@selector(performSpaceKeyPress:)]) {
                [[self delegate] performSelector:@selector(performSpaceKeyPress:) withObject:self];
            }
        }
    }
    
	// Pass on the key event
	[super keyDown:event];
	
 //   return [super performKeyEquivalent:event];
}

@end
