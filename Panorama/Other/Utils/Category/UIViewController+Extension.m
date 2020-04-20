//
//  UIViewController+Extension.m
//  珑府
//
//  Created by geek on 2018/6/25.
//  Copyright © 2018年 danzel. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation UIViewController (Extension)

- (void)glitterEffectWithImageV:(UIImageView *)imageV glitterColor:(UIColor *)glitterColor baseColor:(UIColor *)baseColor {
    CGRect gradientRect = CGRectMake(- imageV.bounds.size.width * 1.5, 0, 4 * - imageV.bounds.size.width,imageV.bounds.size.height);
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = gradientRect;
    gradientLayer.colors = @[(id)baseColor.CGColor,(id)glitterColor.CGColor,(id)baseColor.CGColor];
    gradientLayer.locations = @[@(0.25),@(0.35),@(0.45),@(0.55),@(0.65),@(0.75)];
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    gradientLayer.position = CGPointMake(imageV.bounds.size.width * 0.5, imageV.bounds.size.height/2.0);
    [imageV.layer addSublayer:gradientLayer];
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectOffset(imageV.bounds,imageV.bounds.size.width * 1.5, 0);
    maskLayer.contents = (__bridge id)(imageV.image.CGImage);
    gradientLayer.mask = maskLayer;
    CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"locations"];
    fadeAnim.fromValue = @[@(0.0),@(0.0),@(0.25),@(0.5)];
    fadeAnim.toValue = @[@(0.75),@(1.0),@(1.0)];
    fadeAnim.duration= 3;
    fadeAnim.repeatCount = CGFLOAT_MAX;
    [gradientLayer addAnimation:fadeAnim forKey:nil];
}

- (void)playSoundEffect:(NSString*)name type:(NSString*)type {
    
    SystemSoundID soundFileObject;
    //得到音效文件的地址
    
    NSString*soundFilePath =[[NSBundle mainBundle]pathForResource:name ofType:type];
    
    //将地址字符串转换成url
    
    NSURL*soundURL = [NSURL fileURLWithPath:soundFilePath];
    
    //生成系统音效id
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundFileObject);
    
    //播放系统音效
    
    AudioServicesPlaySystemSound(soundFileObject);
    
}

@end
