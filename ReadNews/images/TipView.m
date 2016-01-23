//
//  TipView.m
//  ISMovie
//
//  Created by qianfeng on 15/12/13.
//  Copyright © 2015年 yuming. All rights reserved.
//

#import "TipView.h"

@implementation TipView

//- (instancetype)initWithText:(NSString *)text {
//    
//}

- (void)customTipViewWithText:(NSString *)text {
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.text = text;
    textLabel.font = [UIFont systemFontOfSize:10];
    textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:textLabel];
    
}

- (instancetype)initWithFrame:(CGRect)frame text:(NSString *)text {
    if (self = [super initWithFrame:frame]) {
        [self customTipViewWithText:text];
    }
    return self;
}

+ (void)showTipViewWithText:(NSString *)text superView:(UIView *)superView{
    TipView *tView = [superView viewWithTag:2000];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [tView removeFromSuperview];
    TipView *tipView = [[TipView alloc] initWithFrame:CGRectMake(0, 0, 200, 30) text:text];
    tipView.clipsToBounds = YES;
    tipView.layer.cornerRadius = 10;
    tipView.center = window.center;
    tipView.alpha = 0.5;
    tipView.backgroundColor = [UIColor blackColor];
    tipView.tag = 2000;
    [window addSubview:tipView];
    [UIView animateWithDuration:3 animations:^{
        tipView.alpha = 0;
    }completion:^(BOOL finished) {
        [tipView removeFromSuperview];
    }];
}

+ (void)showActivityIndicator {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    bkView.tag = 10000;
    bkView.clipsToBounds = YES;
    bkView.layer.cornerRadius = 10;
    bkView.backgroundColor = [UIColor blackColor];
    bkView.alpha = 0.5;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    activityIndicator.center = bkView.center;
    [bkView addSubview:activityIndicator];
    bkView.center = keyWindow.center;
    [activityIndicator startAnimating];
    [keyWindow addSubview:bkView];
}

+ (void)hideActivityIndicator {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *bkView = [keyWindow viewWithTag:10000];
    [bkView removeFromSuperview];
}

@end
