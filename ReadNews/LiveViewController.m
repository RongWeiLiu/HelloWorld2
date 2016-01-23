//
//  LiveViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveCell.h"
#import "MJRefresh.h"
#import "NetWorkManager.h"
#import "LiveDetailViewController.h"
#import "LiveFrame.h"
@interface LiveViewController ()<UITableViewDataSource,UITableViewDelegate> {
    NSMutableArray *_dataAry;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createRefresh];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)createRefresh {
    
//    [_tableView registerNib:[UINib nibWithNibName:@"LiveCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
        if (_dataAry.count%30==0) {
            pageIndex = _dataAry.count/30;
        }else{
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
    }
    NSString *requestUrl = [NSString stringWithFormat:CINFO_ZHIBO_REFRESH,pageIndex];
    [NetWorkManager requestUrl:requestUrl success:^(id model) {
        if (!isMore) {
            [_dataAry removeAllObjects];
        }
        [_dataAry addObjectsFromArray:[LiveFrame frameListFromModelList:model]];
        [self.tableView reloadData];
        isMore?[self.tableView.mj_footer endRefreshing]:[self.tableView.mj_header endRefreshing];
    } failure:^{
    } model:_dataAry];
    
}



- (instancetype)init {
    if (self = [super init]) {
        
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"liveID"];
        
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return _dataAry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveFrame *lFrame = _dataAry[indexPath.row];
    LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[LiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell updateCell:lFrame];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveFrame *lFrame = _dataAry[indexPath.row];
    return lFrame.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveFrame *lFrame = _dataAry[indexPath.row];
    LiveDetailViewController *ldvc = [[LiveDetailViewController alloc] init];
    ldvc.lModel = lFrame.lModel;
    [self.navigationController pushViewController:ldvc animated:YES];
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
