//
//  LTCustomBtn.m
//  启东·新湖
//
//  Created by 凌甜 on 2019/8/18.
//  Copyright © 2019 com.ATT.Xinhu. All rights reserved.
//

#import "LTCustomBtn.h"

@implementation LTCustomBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.k_Width = self.k_Width * 0.9;
    self.imageView.k_Height = self.k_Height * 0.9;
    self.imageView.k_centerX = self.k_Width * 0.5;
    self.imageView.k_centerY = self.k_Height * 0.5;
    
    [self insertSubview:self.titleLabel aboveSubview:self.imageView];
    self.titleLabel.k_Width = self.imageView.k_Width;
    self.titleLabel.k_Height = self.imageView.k_Height;
    [self.titleLabel sizeToFit];
    self.titleLabel.k_centerY = self.k_Height * 0.85;
    self.titleLabel.k_centerX = self.k_Width * 0.5;

}


@end
