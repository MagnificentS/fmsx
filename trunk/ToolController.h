//
//  ToolController.h
//  FM11SX
//
//  Created by Amy Kettlewell on 11/03/12.
//  Copyright 2011 littleblue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Controller.h"

@interface ToolController : NSObject {
	IBOutlet NSTextField *goodAlliterationRowIDField;
	IBOutlet NSTextField *badAlliterationRowIDField;
	IBOutlet NSTextField *agreementRowIDField;
	IBOutlet NSTextField *agreementUIDField;
	IBOutlet NSTextField *awardRowIDField;
	IBOutlet NSTextField *awardUIDField;
	IBOutlet NSTextField *cityRowIDField;
	IBOutlet NSTextField *cityUIDField;
	IBOutlet NSTextField *clubRowIDField;
	IBOutlet NSTextField *clubUIDField;
	IBOutlet NSTextField *competitionRowIDField;
	IBOutlet NSTextField *competitionUIDField;
	IBOutlet NSTextField *continentRowIDField;
	IBOutlet NSTextField *continentUIDField;
	IBOutlet NSTextField *currencyRowIDField;
	IBOutlet NSTextField *derbyRowIDField;
	IBOutlet NSTextField *derbyUIDField;
	IBOutlet NSTextField *descriptionRowIDField;
	IBOutlet NSTextField *descriptionUIDField;
	IBOutlet NSTextField *injuryRowIDField;
	IBOutlet NSTextField *injuryUIDField;
	IBOutlet NSTextField *languageRowIDField;
	IBOutlet NSTextField *localAreaRowIDField;
	IBOutlet NSTextField *localAreaUIDField;
	IBOutlet NSTextField *mediaRowIDField;
	IBOutlet NSTextField *firstNameRowIDField;
	IBOutlet NSTextField *surnameRowIDField;
	IBOutlet NSTextField *commonNameRowIDField;
	IBOutlet NSTextField *nationRowIDField;
	IBOutlet NSTextField *personRowIDField;
	IBOutlet NSTextField *sponsorRowIDField;
	IBOutlet NSTextField *stadiumRowIDField;
	IBOutlet NSTextField *stadiumUIDField;
	IBOutlet NSTextField *stadiumChangeRowIDField;
	IBOutlet NSTextField *stageNameRowIDField;
	IBOutlet NSTextField *stageNameUIDField;
	IBOutlet NSTextField *teamRowIDField;
	IBOutlet NSTextField *weatherRowIDField;
	
	IBOutlet NSSearchField *IDSearchField;
	
	IBOutlet Controller *controller;
}

- (IBAction)IDLookup:(id)sender;

@end
