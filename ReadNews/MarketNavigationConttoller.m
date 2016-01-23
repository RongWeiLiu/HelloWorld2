//
//  MarketNavigationConttoller.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "MarketNavigationConttoller.h"
#import "NewsViewController.h"
#import "PublicManager.h"
#import "NewsPageModel.h"
#import "TitleLabel.h"
@interface MarketNavigationConttoller ()<NewsDelegate> {
    //CGFloat _lastMaxX;
    
    NSMutableArray *_titleAry;
}

@end

@implementation MarketNavigationConttoller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationController];
    // Do any additional setup after loading the view from its nib.
}

- (void)customNavigationController {
    
   // UIScrollView *titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    _titleAry = [[NSMutableArray alloc] init];
    CGFloat height = self.navigationBar.frame.size.height;
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    sView.backgroundColor = [UIColor whiteColor];
    [sView addSubview:_scrollView];
    [self addTitleLabel:[PublicManager sharedManager].allPagesAry];
//    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_scrollView.frame), 0, height, height)];
//    [rightBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBtn setImage:[UIImage imageNamed:@"addZX"] forState:UIControlStateNormal];
//    [sView addSubview:rightBtn];
    //_scrollView.backgroundColor = [UIColor redColor];
    [self.navigationBar addSubview:sView];
    
}

- (void)addTitleLabel:(NSArray *)titleAry {
    
    CGFloat titleWidth = 80;
    CGFloat height = self.navigationBar.frame.size.height;
    for (NSInteger idx = 0; idx < titleAry.count; idx++) {
        NewsPageModel *pModel = titleAry[idx];
        TitleLabel *titleLabel = [[TitleLabel alloc] initWithFrame:CGRectMake(idx*titleWidth, 0, titleWidth, height)];
        if (idx == 0) {
            [titleLabel setScale:0.5];
        }else {
            [titleLabel setScale:0];
        }
        
        titleLabel.text = pModel.title;
        titleLabel.tag = 100+idx;
        titleLabel.userInteractionEnabled = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClicked:)];
        [titleLabel addGestureRecognizer:tap];
        [_titleAry addObject:titleLabel];
        [_scrollView addSubview:titleLabel];
        
    }
    CGSize contentSize = _scrollView.contentSize;
    contentSize.width = titleWidth*titleAry.count;
    _scrollView.contentSize = contentSize;
}

- (void)labelClicked:(UITapGestureRecognizer *)tap {
    NSInteger index =  tap.view.tag-100;
    TitleLabel *label = _titleAry[index];
    [label setScale:0.5];
    [_titleAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx!=index) {
            TitleLabel *label = _titleAry[idx];
            [label setScale:0];
            
        }
    }];
    if (self.mDelegate&&[self.mDelegate respondsToSelector:@selector(changeStatus:)]) {
        [self.mDelegate changeStatus:tap.view.tag-100];
    }
}

- (void)btnClicked:(UIButton *)btn {
//    if (self.mDelegate&&[self.mDelegate respondsToSelector:@selector(changeStatus:)]) {
//        [self.mDelegate changeStatus:10];
//    }
}

- (void)changIndex:(NSInteger)index {
    //NSLog(@"test");
    //if
    NSInteger maxCount = _scrollView.frame.size.width/80;
    TitleLabel *label = _titleAry[index];
    [label setScale:0.5];
    CGPoint offSet = _scrollView.contentOffset;
    if (index%maxCount == 0) {
        offSet.x = index/maxCount*80;
    }else {
        offSet.x = index*80;
    }
        _scrollView.contentOffset = offSet;
//    }
    //[label setTextColor:[UIColor redColor]];
    [_titleAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx!=index) {
            TitleLabel *label = _titleAry[idx];
            [label setScale:0];
            
        }
    }];
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
