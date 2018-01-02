//
//  StatisticsSDKTests.m
//  StatisticsSDKTests
//
//  Created by 朱一天 on 2018/1/1.
//  Copyright © 2018年 朱一天. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+ZYTSwizzling.h"

@interface StatisticsSDKTests : XCTestCase

@end

@implementation StatisticsSDKTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


- (void)testIfUserStatisticsConfigPlistValid {
    //拿到配置表
    NSDictionary *configDic = [NSObject dictionaryFromStatisticsConfig];
    XCTAssertNotNil(configDic,@"ZYTStatisticsConfig.plist加载失败");
    [configDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        XCTAssert([obj isKindOfClass:[NSDictionary class]],@"plist文件结构可能已经改变，请确认");
        NSString *targetPageName = key;
        Class pageclass = NSClassFromString(targetPageName);
        id pageInstance = [[pageclass alloc] init];
        //一个pageDict对应一个页面，存放pageID,所有的action及对应的eventID
        NSDictionary *pageDict = (NSDictionary *)obj;
        //页面配置信息
        NSDictionary *pageEventIDDic = pageDict[@"PageEventID"];
        //交互配置信息
        NSDictionary *ControlEventIDDic = pageDict[@"ControlEventIDs"];
        XCTAssert(pageEventIDDic,@"plist未包含pageID字段或该字段值为空");
        XCTAssert(ControlEventIDDic,@"plist未包含EventIDs字段或该字段值为空");
        [pageEventIDDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
            XCTAssert([value isKindOfClass:[NSString class]],@"plist文件结构可能已经改变，请确认");
            XCTAssertNotNil(value,@"EventID为空，请确认");
        }];
        [ControlEventIDDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
            XCTAssert([value isKindOfClass:[NSString class]],@"plist文件结构可能已经改变，请确认");
            NSString *actionName = key;
            SEL actionSelector = NSSelectorFromString(actionName);
            XCTAssert([pageInstance respondsToSelector:actionSelector],@"代码与plist文件不匹配，请确认[%@--%@]",actionName,targetPageName);
            XCTAssertNotNil(value,@"EventIDs不能为空，请确认");
        }];
        
    }];
    
}

@end
