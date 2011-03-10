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

@end
