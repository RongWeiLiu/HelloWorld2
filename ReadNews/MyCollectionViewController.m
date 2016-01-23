//
//  MyCollectionViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "AFNetworking.h"
#import "CollectionModel.h"
#import "NewsDetailViewController.h"
#import "MJRefresh.h"
@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate> {
    CollectionModel *_nModel;
    UITableView *_tableView;
    //NSMutableArray *_dataAry;
}

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeadView];
    [self createTableView];
    [self createRefreshControl];
    //_nModel = [[NewsModel alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)createRefreshControl {
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self getCollectionInfo];
    }];
    [_tableView.mj_header beginRefreshing];
    
}


- (void)createHeadView {
   // _dataAry = [[NSMutableArray alloc] init];
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

- (void)viewWillDisappear:(BOOL)animated {
    [self getCollectionInfo];
}

- (void)closeAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, CWIDTH, CHEIGHT-60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

- (void)getCollectionInfo {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    [manager GET:[NSString stringWithFormat:CINFO_MY_SHOUCANG_XINWEN,1000,1] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _nModel = [[CollectionModel alloc] initWithData:responseObject error:nil];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",result);
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self getCollectionInfo];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//#warning Incomplete implementation, return the number of rows
    return _nModel.results.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CResultModel *rModel = _nModel.results[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = rModel.post.title;
    cell.textLabel.numberOfLines = 2;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[rModel.post.createdAt doubleValue]];
    NSString *str = [formatter stringFromDate:time];
    cell.detailTextLabel.text = str;
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     CResultModel *rModel = _nModel.results[indexPath.row];
    NewsDetailViewController *ndvc = [[NewsDetailViewController alloc] init];
    ndvc.detailID = rModel.post.id;
    ndvc.requestUrl = rModel.post.url;
    ndvc.kind = @"comment";
    [self presentViewController:ndvc animated:YES completion:nil];
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
