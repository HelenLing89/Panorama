//
//  RSBarItemButton.m
//  pvm
//
//  Created by Sunallies on 2016/10/25.
//  Copyright © 2016年 Sunallies. All rights reserved.
//

#import "RSBarItemButton.h"

@implementation RSBarItemButton

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.k_X = CGRectGetMaxX(self.imageView.frame) + 5;
}

@end
