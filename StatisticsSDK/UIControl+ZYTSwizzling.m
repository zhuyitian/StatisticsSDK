//
//  UIControl+ZYTSwizzling.m
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import "UIControl+ZYTSwizzling.h"
#import "NSObject+ZYTSwizzling.h"

@implementation UIControl (ZYTSwizzling)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject swizzWithClass:[self class] withSysSelector:@selector(sendAction:to:forEvent:) mySelector:@selector(my_sendAction:to:forEvent:)];
    });
}

- (void)my_sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    
    [self performWithAction:action to:target forEvent:event];
    [self my_sendAction:action to:target forEvent:event];
}

- (void)performWithAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event {
    NSString *actionString = NSStringFromSelector(action);
    NSString *targetName = NSStringFromClass([target class]);
    NSDictionary *configDic = [NSObject dictionaryFromStatisticsConfig];
    NSString *eventID = configDic[targetName][@"ControlEventIDs"][actionString];
    NSLog(@"\n类名：%@\n方法名：%@\n事件名：%@",targetName,actionString,eventID);
    //只需要判断eventID不为空，表示是需要统计的事件。发送给服务器就行。
}


@end
