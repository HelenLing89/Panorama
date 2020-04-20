//
//  NSAttributedString+LTExtension.m
//  养云村
//
//  Created by 凌甜 on 2019/12/9.
//  Copyright © 2019 com.ATT. All rights reserved.
//

#import "NSAttributedString+LTExtension.h"
#import "LTCETools.h"
@implementation NSAttributedString (LTExtension)
+ (NSAttributedString *)stringWithName:(NSString *)name {
    NSString *language = [LTCETools isChinese];
    NSString *path;
    UIFont *fontN;
    if ([language isEqualToString:@"YES"]) {
        path = @"SkinS/Chinese/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:42 * 0.5 *kW];
    }else {
        path = @"SkinS/English/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:42 * 0.5 *kW];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    NSString *norStr = dic[name];
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = fontN;
    attDic[NSForegroundColorAttributeName] = kRGBColor(130, 131, 125);
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:norStr attributes:attDic];
    return str;
}
@end
