//
//  UIButton+LTExtension.m
//  养云村
//
//  Created by 凌甜 on 2019/12/9.
//  Copyright © 2019 com.ATT. All rights reserved.
//

#import "UIButton+LTExtension.h"
#import "LTCETools.h"
@implementation UIButton (LTExtension)
- (void )btnWithImageName:(NSString *)name WithState:(UIControlState) state {
    NSString *language = [LTCETools isChinese];
    NSString *path;
    UIFont *fontN;
    UIFont *fontS;
    //中文
    if ([language isEqualToString:@"YES"]) {
        path = @"SkinS/Chinese/words.plist";
        fontN = [UIFont fontWithName:@"SourceHanSansCN-Normal" size:36 * 0.5 *kW];
        fontS = [UIFont fontWithName:@"SourceHanSansCN-Medium" size:36 * 0.5 *kW];
    }else {
        path = @"SkinS/English/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:36 * 0.5 *kW];
        fontS = [UIFont fontWithName:@"Whitney-Semibold" size:36 * 0.5 *kW];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    NSString *norMal = dic[name];
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = fontN;
    attDic[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:norMal attributes:attDic];
    [self setAttributedTitle:str forState:UIControlStateNormal];
    attDic[NSFontAttributeName] = fontS;
    NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:norMal attributes:attDic];
    [self setAttributedTitle:str1 forState:UIControlStateSelected];
}


- (void )btnWithImageName:(NSString *)name WithState:(UIControlState) state WithFontSize:(CGFloat) fontSize WithFontColor:(UIColor *)fontColor{
    NSString *language = [LTCETools isChinese];
    NSString *path;
    UIFont *fontN;
    UIFont *fontS;
    //中文
    if ([language isEqualToString:@"YES"]) {
        path = @"SkinS/Chinese/words.plist";
        fontN = [UIFont fontWithName:@"SourceHanSansCN-Normal" size:fontSize];
        fontS = [UIFont fontWithName:@"SourceHanSansCN-Medium" size:fontSize];
    }else {
        path = @"SkinS/English/words.plist";
        fontN = [UIFont fontWithName:@"Whitney-Book" size:fontSize];
        fontS = [UIFont fontWithName:@"Whitney-Semibold" size:fontSize];
    }
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
    NSString *norMal = dic[name];
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    attDic[NSFontAttributeName] = fontN;
    attDic[NSForegroundColorAttributeName] = fontColor;
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:norMal attributes:attDic];
     [self setAttributedTitle:str forState:UIControlStateNormal];
     attDic[NSFontAttributeName] = fontS;
      NSAttributedString *str1 = [[NSAttributedString alloc] initWithString:norMal attributes:attDic];
     [self setAttributedTitle:str1 forState:UIControlStateSelected];
     self.k_size = CGSizeMake([self calculateRowWidth:norMal WithAttributeDic:attDic], 90 * 0.5 *kH);
}

- (CGFloat)calculateRowWidth:(NSString *)string WithAttributeDic:(NSDictionary *)dic{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 90 * 0.5 *kH) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}


//- (void )btnWithImnageName:(NSString *)name WithState:(UIControlState) state {
//    NSString *language = [LTCETools isChinese];
//    NSString *path;
//    //中文
//    if ([language isEqualToString:@"YES"]) {
//        path = @"SkinS/Chinese/menu.plist";
//    }else {
//        path = @"SkinS/English/menu.plist";
//    }
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
//    NSString *norMal = dic[name];
//    [self setAttributedTitle:str forState:UIControlStateNormal];
//    attDic[NSFontAttributeName] = fontS;
//    [self setAttributedTitle:str forState:UIControlStateSelected];
//}
@end
