//
//  UIViewController+Extension.h
//  珑府
//
//  Created by geek on 2018/6/25.
//  Copyright © 2018年 danzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (void)glitterEffectWithImageV:(UIImageView *)imageV glitterColor:(UIColor *)glitterColor baseColor:(UIColor *)baseColor;

- (void)playSoundEffect:(NSString*)name type:(NSString*)type;

@end
