//
//  WeakWebViewScriptMessageDelegate.h
//  安曼·养云村
//
//  Created by 凌甜 on 2020/1/10.
//  Copyright © 2020 com.ATT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

@interface WeakWebViewScriptMessageDelegate : NSObject
@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;
@end

