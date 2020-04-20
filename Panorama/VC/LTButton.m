//
//  LTButton.m
//  启东·新湖
//
//  Created by 凌甜 on 2019/7/22.
//  Copyright © 2019 com.ATT.Xinhu. All rights reserved.
//

#import "LTButton.h"

@implementation LTButton

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
  
    self.imageView.k_centerX = self.k_Width * 0.5;
    self.imageView.k_Y = 0;
    self.titleLabel.k_Width = self.imageView.k_Width;
    self.titleLabel.k_Height = self.imageView.k_Height;
    [self.titleLabel sizeToFit];
    self.titleLabel.k_Y = CGRectGetMaxY(self.imageView.frame) + 10 * 0.5 *kH;
    self.titleLabel.k_centerX = self.k_Width * 0.5;
}

@end
