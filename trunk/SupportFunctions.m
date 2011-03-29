//
//  SupportFunctions.m
//  FM10SX
//
//  Created by Amy Kettlewell on 09/10/23.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FMString.h"
#import "SupportFunctions.h"
#import "SXzlib.h"

@implementation SupportFunctions

+ (NSString *)readCStringFromData:(NSData *)data atOffset:(unsigned int *)byteOffset length:(int)length
{
	unsigned char bytes[length];
	[data getBytes:bytes range:NSMakeRange(*byteOffset, length)];
	
	NSString *str = [[NSString alloc] initWithBytes:bytes length:length encoding:NSUTF8StringEncoding];
	
	*byteOffset += length;
	return str;
}

+ (void)saveCString:(NSString *)str toData:(NSMutableData *)data
{
	if (![str isEqualToString:@"---"]) 
	{
		[data appendData:[str dataUsingEncoding:NSASCIIStringEncoding]];
	}
}

+ (void)showErrorWindow:(NSString *)title withInfo:(NSString *)info
{
	NSAlert *alert = [[NSAlert alloc] init];
	
	[alert setMessageText:title];
	[alert setInformativeText:info];
	[alert runModal];
	
	[alert release];
}

+ (NSString *)reverseString:(NSString *)str
{
	NSMutableString *reversedStr;
	int len = [str length];
	
	// Auto released string
	reversedStr = [NSMutableString stringWithCapacity:len];     
	
	// Probably woefully inefficient...
	while (len > 0)
		[reversedStr appendString:
         [NSString stringWithFormat:@"%C", [str characterAtIndex:--len]]];   
	
	return reversedStr;
}

+ (void)parseFMFDirectory:(NSData *)decompressedData atOffset:(unsigned int *)offset withData:(NSData *)data intoInfos:(NSMutableDictionary *)fileInfos
{
	unsigned int fmf2Offset = *offset;
	int ibuffer;
	short filecount, dircount;
	
	// parse root files
	[decompressedData getBytes:&filecount range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	for (int i=0; i<filecount; i++) {
		NSMutableDictionary *fileInfo = [[NSMutableDictionary alloc] init];
		
		NSString *filename = [FMString readFromData:decompressedData atOffset:&fmf2Offset];
		NSString *extension = [FMString readFromData:decompressedData atOffset:&fmf2Offset];
		[decompressedData getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		[fileInfo setObject:[NSNumber numberWithUnsignedInt:ibuffer] forKey:@"startOffset"];
		[decompressedData getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		[fileInfo setObject:[NSNumber numberWithUnsignedInt:ibuffer] forKey:@"compressedFileLength"];
		[decompressedData getBytes:&ibuffer range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		[fileInfo setObject:[NSNumber numberWithUnsignedInt:ibuffer] forKey:@"fileLength"];
		
		[fileInfos setObject:fileInfo forKey:[NSString stringWithFormat:@"%@%@",filename,extension]];
		[fileInfo release];
	}
	// parse sub-directories
	[decompressedData getBytes:&dircount range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	
	for (int j=0; j<dircount; j++) {
		[FMString readFromData:decompressedData atOffset:&fmf2Offset];
		
		[self parseFMFDirectory:decompressedData atOffset:&fmf2Offset withData:data intoInfos:fileInfos];
	}
}

+ (void)getFileInfosFromData:(NSData *)data atOffset:(unsigned int)offset intoInfos:(NSMutableDictionary *)fileInfos
{
	unsigned int fmf2Offset = 4;
	
	NSData *decompressedData = [[data subdataWithRange:NSMakeRange(offset, ([data length] - offset))] zlibInflate];
	
	[self parseFMFDirectory:decompressedData atOffset:&fmf2Offset withData:data intoInfos:fileInfos];
}

- (NSNumber *)number1 { return [NSNumber numberWithInt:1]; }
- (NSNumber *)number2 { return [NSNumber numberWithInt:2]; }
- (NSNumber *)number3 { return [NSNumber numberWithInt:3]; }
- (NSNumber *)number4 { return [NSNumber numberWithInt:4]; }
- (NSNumber *)number5 { return [NSNumber numberWithInt:5]; }
- (NSNumber *)number6 { return [NSNumber numberWithInt:6]; }
- (NSNumber *)number7 { return [NSNumber numberWithInt:7]; }
- (NSNumber *)number8 { return [NSNumber numberWithInt:8]; }
- (NSNumber *)number9 { return [NSNumber numberWithInt:9]; }
- (NSNumber *)number10 { return [NSNumber numberWithInt:10]; }
- (NSNumber *)number11 { return [NSNumber numberWithInt:11]; }
- (NSNumber *)number12 { return [NSNumber numberWithInt:12]; }
- (NSNumber *)number13 { return [NSNumber numberWithInt:13]; }
- (NSNumber *)number14 { return [NSNumber numberWithInt:14]; }
- (NSNumber *)number15 { return [NSNumber numberWithInt:15]; }
- (NSNumber *)number16 { return [NSNumber numberWithInt:16]; }
- (NSNumber *)number17 { return [NSNumber numberWithInt:17]; }
- (NSNumber *)number18 { return [NSNumber numberWithInt:18]; }
- (NSNumber *)number19 { return [NSNumber numberWithInt:19]; }
- (NSNumber *)number20 { return [NSNumber numberWithInt:20]; }
- (NSNumber *)number21 { return [NSNumber numberWithInt:21]; }
- (NSNumber *)number22 { return [NSNumber numberWithInt:22]; }
- (NSNumber *)number23 { return [NSNumber numberWithInt:23]; }
- (NSNumber *)number24 { return [NSNumber numberWithInt:24]; }
- (NSNumber *)number25 { return [NSNumber numberWithInt:25]; }
- (NSNumber *)number26 { return [NSNumber numberWithInt:26]; }
- (NSNumber *)number27 { return [NSNumber numberWithInt:27]; }
- (NSNumber *)number28 { return [NSNumber numberWithInt:28]; }
- (NSNumber *)number29 { return [NSNumber numberWithInt:29]; }
- (NSNumber *)number30 { return [NSNumber numberWithInt:30]; }
- (NSNumber *)number31 { return [NSNumber numberWithInt:31]; }
- (NSNumber *)number32 { return [NSNumber numberWithInt:32]; }
- (NSNumber *)number33 { return [NSNumber numberWithInt:33]; }
- (NSNumber *)number34 { return [NSNumber numberWithInt:34]; }
- (NSNumber *)number35 { return [NSNumber numberWithInt:35]; }
- (NSNumber *)number36 { return [NSNumber numberWithInt:36]; }
- (NSNumber *)number37 { return [NSNumber numberWithInt:37]; }
- (NSNumber *)number38 { return [NSNumber numberWithInt:38]; }
- (NSNumber *)number39 { return [NSNumber numberWithInt:39]; }
- (NSNumber *)number40 { return [NSNumber numberWithInt:40]; }
- (NSNumber *)number41 { return [NSNumber numberWithInt:41]; }
- (NSNumber *)number42 { return [NSNumber numberWithInt:42]; }
- (NSNumber *)number43 { return [NSNumber numberWithInt:43]; }
- (NSNumber *)number44 { return [NSNumber numberWithInt:44]; }
- (NSNumber *)number45 { return [NSNumber numberWithInt:45]; }
- (NSNumber *)number46 { return [NSNumber numberWithInt:46]; }
- (NSNumber *)number47 { return [NSNumber numberWithInt:47]; }
- (NSNumber *)number48 { return [NSNumber numberWithInt:48]; }
- (NSNumber *)number49 { return [NSNumber numberWithInt:49]; }
- (NSNumber *)number50 { return [NSNumber numberWithInt:50]; }
- (NSNumber *)number51 { return [NSNumber numberWithInt:51]; }
- (NSNumber *)number52 { return [NSNumber numberWithInt:52]; }
- (NSNumber *)number53 { return [NSNumber numberWithInt:53]; }
- (NSNumber *)number54 { return [NSNumber numberWithInt:54]; }
- (NSNumber *)number55 { return [NSNumber numberWithInt:55]; }
- (NSNumber *)number56 { return [NSNumber numberWithInt:56]; }
- (NSNumber *)number57 { return [NSNumber numberWithInt:57]; }
- (NSNumber *)number58 { return [NSNumber numberWithInt:58]; }
- (NSNumber *)number59 { return [NSNumber numberWithInt:59]; }

@end
