//
//  UIImage+SunExtension.m
//  pvm
//
//  Created by Sunallies on 2017/10/13.
//  Copyright © 2017年 Sunallies. All rights reserved.
//

#import "UIImage+SunExtension.h"
#import "LTCETools.h"
@implementation UIImage (SunExtension)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithName:(NSString *)name {
    NSString *language = [LTCETools isChinese];
    NSString *path;
    if ([language isEqualToString:@"YES"]) {
        path = [NSString stringWithFormat:@"SkinS/Chinese/%@", name];
    }else {
        path = [NSString stringWithFormat:@"SkinS/English/%@", name];
    }
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:nil]];
}


@end
