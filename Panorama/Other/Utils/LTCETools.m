//
//  LTCETools.m
//  养云村
//
//  Created by 凌甜 on 2019/12/6.
//  Copyright © 2019 com.ATT. All rights reserved.
//

#import "LTCETools.h"

@implementation LTCETools
+ (void)setChinese:(NSString *)Chinese {
    [[NSUserDefaults standardUserDefaults] setObject:Chinese forKey:@"chinese"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)isChinese {
    NSString *chinese = [[NSUserDefaults standardUserDefaults] stringForKey:@"chinese"];
    return chinese;
}

@end
