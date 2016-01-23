//
//  EmailCheckViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "EmailCheckViewController.h"
#import <WebKit/WebKit.h>
@interface EmailCheckViewController ()

@end

@implementation EmailCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeadView];
    [self createChoiceView];
    // Do any additional setup after loading the view.
}

- (void)createChoiceView {
    CGFloat gap = 20;
    CGFloat width = CWIDTH-gap*2;
    CGFloat height = 30;
    UIView *choiceView = [[UIView alloc] initWithFrame:CGRectMake(gap, 0, width, height*2)];
    UIButton *QQButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    QQButton.tag = 1001;
    QQButton.backgroundColor = [UIColor redColor];
    [QQButton setTitle:@"QQ邮箱验证" forState:UIControlStateNormal];
    UIButton *NetEasyButton = [[UIButton alloc] initWithFrame:CGRectMake(gap, CGRectGetMaxY(QQButton.frame), width, height)];
    [NetEasyButton setTitle:@"网易邮箱验证" forState:UIControlStateNormal];
    NetEasyButton.tag = 1002;
    [QQButton addTarget:self action:@selector(showWeb:) forControlEvents:UIControlEventTouchUpInside];
    choiceView.center = self.view.center;
    [choiceView addSubview:QQButton];
    [choiceView addSubview:NetEasyButton];
    [self.view addSubview:choiceView];
    
}

- (void)createWebView:(NSString *)requestUrl{
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, CWIDTH, CHEIGHT)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestUrl]];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)showWeb:(UIButton *)btn {
    NSInteger index = btn.tag;
    NSString *requestUrl = nil;
    switch (index) {
        case 1001:
            requestUrl = @"http://email.163.com/";
            break;
        case 1002:
            requestUrl = @"http://email.163.com/";
            break;
        default:
            break;
    }
    [self createWebView:requestUrl];
    
}

- (void)createHeadView {
    
    // _dataAry = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat gap = 10;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CWIDTH, 44)];
    //headView.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(gap, 2, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"adsmogo_button_left_default"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btn];
    [self.view addSubview:headView];
    
}

- (void)closeAction {
    [self dismissViewControllerAnimated:YES completion:nil];
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
