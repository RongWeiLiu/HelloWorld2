//
//  NewsViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "NewsViewController.h"
#import "MarketNavigationConttoller.h"
#import "NewsTableController.h"
#import "PublicManager.h"
#import "NewsPageModel.h"
@interface NewsViewController ()<MarketNavigationDelegate,UIScrollViewDelegate>
//@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (nonatomic)  UIScrollView *contenScrollView;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createScrollView];
    self.navigationItem.backBarButtonItem = nil;
    //self addChildViewControllers:(NSArray *)
        // Do any additional setup after loading the view.
}

- (void)createScrollView {
    _contenScrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _contenScrollView.delegate = self;
    _contenScrollView.pagingEnabled = YES;
    [self.view addSubview:_contenScrollView];
    [self addChildViewControllers];
    
}

//- (instancetype)init {
//    if (self = [super init]) {
//        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self = [storyBoard instantiateViewControllerWithIdentifier:@"newsID"];
//    }
//    return self;
//}

- (void)addChildViewControllers {
    NSInteger count = [PublicManager sharedManager].allPagesAry.count;
    for (NewsPageModel *pModel in [PublicManager sharedManager].allPagesAry) {
        NewsTableController *ntc = [[NewsTableController alloc] initWithModel:pModel];
        [self addChildViewController:ntc];
    }
    NewsTableController *ntc = self.childViewControllers.firstObject;
    ntc.view.frame = _contenScrollView.bounds;
    //ntc.tableView.backgroundColor = [UIColor redColor];
    CGSize contentSize = _contenScrollView.contentSize;
    contentSize.width = _contenScrollView.frame.size.width*count;
    _contenScrollView.contentSize = contentSize;
    [_contenScrollView addSubview:ntc.view];
}

- (void)changeStatus:(NSInteger)index {
    //NSLog(@"%ld",index);
    
    CGPoint offSet = _contenScrollView.contentOffset;
    offSet.x = index*_contenScrollView.frame.size.width;
    [_contenScrollView setContentOffset:offSet animated:YES];
    
    NewsTableController *ntc = self.childViewControllers[index];
    if (ntc.view.superview)  return;
    
    CGFloat width = _contenScrollView.bounds.size.width;
    CGFloat height = _contenScrollView.bounds.size.height;
    CGFloat X = index*width;
    ntc.view.frame = CGRectMake(X, 0, width, height);
    //ntc.view.frame = _contenScrollView.bounds;
    //NSLog(@"%@",NSStringFromCGRect(ntc.view.frame));
   // ntc.view.backgroundColor = [UIColor redColor];
    [_contenScrollView addSubview:ntc.view];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    //self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat indexValue = fabs(_contenScrollView.contentOffset.x/_contenScrollView.frame.size.width);
    NSUInteger idx = (NSUInteger)indexValue;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(changIndex:)]) {
        [self.delegate changIndex:idx];
    }
    NewsTableController *ntc = self.childViewControllers[idx];
    if (ntc.view.superview)  return;
    CGFloat X = _contenScrollView.bounds.origin.x;
    CGFloat width = _contenScrollView.bounds.size.width;
    CGFloat height = _contenScrollView.bounds.size.height;
    ntc.view.frame = CGRectMake(X, 0, width, height);
   // ntc.view.frame = _contenScrollView.bounds;
    NSLog(@"%@",NSStringFromCGRect(ntc.view.frame));
    //ntc.view.backgroundColor = [UIColor redColor];
    [_contenScrollView addSubview:ntc.view];
    
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
