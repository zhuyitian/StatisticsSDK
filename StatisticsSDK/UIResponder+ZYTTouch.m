//
//  UIResponder+ZYTTouch.m
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import "UIResponder+ZYTTouch.h"
#import "NSObject+ZYTSwizzling.h"
#import "UIApplication+LMTopVC.h"

@implementation UIResponder (ZYTTouch)

+ (void)load {
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
//            [NSObject swizzWithClass:[self class] withSysSelector:@selector(touchesEnded:withEvent:) mySelector:@selector(my_touchesEnded:withEvent:)];
//            [NSObject swizzWithClass:[self class] withSysSelector:@selector(touchesBegan:withEvent:) mySelector:@selector(my_touchesBegan:withEvent:)];
        }
    });
}

- (void)my_touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        [self statistics:touch];
    }
}

- (void)statistics:(UITouch *)touch {
    NSString *classname = NSStringFromClass([[[UIApplication sharedApplication] TopVC] class]);
//    NSLog(@"%@",touch.gestureRecognizers.firstObject);
    UIGestureRecognizer *ges = touch.gestureRecognizers.firstObject;
    NSLog(@"%@",ges.name);
//    NSString *actionname = NSStringFromSelector(touch)
    NSDictionary *configDic = [NSObject dictionaryFromStatisticsConfig];
//    NSString *eventID = configDic[classname][@"ControlEventIDs"][];
    
}

//- (void)my_touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    if (touch.tapCount == 1) {
//        NSString *classname = NSStringFromClass([touch.window class]);
//        NSLog(@"%@",classname);
//    }
////    NSLog(@"\n%@\n--------\n%@",touches,event);
//}

//    UILabel *touchLabel = [UILabel new];
//    touchLabel.text = @"触摸Label测试";
//    touchLabel.backgroundColor = [UIColor yellowColor];
//    touchLabel.textColor = [UIColor redColor];
//    touchLabel.textAlignment = NSTextAlignmentCenter;
//    touchLabel.frame = CGRectMake(0, 400, self.view.frame.size.width, 100);
//    touchLabel.userInteractionEnabled = true;
//    [self.view addSubview:touchLabel];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chumo)];
//    [touchLabel addGestureRecognizer:tap];


@end
