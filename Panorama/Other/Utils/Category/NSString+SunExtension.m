//
//  NSString+SunExtension.m
//  光合联萌
//
//  Created by Sunallies on 16/6/30.
//
//

#import "NSString+SunExtension.h"
#import "LTCETools.h"
@implementation NSString (SunExtension)


- (NSInteger)fileSize {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    // 是否为文件夹
    BOOL isDirectory = NO;
    // 这个路径是否存在
    BOOL exists = [fileManger fileExistsAtPath:self isDirectory:&isDirectory];
    if (exists == NO) {
        // 路径不存在
        return 0;
    }
    if (isDirectory) { // 如果是文件夹
        NSInteger size = 0;
        NSDirectoryEnumerator * enumerator = [fileManger enumeratorAtPath:self];
        for (NSString * subPath in enumerator) {
            // 获得全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            // 获得文件属性
            NSDictionary *attrs = [fileManger attributesOfItemAtPath:fullPath error:nil];
            size += attrs.fileSize;
        }
        return size;
        
    } else { // 如果是文件
        
        return (NSInteger)[fileManger attributesOfItemAtPath:self error:nil].fileSize;
    }
}


+ (NSString *)URLEncodedString:(NSString *)urlString {
    static NSString * const kAFCharactersGeneralDelimitersToEncode = @""; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kAFCharactersSubDelimitersToEncode = @"";
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
    NSString *encodedString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    return encodedString;
}


// 获取沙盒document路径
+ (NSString *)stringOfSandiskDocumentDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+ (NSString *)stringWithName:(NSString *)name {
    NSString *language = [LTCETools isChinese];
    NSString *path;
    UIFont *fontN;
    if ([language isEqualToString:@"YES"]) {
        path = @"SkinS/Chinese/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:36 * 0.5 *kW];
    }else {
        path = @"SkinS/English/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:36 * 0.5 *kW];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    NSString *norStr = dic[name];
    return norStr;
}


+ (NSString *)getStringOfTimeWithTime:(NSString *)time InputFormat:(NSString *)inputFormat OutPutFormat:(NSString *)outPutFormat {
    NSDateFormatter * inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:inputFormat];
    NSDate * inputDate = [inputFormatter dateFromString:time];
    
    NSDateFormatter * outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:outPutFormat];
    return [outPutFormatter stringFromDate:inputDate];
}


+ (NSDate *)changeStringToDateWithDateFormat:(NSString *)dateFormat DateString:(NSString *)dateString {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter dateFromString:dateString];
}

@end
