//
//  ViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:@"http://a1.go2yd.com/Website/channel/news-list-for-best-channel?fields=title&fields=url&fields=source&fields=date&fields=image&fields=image_urls&fields=comment_count&fields=like&fields=up&fields=down&cstart=0&cend=30&refresh=1&infinite=true&appid=yidian&version=010917&distribution=com.apple.appstore&appid=yidian&cv=3.6.2.3&platform=0&net=wifi" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
    //UITabBarItem *item = [[UITabBarItem alloc] init];
    //item.image
    //    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"%@",result);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
   // NSMutableAttributedString *
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
