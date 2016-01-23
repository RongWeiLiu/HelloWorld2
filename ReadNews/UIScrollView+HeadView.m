//
//  UIScrollView+HeadView.m
//  CLYHeadImageView(spring)
//
//  Created by qianfeng on 15/12/9.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "UIScrollView+HeadView.h"
#import <objc/runtime.h>
static char UIScrollViewHeadView;

@interface UIScrollView ()<UIScrollViewDelegate>

@end
@implementation UIScrollView (HeadView)

@dynamic topView;

- (void)setTopView:(UIView *)topView {
    [self willChangeValueForKey:@"HeadView"];
    /*
     *
     *
     *  @param self                    源对象
     *  @param UIScrollViewHeadView    关键字
     *  @param topView                 要关联的对象
     *  @param OBJC_ASSOCIATION_ASSIGN 关联的策略
     *
     *
     */
    objc_setAssociatedObject(self, &UIScrollViewHeadView, topView, OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"HeadView"];
}

- (UIView *)topView {
    /**
     *  获取关联的对象
     *
     *  @param self                 源对象
     *  @param UIScrollViewHeadView 对应的关键字
     *
     *  @return 关联的对象
     */
    return objc_getAssociatedObject(self, &UIScrollViewHeadView);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self scrollViewDidScroll:self];
}

- (void)addHeadView:(UIView *)headView {
    self.contentInset = UIEdgeInsetsMake(headView.bounds.size.height, 0, 0, 0);
    [self addSubview:headView];
     self.topView = headView;
    self.topView.frame = CGRectMake(0, -headView.bounds.size.width, headView.bounds.size.width, headView.bounds.size.height);
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    if (offSet.y<0) {
        self.topView.frame = CGRectMake(0, offSet.y, self.bounds.size.width, -offSet.y);
    }
}

@end
