//
//  ViewController.m
//  StatisticsSDK
//
//  Created by 朱一天 on 2017/12/31.
//  Copyright © 2017年 朱一天. All rights reserved.
//

#import "ViewController.h"
#import "aaaaViewController.h"



@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creat];
}

- (void)creat {
    UIButton *fenxiang = [UIButton buttonWithType:UIButtonTypeCustom];
    fenxiang.frame = CGRectMake(0, 100, 100, 100);
    [fenxiang setTitle:@"分享" forState:UIControlStateNormal];
    fenxiang.backgroundColor = [UIColor grayColor];
    [fenxiang addTarget:self action:@selector(fenxiang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fenxiang];
    
    UIButton *shoucang = [UIButton buttonWithType:UIButtonTypeCustom];
    shoucang.frame = CGRectMake(100, 200, 100, 100);
    [shoucang setTitle:@"收藏" forState:UIControlStateNormal];
    shoucang.backgroundColor = [UIColor grayColor];
    [shoucang addTarget:self action:@selector(shoucang) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shoucang];
    
    UIButton *butongji = [UIButton buttonWithType:UIButtonTypeCustom];
    butongji.frame = CGRectMake(200, 300, 150, 100);
    butongji.titleLabel.numberOfLines = 0;
    [butongji setTitle:@"不用统计的按钮,用来跳转" forState:UIControlStateNormal];
    butongji.backgroundColor = [UIColor grayColor];
    [butongji addTarget:self action:@selector(butongji) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:butongji];
    
    
    
    
}

- (void)fenxiang {
    
}
- (void)shoucang {
    
}
- (void)butongji {
    aaaaViewController *aaa = [aaaaViewController new];
    [self.navigationController pushViewController:aaa animated:YES];
//    NSLog(@"不用统计的事件");
}




@end
