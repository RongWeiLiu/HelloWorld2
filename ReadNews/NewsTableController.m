//
//  NewsTableController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "NewsTableController.h"
#import "MJRefresh.h"
#import "NetWorkManager.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "ResultViewController.h"
#import "UIImageView+WebCache.h"
#import "NewsDetailViewController.h"



typedef NS_ENUM(NSInteger,SliderDouration){
    SliderDourationLeft,
    SliderDourationRight,
};

@interface NewsTableController ()<UIScrollViewDelegate> {
    
    NSString *_reuqestUrl;
    NewsPageModel *_pModel;
    NSInteger _pageIndex;
    NSMutableArray *_dataAry;
    NSMutableArray *_imagesAry;
    NewsModel *_nModel;
    UIScrollView *_scrollView;
    UISearchController *_searchController;
    UIView *_headView;
    NewsModel *_imageModel;
    UIPageControl *_pageControl;
    SliderDouration _sliderDouration;
    CGPoint _preOffset;
    NSInteger _currentIndex;
    NSInteger _imagesCount;
    NSMutableArray *_imageViewAry;
    BOOL _hasGotten;
    NSMutableArray *_tempImageAry;
    NSTimer *_timer;
    
}

@end

@implementation NewsTableController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self createHeadView];
    [self createRefreshControl];
    self.navigationItem.leftBarButtonItem = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changIndex) userInfo:nil repeats:YES];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)changIndex {
    if (_currentIndex == _imagesCount-1) {
        _currentIndex=0;
    }else {
        _currentIndex++;
    }
    CGPoint offSet = _scrollView.contentOffset;
    offSet.x = _scrollView.frame.size.width*2;
    [UIView animateWithDuration:1.0 animations:^{
        _scrollView.contentOffset = offSet;
    } completion:^(BOOL finished) {
        [self setImagesForScrollView];
        _scrollView.contentOffset = _preOffset;
        _pageControl.currentPage = _currentIndex;
    }];
//    _pageControl.currentPage = _currentIndex;
    //[self setImagesForScrollView];
}

- (void)createHeadView {
    
    _imageModel = [[NewsModel alloc] init];
//    ResultViewController *rvc = [[ResultViewController alloc] init];
//    _searchController = [[UISearchController alloc] initWithSearchResultsController:rvc];
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
//    [_headView addSubview:_searchController.searchBar];
    //CGFloat scrollViewY = CGRectGetMaxY(_searchController.searchBar.frame);
    //CGFloat searBarH = CGRectGetHeight(_searchController.searchBar.frame);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_scrollView.frame.size.width-100)/2, 200, 100, 20)];
    [_pageControl setTintColor:[UIColor purpleColor]];
    //_pageControl.backgroundColor = [UIColor redColor];
    [_headView addSubview:_scrollView];
    [_headView addSubview:_pageControl];
    if ([_pModel.title isEqualToString:@"全球"]) {
        self.tableView.tableHeaderView = _headView;
    }
    [self createImagesForScrollView];
    [self fetchDataForScrollView];
    
}



- (void)createImagesForScrollView {
    
    _imagesAry = [[NSMutableArray alloc] init];
    _tempImageAry = [[NSMutableArray alloc] init];
    _imagesAry = [[NSMutableArray alloc] init];
    _imageViewAry = [[NSMutableArray alloc] init];
    _currentIndex = 0;
    _imagesCount = 3;
    CGFloat width = _scrollView.frame.size.width;
    CGFloat height = _scrollView.frame.size.height;
    for (NSInteger idx = 0;idx < 3 ;idx++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx*width, 0, width, height)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked)];
        [imageView addGestureRecognizer:tap];
        imageView.image = [UIImage imageNamed:@"placeholderImage.jpg"];
        [_scrollView addSubview:imageView];
        [_tempImageAry addObject:imageView.image];
        [_imageViewAry addObject:imageView];
        
    }
    _preOffset = _scrollView.contentOffset;
    _preOffset.x = width;
    _scrollView.contentOffset = _preOffset;
    _scrollView.contentSize = CGSizeMake(3*width, height);

}


- (void)fetchDataForScrollView {
    _imageModel = [[NewsModel alloc] init];
     [NetWorkManager requestUrl:CINFO_FOUR_ONE success:^(id model) {
         _imageModel = model;
         [self setImageForScrollView];
     } failure:^{
         
     } model:_imageModel];
}

- (void)setImageForScrollView {
    
//    CGFloat width = _scrollView.frame.size.width;
//    CGFloat height = _scrollView.frame.size.height;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_imagesAry removeAllObjects];
        for (ResultModel *rModel in _imageModel.results) {
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:rModel.imageUrl]];
            UIImage *image = [UIImage imageWithData:imageData];
            [_imagesAry addObject:image];
        }
        //UIButton *btn = nil;
        _hasGotten = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            _imagesCount = _imagesAry.count;
            _pageControl.numberOfPages = _imagesCount;
          [self setImagesForScrollView];
        });
        
    });
    
}

- (void)imageClicked{
    
    NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
    ResultModel *rModel = _imageModel.results[_currentIndex];
    ndvc.requestUrl = rModel.url;
    ndvc.detailID = rModel.id;
    ndvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndvc animated:YES];
    
}

- (void)createRefreshControl {
    
    _nModel = [[NewsModel alloc] init];
    _dataAry = [[NSMutableArray alloc] init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self fetchData:NO];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchData:YES];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}



- (void)fetchData:(BOOL)isMore {
    
    NSInteger pageIndex = 0;
    if (isMore) {
        if (_dataAry.count%25==0) {
            pageIndex = _dataAry.count/25;
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    NSString *requestUrl = [NSString stringWithFormat:_pModel.requestUrl,pageIndex];
    [NetWorkManager requestUrl:requestUrl success:^(id model) {
        _nModel = model;
        if (!isMore) {
            [_dataAry removeAllObjects];
        }
        [_dataAry addObjectsFromArray:_nModel.results];
        [self.tableView reloadData];
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    } failure:^{
    } model:_nModel];
    
}

- (instancetype)initWithModel:(NewsPageModel *)pModel {
    if (self = [super init]) {
        _pModel = pModel;
    }
    return self;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return _dataAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResultModel *rModel = _dataAry[indexPath.row];
    static NSString *reuesID = @"cellID";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuesID];
    if (!cell) {
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuesID];
    }
    //cell.textLabel.text = rModel.title;
    [cell updateCell:rModel];
    // Configure the cell...
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ResultModel *rModel = _dataAry[indexPath.row];
    NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
    ndvc.requestUrl = rModel.url;
    ndvc.detailID = rModel.id;
    ndvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ndvc animated:YES];
    
}

#pragma mark --图片循环滚动的一些处理

- (void)setImagesForScrollView {
    
    NSMutableArray *imagesAry = [[NSMutableArray alloc] init];;
    if (_hasGotten) {
        [imagesAry addObjectsFromArray:_imagesAry];
    }else {
        [imagesAry addObjectsFromArray:_tempImageAry];
    }
    UIImageView *imageView1 = _imageViewAry[0];
    UIImageView *imageView2 = _imageViewAry[1];
    UIImageView *imageView3 = _imageViewAry[2];
    imageView1.userInteractionEnabled = YES;
    imageView2.userInteractionEnabled = YES;
    imageView3.userInteractionEnabled = YES;
    if (_currentIndex==_imagesCount-1) {
        [imageView1 setImage:imagesAry[_currentIndex-1]];
        [imageView2 setImage:imagesAry[_currentIndex]];
        [imageView3 setImage:imagesAry[0]];
    }else if (_currentIndex== 0) {
        [imageView1 setImage:imagesAry[_imagesCount-1]];
        [imageView2 setImage:imagesAry[_currentIndex]];
        [imageView3 setImage:imagesAry[_currentIndex+1]];
    }else {
        [imageView1 setImage:imagesAry[_currentIndex-1]];
        [imageView2 setImage:imagesAry[_currentIndex]];
        [imageView3 setImage:imagesAry[_currentIndex+1]];
    }
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (scrollView == _scrollView) {
        CGPoint correntOffset = scrollView.contentOffset;
        
            if (correntOffset.x > _preOffset.x) {
                _sliderDouration = SliderDourationLeft;
            }
            else if (correntOffset.x < _preOffset.x)
            {
                _sliderDouration = SliderDourationRight;
            }
    }
   
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (fabs(_preOffset.x-scrollView.contentOffset.x) < scrollView.frame.size.width/2) {
        return;
    }
    if (scrollView == _scrollView) {
        if (_sliderDouration == SliderDourationLeft) {
            if (_currentIndex == _imagesCount-1) {
                _currentIndex=0;
            }else {
                _currentIndex++;
            }
            
        }else if(_sliderDouration == SliderDourationRight){
            if (_currentIndex == 0) {
                _currentIndex=_imagesCount-1;
            }else {
                _currentIndex--;
            }
            
        }
        [self setImagesForScrollView];
        scrollView.contentOffset = _preOffset;
        _pageControl.currentPage = _currentIndex;
    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
