//
//  NSString+SunExtension.h
//  光合联萌
//
//  Created by Sunallies on 16/6/30.
//
//

#import <Foundation/Foundation.h>

@interface NSString (SunExtension)

- (NSInteger)fileSize;

+ (NSString *)URLEncodedString:(NSString *)urlString;

+ (NSString *)stringOfSandiskDocumentDir;

+ (void)printAllFontName;

+ (NSString *)getStringOfTimeWithTime:(NSString *)time InputFormat:(NSString *)inputFormat OutPutFormat:(NSString *)outPutFormat;

+ (NSDate *)changeStringToDateWithDateFormat:(NSString *)dateFormat DateString:(NSString *)dateString;

+ (NSString *)stringWithName:(NSString *)name;

@end
