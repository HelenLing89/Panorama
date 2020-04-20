//
//  UITextField+SunExtension.m
//  pvm
//
//  Created by Sunallies on 2016/10/24.
//  Copyright © 2016年 Sunallies. All rights reserved.
//

#import "UITextField+SunExtension.h"

static NSString * const ZHYPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (SunExtension)

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    BOOL change = NO;
    // 保证有占位文字
    if (self.placeholder == nil) {
        self.placeholder = @"";
        change = YES;
    }
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:ZHYPlaceholderColorKey];
    // 恢复原状
    if (change) {
        self.placeholder = nil;
    }
}


- (UIColor *)placeholderColor {
    return [self valueForKeyPath:ZHYPlaceholderColorKey];
}

@end
