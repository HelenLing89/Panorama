//
//  UIColor+SunExtension.m
//  光合联萌
//
//  Created by Sunallies on 16/6/30.
//
//

#import "UIColor+SunExtension.h"

@implementation UIColor (SunExtension)


+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}
@end
