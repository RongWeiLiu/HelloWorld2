//
//  ArticleCommentViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "ArticleCommentViewController.h"
#import "OthersCommentModel.h"
#import "ArticleCommentFrame.h"
#import "MJRefresh.h"
#import "NetWorkManager.h"
#import "ArticleCommentCell.h"
#import "LoginViewController.h"
@interface ArticleCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,NSURLConnectionDataDelegate> {
    UITableView *_tableView;
    OthersCommentModel *_aModel;
    NSMutableArray *_dataAry;
    UIView *_headView;
    UITextView *_textView;
    NSMutableData *_resultData;
}

@end

@implementation ArticleCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    
    [self createNotificationCenter];
    [self createInputView];
    [self createHeadView];
    __weak id weakSelf = self;
    self.myCallBack = ^{
        [weakSelf createRefreshControl];
    };
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)createHeadView {
    
    // _dataAry = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat gap = 10;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, CWIDTH, 44)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(headView.center.x-50, 2, 100, 30)];
    titleLabel.text =@"评论列表";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    headView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:titleLabel];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(gap, 2, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"adsmogo_button_left_default"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:btn];
    [self.view addSubview:headView];
    
}
- (void)closeAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)createNotificationCenter {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardChanged:(NSNotification *)ntf {
    CGFloat douration = [ntf.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = [ntf.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:douration animations:^{
        _headView.transform = CGAffineTransformMakeTranslation(0, frame.origin.y-CHEIGHT);
    }];
}

- (void)createInputView {
    
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, CHEIGHT-40, CWIDTH, 45)];
    _headView.backgroundColor = [UIColor redColor];
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 2.5, CWIDTH-80, 30)];
    _textView.delegate = self;
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(CWIDTH-80, 2.5, 80, 30)];
    [_headView addSubview:_textView];
    [_headView addSubview:sendBtn];
    sendBtn.backgroundColor = [UIColor blueColor];
    [sendBtn addTarget:self action:@selector(sendConmentAction) forControlEvents:UIControlEventTouchUpInside];
    _headView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_headView];
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    //[self createInputView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _tableView) {
        
        [self.view endEditing:YES];
        
    }
    
}

- (void)sendConmentAction {
    if ([PublicManager sharedManager].userModel.token == nil) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
        return;
    }
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:CINFO_NEWS_DETAIL_COMMENT]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content_type"];
    NSDictionary *dict = @{@"content":_textView.text,@"threadId":_threadID,@"parentId":@"0"};
    NSData *infoData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    [request setValue:[NSString stringWithFormat:@"%ld",infoData.length] forHTTPHeaderField:@"Content_length"];
    [request setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    [request setHTTPBody:infoData];
    [request setHTTPMethod:@"POST"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];

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
        [_tableView.mj_header beginRefreshing];
        [self.view endEditing:YES];
    }else {
        [TipView showTipViewWithText:@"评论失败" superView:self.view];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [TipView showTipViewWithText:@"评论失败" superView:self.view];
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)createRefreshControl {
    
    _aModel = [[OthersCommentModel alloc] init];
    _dataAry = [[NSMutableArray alloc] init];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchData:NO];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self fetchData:YES];
    }];
    [_tableView.mj_header beginRefreshing];
    
}
- (void)fetchData:(BOOL)isMore {
    
    NSInteger pageIndex = 0;
    if (isMore) {
        if (_dataAry.count%25==0) {
            pageIndex = _dataAry.count/25;
        }else{
            [_tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    NSString *requestUrl = [NSString stringWithFormat:CINFO_NEWS_DETAIL_GET,_threadID];
    [NetWorkManager requestUrl:requestUrl success:^(id model) {
        _aModel = model;
        if (!isMore) {
            [_dataAry removeAllObjects];
        }
        [_dataAry addObjectsFromArray:[ArticleCommentFrame frameListFromModelList:_aModel.comments]];
        [_tableView reloadData];
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    } failure:^{
        [_tableView.mj_header endRefreshing];
    } model:_aModel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, CWIDTH, CHEIGHT-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
////#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _dataAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCommentFrame *aFrame = _dataAry[indexPath.row];
    
    ArticleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[ArticleCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell updateCell:aFrame];
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCommentFrame *aFrame = _dataAry[indexPath.row];
    return aFrame.rowHeight;
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
