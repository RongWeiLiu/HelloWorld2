//
//  MyTabBarController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "MyTabBarController.h"
#import "NewsViewController.h"
#import "MarketNavigationConttoller.h"
@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addConect];
    // Do any additional setup after loading the view.
}

- (void)addConect {
    
    self.tabBar.translucent = NO;
    MarketNavigationConttoller<NewsDelegate> *mnc = (MarketNavigationConttoller<NewsDelegate> *)self.childViewControllers[0];
    NewsViewController<MarketNavigationDelegate> *nvc = mnc.childViewControllers[0];
    mnc.mDelegate = nvc;
    nvc.delegate = mnc;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
