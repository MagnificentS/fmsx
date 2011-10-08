//
//  SXPredicateEditor.m
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/23.
//  Copyright 2010 littleblue. All rights reserved.
//

#import "SXPredicateEditor.h"


@implementation SXPredicateEditor

- (void)removeRowsAtIndexes:(NSIndexSet *)rowIndexes includeSubrows:(BOOL)includeSubrows
{
	[super removeRowsAtIndexes:rowIndexes includeSubrows:includeSubrows];
	
	if ([self numberOfRows]==0) { 
		[self addRow:self]; 
		[self removeRowAtIndex:1];
	}
}

@end
