//
//  SXEditorEntityViewController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/15.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EditorController.h"
#import "BWToolkitFramework/BWGradientBox.h"

@interface SXEditorEntityViewController : NSViewController {
	IBOutlet NSTableView	*awardsTable, *awardSectionsTable;
	IBOutlet NSBox			*awardBGBox;
	IBOutlet NSView			*awardMainViewContainer, *awardEntityView, *awardGeneralView, *awardRulesView, *awardSectionView;
	IBOutlet BWGradientBox	*awardHeaderBox;
	
	NSMutableArray			*awardSections;
}

- (IBAction)showCityPicker:(id)sender;
- (IBAction)showCompetitionPicker:(id)sender;
- (IBAction)showMediaPicker:(id)sender;
- (IBAction)showNationPicker:(id)sender;
- (IBAction)showPersonPicker:(id)sender;
- (IBAction)showStadiumPicker:(id)sender;

- (void)reloadEntityTable:(int)section;

@property(readwrite,assign) IBOutlet NSView	*awardMainViewContainer, *awardEntityView, *awardGeneralView, *awardRulesView, *awardSectionView;

@end
