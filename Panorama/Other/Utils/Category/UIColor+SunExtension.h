//
//  UIColor+SunExtension.h
//  光合联萌
//
//  Created by Sunallies on 16/6/30.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (SunExtension)

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;
//eg. self.window.backgroundColor = [UIColor colorWithHexValue:0x123456 alpha:0.8];

@end
