//
//  SXScoutViewController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/14.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>

@interface SXScoutViewController : NSViewController {
	IBOutlet BWSheetController *playerFilters, *staffFilters, *clubColumns, *playerColumns,
	*staffColumns;
	
}

@end
