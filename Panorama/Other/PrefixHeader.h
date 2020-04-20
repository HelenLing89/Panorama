//
//  PrefixHeader.h
//  合生
//
//  Created by 凌甜 on 2018/5/31.
//  Copyright © 2018年 凌甜. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import "UIView+SunExtension.h"
#import "UIViewController+Extension.h"
#import "UIImage+SunExtension.h"
#import "Const.h"
//#import "Socket.h"


#ifdef DEBUG
#define ZHYLog(...) NSLog(__VA_ARGS__)
#define ZHYLogFunc ZHYLog(@"%s",__func__)
#else
#define ZHYLog(...)
#define ZHYLogFunc
#endif

// block弱引用
#define kWeakSelf __weak typeof(self) weakSelf = self;
// 取得当前主窗口
#define kKeyWindow [UIApplication sharedApplication].keyWindow
// 当前屏幕尺寸相关
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenW kScreenBounds.size.width
#define kScreenH kScreenBounds.size.height
#define kScale  kScreenW/kScreenH

// 颜色相关
#define kARGBColor(a, r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRGBColor(r, g, b) kARGBColor(255, (r), (g), (b))
#define kGrayColor(v) kRGBColor((v), (v), (v))
#define kCommonBgColor kGrayColor(215)
#define kRandomColor kARGBColor(0.6, arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
#define kBaseColor kRGBColor(130, 131, 125)
#define kBgColor kRGBColor(236, 234, 230)

// 将数据写到桌面的plist 注意: (其他人使用请修改 "sunallies" 为自己电脑的 UserName )
#define kWriteToPlist(data, filename) [data writeToFile:[NSString stringWithFormat:@"/Users/sunallies/Desktop/%@.plist", filename] atomically:YES];

// 缓存路径
#define kCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"default"]

#define kW  kScreenW / 1366
#define kH kScreenH / 1024

#define Path [[NSBundle mainBundle] pathForResource:@"贷款总额.plist" ofType:nil]
#define Path1 [[NSBundle mainBundle] pathForResource:@"计算方式.plist" ofType:nil]
#define Path2 [[NSBundle mainBundle] pathForResource:@"组合.plist" ofType:nil]
#define DataPath  [[NSBundle mainBundle] pathForResource:@"Data.plist" ofType:nil]
#define MethodPath  [[NSBundle mainBundle] pathForResource:@"Method.plist" ofType:nil]
#define RightPath  [[NSBundle mainBundle] pathForResource:@"右侧.plist" ofType:nil]

#define tag0 @"贷款类别选中"
#define tag1 @"计算方式选中"
#define tag2 @"还款方式选中"
#define tag3 @"组合中商业性"
#define tag4 @"组合中公积金"
#define tag5 @"贷款总额"
#define tag6 @"面积"
#define tag7 @"单价"
#define tag8 @"房款总额"
#define tag9 @"首期付款"
#define tag10 @"按揭成数"
#define tag11 @"按揭年数"
#define tag12 @"商业性利率"
#define tag13 @"公积金利率"

#define tag14 @"姓名"
#define tag15 @"电话"
#define tag16 @"问题1"
#define tag17 @"问题2"
#define tag18 @"问题3"

#endif /* PrefixHeader_h */
