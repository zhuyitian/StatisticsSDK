//
//  NSObject+ZYTSwizzling.h
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (ZYTSwizzling)

+ (void)swizzWithClass:(Class)cls
       withSysSelector:(SEL)sysSelector
                  mySelector:(SEL)mySelector;

+ (NSDictionary *)dictionaryFromStatisticsConfig;

@end
