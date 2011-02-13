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

+ (NSData *)loadSubFile:(NSString *)filename fromPath:(NSString *)path
{
	NSLog(@"in sfs for %@",filename);
	
	unsigned int byteOffset = 0;
	unsigned int fmf1Length, fmf2Offset;
	BOOL compressed;
	NSData *foundData;
	
	NSData *fileData = [[NSData alloc] initWithContentsOfFile:path];
	
	if ([fileData length]==0) {
		NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"Invalid File", @"error - invalid file") defaultButton:@"OK" alternateButton:nil 
										   otherButton:nil informativeTextWithFormat:NSLocalizedString(@"This does not appear to be a valid FM savegame",@"error - not an FM game")];
		[alert runModal];
	}
	
	byteOffset += 9;
	[fileData getBytes:&fmf1Length range:NSMakeRange(byteOffset, 4)]; byteOffset += 4;
	byteOffset += 4;
	[fileData getBytes:&compressed range:NSMakeRange(byteOffset, 1)]; byteOffset += 1;
	fmf2Offset = fmf1Length + 18;
	
	NSData *filenameData = [[NSData alloc] initWithData:[[fileData subdataWithRange:NSMakeRange(fmf2Offset, ([fileData length] - fmf2Offset))] zlibInflate]];

	fmf2Offset = 4;
	
	NSString *extension, *thisFilename;
	unsigned int startOffset, compressedFileLength, fileLength;
	short fileCount, dirCount;
	
	[filenameData getBytes:&fileCount range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	
	for (int i=0; i<fileCount; i++) {
		
		thisFilename = [FMString readFromData:filenameData atOffset:&fmf2Offset];
		extension = [FMString readFromData:filenameData atOffset:&fmf2Offset];
		[filenameData getBytes:&startOffset range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		[filenameData getBytes:&compressedFileLength range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		[filenameData getBytes:&fileLength range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
		
		if ([[NSString stringWithFormat:@"%@%@",thisFilename,extension] isEqualToString:filename]) {
			if (compressed) {
				foundData = [[fileData subdataWithRange:NSMakeRange((startOffset +18),compressedFileLength)] zlibInflate];
			}
			else {
		
				foundData = [fileData subdataWithRange:NSMakeRange((startOffset +18),fileLength)];
			}
		}
	}
	[filenameData getBytes:&dirCount range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
	
	for (int j=0; j<dirCount; j++) {
		[FMString readFromData:filenameData atOffset:&fmf2Offset];
		
		[filenameData getBytes:&fileCount range:NSMakeRange(fmf2Offset, 2)]; fmf2Offset += 2;
		
		for (int i=0; i<fileCount; i++) {
			
			filename = [FMString readFromData:filenameData atOffset:&fmf2Offset];
			extension = [FMString readFromData:filenameData atOffset:&fmf2Offset];
			[filenameData getBytes:&startOffset range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
			[filenameData getBytes:&compressedFileLength range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
			[filenameData getBytes:&fileLength range:NSMakeRange(fmf2Offset, 4)]; fmf2Offset += 4;
			
			
			if ([[NSString stringWithFormat:@"%@%@",filename,extension] isEqualToString:filename]) {
				if (compressed) {
					foundData = [[fileData subdataWithRange:NSMakeRange((startOffset +18),compressedFileLength)] zlibInflate];
				}
				else {
					foundData = [fileData subdataWithRange:NSMakeRange((startOffset +18),fileLength)];
				}
			}
		}
	}
	
	NSLog(@"fd: %d",[foundData length]);
	return foundData;
}

@end
