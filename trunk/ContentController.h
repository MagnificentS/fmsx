//
//  ContentController.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/28.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>
#import "SXEditorViewController.h"

@interface ContentController : NSObject {
	IBOutlet NSBox *mainViewContainer;
	IBOutlet NSView *editorView, *IDLookupView;
	IBOutlet NSView *placeholderView;
	
	NSMutableDictionary *selectedRows;
	
	// Pickers
	IBOutlet BWSheetController *nationPicker;
	id nationPickerObject;
	NSString *nationPickerSelector;
	
	IBOutlet BWSheetController *competitionPicker;
	id competitionPickerObject;
	NSString *competitionPickerSelector;
	
	IBOutlet BWSheetController *cityPicker;
	id cityPickerObject;
	NSString *cityPickerSelector;
	
	IBOutlet BWSheetController *stadiumPicker;
	id stadiumPickerObject;
	NSString *stadiumPickerSelector;
	
	IBOutlet BWSheetController *personPicker;
	id personPickerObject;
	NSString *personPickerSelector;
	
	IBOutlet BWSheetController *mediaPicker;
	id mediaPickerObject;
	NSString *mediaPickerSelector;
	
	NSString *locationString;
	
	IBOutlet NSWindow *mainWindow;
	SXEditorViewController *editorViewController;
}

- (IBAction)showNationPicker:(id)sender;
- (IBAction)setNationPickerObject:(id)object;
- (IBAction)pickNation:(id)sender;
- (IBAction)showCompetitionPicker:(id)sender;
- (IBAction)setCompetitionPickerObject:(id)object;
- (IBAction)pickCompetition:(id)sender;
- (IBAction)showStadiumPicker:(id)sender;
- (IBAction)setStadiumPickerObject:(id)object;
- (IBAction)pickStadium:(id)sender;
- (IBAction)showCityPicker:(id)sender;
- (IBAction)setCityPickerObject:(id)object;
- (IBAction)pickCity:(id)sender;
- (IBAction)showPersonPicker:(id)sender;
- (IBAction)setPersonPickerObject:(id)object;
- (IBAction)pickPerson:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)setMediaPickerObject:(id)object;
- (IBAction)pickMedia:(id)sender;

- (void)replacePlaceholder:(NSView *)placeholder withView:(NSView *)view;

@property(readonly,assign) NSView *placeholderView;

@property(readwrite,assign) NSWindow *mainWindow;
@property(readonly,assign) SXEditorViewController *editorViewController;

@property(readwrite,copy) NSString *locationString;
@property(readwrite,copy) NSMutableDictionary *selectedRows;

- (IBAction)selectEditorView:(id)sender;
- (IBAction)selectScoutView:(id)sender;
- (IBAction)selectIDLookupView:(id)sender;

@end
