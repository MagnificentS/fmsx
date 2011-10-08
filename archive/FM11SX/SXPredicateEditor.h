//
//  SXPredicateEditor.h
//  FM11SX
//
//  Created by Amy Kettlewell on 10/11/23.
//  Copyright 2010 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SXPredicateEditor : NSPredicateEditor {

}

- (void)removeRowsAtIndexes:(NSIndexSet *)rowIndexes includeSubrows:(BOOL)includeSubrows;

@end
