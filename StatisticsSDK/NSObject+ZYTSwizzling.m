//
//  NSObject+ZYTSwizzling.m
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import "NSObject+ZYTSwizzling.h"

@implementation NSObject (ZYTSwizzling)

+ (void)swizzWithClass:(Class)cls
       withSysSelector:(SEL)sysSelector
            mySelector:(SEL)mySelector {
    
    Method sysMethod = class_getInstanceMethod(cls, sysSelector);
    Method myMethod = class_getInstanceMethod(cls, mySelector);
    
    BOOL didAddMethod = class_addMethod(cls, sysSelector, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, mySelector, method_getImplementation(sysMethod), method_getTypeEncoding(sysMethod));
    }else {
        method_exchangeImplementations(sysMethod, myMethod);
    }
}

+ (NSDictionary *)dictionaryFromStatisticsConfig {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"ZYTStatisticsConfig" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:filePath];
}

@end
