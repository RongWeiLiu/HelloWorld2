//
//  UIScrollView+HeadView.h
//  CLYHeadImageView(spring)
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (HeadView)

@property (nonatomic, weak) UIView *topView;

- (void)addHeadView:(UIView *)headView;

@end
