//
//  SupportFunctions.h
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface SupportFunctions : NSObject {

}

+ (NSString *)readCStringFromData:(NSData *)data atOffset:(unsigned int *)byteOffset length:(int)length;
+ (void)saveCString:(NSString *)str toData:(NSMutableData *)data;

+ (void)showErrorWindow:(NSString *)title withInfo:(NSString *)info;
+ (NSString *)reverseString:(NSString *)str;

+ (void)getFileInfosFromData:(NSData *)data atOffset:(unsigned int)offset intoInfos:(NSMutableDictionary *)fileInfos;

- (NSNumber *)number1;
- (NSNumber *)number2;
- (NSNumber *)number3;
- (NSNumber *)number4;
- (NSNumber *)number5;
- (NSNumber *)number6;
- (NSNumber *)number7;
- (NSNumber *)number8;
- (NSNumber *)number9;
- (NSNumber *)number10;
- (NSNumber *)number11;
- (NSNumber *)number12;
- (NSNumber *)number13;
- (NSNumber *)number14;
- (NSNumber *)number15;
- (NSNumber *)number16;
- (NSNumber *)number17;
- (NSNumber *)number18;
- (NSNumber *)number19;
- (NSNumber *)number20;
- (NSNumber *)number21;
- (NSNumber *)number22;
- (NSNumber *)number23;
- (NSNumber *)number24;
- (NSNumber *)number25;
- (NSNumber *)number26;
- (NSNumber *)number27;
- (NSNumber *)number28;
- (NSNumber *)number29;
- (NSNumber *)number30;
- (NSNumber *)number31;
- (NSNumber *)number32;
- (NSNumber *)number33;
- (NSNumber *)number34;
- (NSNumber *)number35;
- (NSNumber *)number36;
- (NSNumber *)number37;
- (NSNumber *)number38;
- (NSNumber *)number39;
- (NSNumber *)number40;
- (NSNumber *)number41;
- (NSNumber *)number42;
- (NSNumber *)number43;
- (NSNumber *)number44;
- (NSNumber *)number45;
- (NSNumber *)number46;
- (NSNumber *)number47;
- (NSNumber *)number48;
- (NSNumber *)number49;
- (NSNumber *)number50;
- (NSNumber *)number51;
- (NSNumber *)number52;
- (NSNumber *)number53;
- (NSNumber *)number54;
- (NSNumber *)number55;
- (NSNumber *)number56;
- (NSNumber *)number57;
- (NSNumber *)number58;
- (NSNumber *)number59;

@end
