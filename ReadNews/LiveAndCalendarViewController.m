//
//  LiveAndCalendarViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LiveAndCalendarViewController.h"
#import "LiveViewController.h"
#import "CalendarViewController.h"
#import "Masonry.h"
@interface LiveAndCalendarViewController ()
@property ( nonatomic) UISegmentedControl *segmentControl;
@property (nonatomic) UIScrollView *contentScrollView;

@property (nonatomic)  UIView *contentView;

@end

@implementation LiveAndCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createContentView];
    [self createScrollView];
    [self createSegmentControl];
    [self addViewControllers];
    
    
    // Do any additional setup after loading the view.
}

- (void)createContentView {
    _contentView = [[UIView alloc] init];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(CWIDTH, CHEIGHT-20));
        make.top.equalTo(self.view.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)createSegmentControl {
    _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"直播",@"日历"]];
    [_segmentControl addTarget:self action:@selector(exchangeIndex:) forControlEvents:UIControlEventTouchUpInside];
    _segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:_segmentControl];
   // [self.view bringSubviewToFront:_segmentControl];
    [_segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(121, 30));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(32);
    }];
}

- (void)createScrollView {
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, CWIDTH, CHEIGHT-20)];
    [self.view addSubview:_contentScrollView];
    [self.view bringSubviewToFront:_contentScrollView];
    _contentScrollView.backgroundColor = [UIColor redColor];
    
}


- (void)addViewControllers {
    
    LiveViewController *lvc = [[LiveViewController alloc] init];
    CalendarViewController *cvc = [[CalendarViewController alloc] init];
    [self addChildViewController:lvc];
     [self addChildViewController:cvc];
    NSLog(@"%@",NSStringFromCGRect(_contentScrollView.frame));
    lvc.view.frame = _contentScrollView.bounds;
    cvc.view.frame = CGRectMake(CWIDTH,0, CWIDTH, CHEIGHT-20);
    
    //[lvc didMoveToParentViewController:self];
    [_contentScrollView addSubview:lvc.view];
    [_contentScrollView addSubview:cvc.view];
    //[_contentScrollView bringSubviewToFront:lvc.view];
    
    //[cvc didMoveToParentViewController:self];
   // _contentScrollView.contentSize =
    _contentScrollView.bounces = NO;
    _contentScrollView.contentSize = CGSizeMake(_contentScrollView.frame.size.width*2, _contentScrollView.frame.size.height);
    _contentScrollView.pagingEnabled = YES;

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
