//
//  LTCETools.h
//  养云村
//
//  Created by 凌甜 on 2019/12/6.
//  Copyright © 2019 com.ATT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTCETools : NSObject
+ (void)setChinese:(NSString *)Chinese;

/**
 获得当前点击为中英文
 */
+ (NSString *)isChinese;
@end

NS_ASSUME_NONNULL_END
