//
//  UIViewController+ZYTSwizzling.m
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import "UIViewController+ZYTSwizzling.h"
#import "NSObject+ZYTSwizzling.h"


@implementation UIViewController (ZYTSwizzling)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [NSObject swizzWithClass:[self class] withSysSelector:@selector(viewWillAppear:) mySelector:@selector(my_viewWillAppear:)];
            [NSObject swizzWithClass:[self class] withSysSelector:@selector(viewWillDisappear:) mySelector:@selector(my_viewWillDisAppear:)];
        }
    });
}
/** 进入页面 */
- (void)my_viewWillAppear:(BOOL)animation {
    [self event_viewWillAppear];
    [self my_viewWillAppear:animation];
}

/** 离开页面 */
- (void)my_viewWillDisAppear:(BOOL)animation {
    [self event_viewWillDisAppear];
    [self my_viewWillDisAppear:animation];
}

/** 进入页面统计 */
- (void)event_viewWillAppear {
    NSString *pageID = [self pageEventID:true];
    NSLog(@"\n进入页面事件：%@",pageID);
    //只要pageID不为空，表示为需要统计进入次数的页面，发送事件名pageID给服务器
}

/** 离开页面统计 */
- (void)event_viewWillDisAppear {
    NSString *pageID = [self pageEventID:false];
    NSLog(@"\n离开页面事件：%@",pageID);
}

- (NSString *)pageEventID:(BOOL)isEnterPage {
    NSDictionary *configDic = [NSObject dictionaryFromStatisticsConfig];
    NSString *selfClassName = NSStringFromClass([self class]);
    return configDic[selfClassName][@"PageEventID"][isEnterPage ? @"Enter" : @"Leave"];
}





@end
