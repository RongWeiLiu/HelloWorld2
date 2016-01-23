//
//  MarketNavigationConttoller.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarketNavigationDelegate <NSObject>
@optional
- (void)changeStatus:(NSInteger)index;
- (void)updatePages:(NSInteger)pageCount;

@end

@interface MarketNavigationConttoller : UINavigationController

@property (nonatomic) id<MarketNavigationDelegate> mDelegate;
@property (nonatomic) UIScrollView *scrollView;
@end
