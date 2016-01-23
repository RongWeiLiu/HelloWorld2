//
//  NewsDetailViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "NewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "AFNetworking.h"
#import "Masonry.h"
#import "LoginViewController.h"
#import "MarketNavigationConttoller.h"
#import "ArticleCommentViewController.h"
@interface NewsDetailViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate,NSURLConnectionDataDelegate,UITextViewDelegate> {
    WKWebView *_webView;
    UIProgressView *_progressView;
    UIView *_footerView;
    NSMutableData *_resultData;
    BOOL _isSave;
    UIView *_headView;//键盘头视图
    UITextView *_textView;
    UITextField *_tempView;
}

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self createWebView];
    //[self createInputView];
    [self createFooterView];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    _resultData = [[NSMutableData alloc] init];
    if ([PublicManager sharedManager].userModel.token) {
        [self getCollectionInfo];
    }
    //[self createNotificationCenter];
//    self.navigationItem.backBarButtonItem = nil;
//    self.navigationItem.backBarButtonItem.
    // [self setNeedsStatusBarAppearanceUpdate];
    //_webView loadRequest:(nonnull NSURLRequest *)
    //[self loadHtml];
    // Do any additional setup after loading the view.
}

//- (void)createNotificationCenter {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
//}

//- (void)keyboardChanged:(NSNotification *)ntf {
//    CGFloat douration = [ntf.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    CGRect frame = [ntf.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    [UIView animateWithDuration:douration animations:^{
//        _headView.transform = CGAffineTransformMakeTranslation(0, frame.origin.y-CHEIGHT);
//    }];
//}

//- (void)createInputView {
//
//    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, CHEIGHT-40, CWIDTH, 45)];
//    _headView.backgroundColor = [UIColor redColor];
//    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 2.5, CWIDTH-80, 40)];
//    _textView.delegate = self;
//    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(CWIDTH-80, 2.5, 80, 40)];
//    [_headView addSubview:_textView];
//    [_headView addSubview:sendBtn];
//    sendBtn.backgroundColor = [UIColor blueColor];
//    [sendBtn addTarget:self action:@selector(sendConmentAction) forControlEvents:UIControlEventTouchUpInside];
//    _headView.backgroundColor = [UIColor lightGrayColor];
//    [self.view addSubview:_headView];
//    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
//    //[self createInputView];
//}

- (void)sendConmentAction {
    
    ArticleCommentViewController *avc = [[ArticleCommentViewController alloc] init];
    [self getThreadFromDetail:^(NSString *threadID) {
        avc.threadID = threadID;
        if (avc.myCallBack) {
            avc.myCallBack();
        }
       
        
      }];
    if ([_kind isEqualToString:@"comment"]) {
        [self presentViewController:avc animated:YES completion:nil];
    }else {
        [self.navigationController pushViewController:avc animated:YES];
    }
    
}

- (void)getThreadFromDetail:(void(^)(NSString *))succeess {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:CINFO_NEWS_DETAIL,_detailID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *resutlID = dict[@"comments"][@"id"];
        succeess(resutlID);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}





- (void)createFooterView {
    _tempView = [[UITextField alloc] init];
    [self.view addSubview:_tempView];
    _footerView = [[UIView alloc] init];
    _footerView.backgroundColor = [UIColor whiteColor];
    [self.view  addSubview:_footerView];
    CGFloat width = 25;
    CGFloat height = 25*4/5;
    CGFloat padding = (self.view.frame.size.width-width*5)/4;
    UIButton *backBtn = [[UIButton alloc] init];
    UIButton *collectBtn = [[UIButton alloc] init];
    UIButton *conmentBtn = [[UIButton alloc] init];
    UIButton *setFontBtn = [[UIButton alloc] init];
    UIButton *shareBtn = [[UIButton alloc] init];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"backWZ"] forState:UIControlStateNormal];
    backBtn.tag = 101;
    [collectBtn setBackgroundImage:[UIImage imageNamed:@"starWZ"] forState:UIControlStateNormal];
    collectBtn.tag = 102;
    [conmentBtn setBackgroundImage:[UIImage imageNamed:@"commentWZ"] forState:UIControlStateNormal];
    conmentBtn.tag = 103;
    [setFontBtn setBackgroundImage:[UIImage imageNamed:@"fontH"] forState:UIControlStateNormal];
    setFontBtn.tag = 104;
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"shareWZ"] forState:UIControlStateNormal];
    shareBtn.tag = 105;
    [backBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [conmentBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [setFontBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_footerView addSubview:backBtn];
    [_footerView addSubview:collectBtn];
    [_footerView addSubview:conmentBtn];
    [_footerView addSubview:setFontBtn];
    [_footerView addSubview:shareBtn];
    [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(@40);
        
    }];
    [conmentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.center.equalTo(_footerView);
    }];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerY.equalTo(conmentBtn.mas_centerY);
        make.right.equalTo(conmentBtn.mas_left).offset(-padding);
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerY.equalTo(conmentBtn.mas_centerY);
        make.right.equalTo(collectBtn.mas_left).offset(-padding);
    }];
   
    [setFontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerY.equalTo(conmentBtn.mas_centerY);
        make.right.equalTo(_footerView.mas_right).offset(-8);
    }];
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(width, height));
        make.centerY.equalTo(conmentBtn.mas_centerY);
        make.right.equalTo(setFontBtn.mas_left).offset(-padding);
    }];
    
}

- (void)getCollectionInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString stringWithFormat:CINFO_MY_SHOUCANG_XINWEN,1000,1] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        for (NSDictionary *dic in dict[@"results"]) {
            if ([_detailID isEqualToString:dic[@"post"][@"id"]]) {
                UIButton *btn = [(UIButton *)_footerView viewWithTag:102];
                [btn setImage:[UIImage imageNamed:@"starblueWZ"] forState:UIControlStateNormal];
                _isSave = YES;
                break;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



- (void)btnClicked:(UIButton *)button {
    NSInteger index = button.tag;
    switch (index) {
        case 101:
            if ([_kind isEqualToString:@"comment"]) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            break;
        case 102:{
            if (_isSave) {
                UIButton *btn = [(UIButton *)_footerView viewWithTag:102];
                [btn setImage:[UIImage imageNamed:@"starWZ"] forState:UIControlStateNormal];
                [self deleteColletion];
            }else {
            [self collect];
            }
        }
            break;
        case 103:
            //[self share];
            [self sendConmentAction];
            break;
        case 104:
            
            break;
        case 105:
            
            break;
        default:
            break;
    }
//    LoginViewController *lvc = [[LoginViewController alloc] init];
//    [self presentViewController:lvc animated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleDefault;
}

- (void)share {
    
}

//收藏
- (void)collect {
    if ([PublicManager sharedManager].userModel.token == nil) {
        
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
        return;
        
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    [manager PUT:[NSString stringWithFormat:CINFO_NEWS_SHOUCANG_NEWS,_detailID] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"result:%@",result);
        [TipView showTipViewWithText:@"收藏成功" superView:self.view];
        _isSave = YES;
        UIButton *btn = [(UIButton *)_footerView viewWithTag:102];
        [btn setImage:[UIImage imageNamed:@"starblueWZ"] forState:UIControlStateNormal];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [TipView showTipViewWithText:@"收藏失败" superView:self.view];
    }];
    //NSMutableURLRequest
    
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:CINFO_NEWS_SHOUCANG_NEWS,_detailID]]];
//    NSData *infoData = [NSJSONSerialization dataWithJSONObject:[PublicManager sharedManager].userModel.token options:NSJSONWritingPrettyPrinted error:nil];
//    [request setValue:@"application/json" forHTTPHeaderField:@"Conten_type"];
//    [request setValue:[NSString stringWithFormat:@"%ld",infoData.length] forHTTPHeaderField:@"Content_length"];
//    [request setHTTPBody:infoData];
//    [request setHTTPMethod:@"POST"];
//    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    [connection start];
}
- (void)deleteColletion {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    
    [manager DELETE:[NSString stringWithFormat:CINFO_NEWS_SHOUCANG_NEWS,_detailID] parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",result);
        [TipView showTipViewWithText:@"取消收藏成功" superView:self.view];
        _isSave = NO;
        UIButton *btn = [(UIButton *)_footerView viewWithTag:102];
        [btn setImage:[UIImage imageNamed:@"starWZ"] forState:UIControlStateNormal];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [TipView showTipViewWithText:@"取消收藏失败" superView:self.view];
    }];

}

//跳转到评论界面
- (void)conmentView {
    if ([PublicManager sharedManager].userModel == nil) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [lvc presentViewController:lvc animated:YES completion:nil];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _resultData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_resultData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:_resultData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"result:%@",result);
    if (result[@"content"]) {
        [TipView showTipViewWithText:@"评论成功" superView:self.view];
        [self.view endEditing:YES];
    }else {
        [TipView showTipViewWithText:@"评论失败" superView:self.view];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [TipView showTipViewWithText:@"评论失败" superView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBarHidden = YES;
}

//- (void)viewDidDisappear:(BOOL)animated {
//    MarketNavigationConttoller *nav = (MarketNavigationConttoller *)self.navigationController;
//    nav.scrollView.hidden = NO;
//}

- (void)createWebView {
    
    _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 2)];
    //_progressView.progressTintColor = [UIColor yellowColor];
    _progressView.trackTintColor = [UIColor whiteColor];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height+24)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(webTouched:)];
    [_webView addGestureRecognizer:tap];
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_requestUrl]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    [self.view addSubview:_progressView];
    
}

- (void)webTouched:(UITapGestureRecognizer *)tap {
    [_textView resignFirstResponder];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [_progressView setProgress:_webView.estimatedProgress animated:YES];
    if (_progressView.progress >= 1.0) {
        _progressView.hidden = YES;
        [_progressView setProgress:0.0 animated:YES];
        [self deleleElementInHtml];

    }else {
        _progressView.hidden = NO;
    }
}

//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)deleleElementInHtml {
    
    NSMutableString *js1 = [[NSMutableString alloc] init];
    [js1 appendString:@"var toolbar = document.getElementsByClassName('toolbar')[0];"];
    [js1 appendString:@"toolbar.parentNode.removeChild(toolbar);"];
    [_webView evaluateJavaScript:js1 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    NSMutableString *js2 = [[NSMutableString alloc] init];
    [js2 appendString:@"var sharebar = document.getElementsByClassName('sharebar')[0];"];
    [js2 appendString:@"sharebar.parentNode.removeChild(sharebar);"];
    [_webView evaluateJavaScript:js2 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    NSMutableString *js3 = [[NSMutableString alloc] init];
    [js3 appendString:@"var related-news = document.getElementsByClassName('related-news')[0];"];
    [js3 appendString:@"related-news.parentNode.removeChild(related-news);"];
    [_webView evaluateJavaScript:js3 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    //hide-for-app
    NSMutableString *js4 = [[NSMutableString alloc] init];
    [js4 appendString:@"var loadmore = document.getElementsByClassName('load-more-hot-comment')[0];"];
    [js4 appendString:@"load-more-hot-loadmore.parentNode.removeChild(loadmore);"];
    [_webView evaluateJavaScript:js4 completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    NSMutableString *js5 = [[NSMutableString alloc] init];
    [js5 appendString:@"var hideforapp = document.getElementsByClassName('load-more-hot-comment')[0];"];
    [js5 appendString:@"hideforapp.parentNode.removeChild(hideforapp);"];

}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
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
