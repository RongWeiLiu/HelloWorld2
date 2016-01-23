//
//  LiveDetailViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LiveDetailViewController.h"
#import "UIImageView+WebCache.h"
@interface LiveDetailViewController () {
    UIScrollView *_scrollView;
    UILabel *_updateTime;
    UILabel *_content;
}

@end

@implementation LiveDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[self createHeadView];
    [self createDetailView];
    // Do any additional setup after loading the view.
    
}

- (void)createHeadView {
    
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

- (void)createDetailView {
    
    CGFloat gap = 10;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(gap, gap*2, 20, 20)];
    UILabel *updateTime = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), gap*2, CWIDTH, 20)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[_lModel.node_created doubleValue]];
    NSString *str = [formatter stringFromDate:time];
    updateTime.text = str;
    CGSize contentSize = [_lModel.node_content boundingRectWithSize:CGSizeMake(CWIDTH-gap*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(gap, CGRectGetMaxY(updateTime.frame), contentSize.width, contentSize.height)];
    content.font = [UIFont systemFontOfSize:15];
    content.text = _lModel.node_content;
    content.numberOfLines = 0;
    UIImageView *tempImage = [[UIImageView alloc] init];
    [tempImage sd_setImageWithURL:[NSURL URLWithString:_lModel.node_icon]];
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(gap, CGRectGetMaxY(content.frame), tempImage.image.size.width, tempImage.image.size.height)];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 44, CWIDTH, CHEIGHT-44)];
    [_scrollView addSubview:imageView];
    [_scrollView addSubview:updateTime];
    [_scrollView addSubview:content];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(content.frame));
    if (_lModel.node_icon) {
        [_scrollView addSubview:iconView];
        _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, CGRectGetMaxY(iconView.frame));
    }
    
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
