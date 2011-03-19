//
//  SXEditorViewController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/17.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>

@interface SXEditorViewController : NSViewController {
	IBOutlet NSView *editorPlaceholderView;
	IBOutlet BWSheetController *cityPicker;
	IBOutlet BWSheetController *clubPicker;
	IBOutlet BWSheetController *competitionPicker;
	IBOutlet BWSheetController *mediaPicker;
	IBOutlet BWSheetController *nationPicker;
	IBOutlet BWSheetController *peoplePicker;
	IBOutlet BWSheetController *stadiumPicker;
	
}

- (void)selectSection:(id)sender;

@property(readwrite,assign) NSView *editorPlaceholderView;
@property(readwrite,assign) BWSheetController *cityPicker, *clubPicker, *competitionPicker, *mediaPicker, 
*nationPicker, *peoplePicker, *stadiumPicker;

@end
