//
//  UIButton+LTExtension.h
//  养云村
//
//  Created by 凌甜 on 2019/12/9.
//  Copyright © 2019 com.ATT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LTExtension)
 - (void )btnWithImageName:(NSString *)name WithState:(UIControlState) state WithFontSize:(CGFloat) fontSize WithFontColor:(UIColor *)fontColor;
- (void )btnWithImageName:(NSString *)name WithState:(UIControlState) state;
@end

NS_ASSUME_NONNULL_END
