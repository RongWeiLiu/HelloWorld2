//
//  SettingViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "SettingViewController.h"
#import "UIScrollView+HeadView.h"
#import "WYMCachesManager.h"
#import "ComentViewController.h"
#import "MyCollectionViewController.h"
#import "LoginViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
@interface SettingViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cacheSize;

@property (nonatomic) UIImageView *headIcon;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIImageView *imageView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //写入
    [[NSUserDefaults standardUserDefaults] setValue:@"123" forKey:@"username"];
    //获取
    [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CWIDTH, 200)];
    [_imageView setImage:[UIImage imageNamed:@"news_detail_top_default.jpg"]];
    [self.tableView addHeadView:_imageView];
    [self createHeadIconView];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
}


- (void)createHeadIconView {
    
    _headIcon = [[UIImageView alloc] initWithFrame:CGRectMake(CWIDTH/2-30, 40, 60, 60)];
    _headIcon.clipsToBounds = YES;
    _headIcon.layer.cornerRadius = 30;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:[PublicManager sharedManager].userModel.avatar] placeholderImage:[UIImage imageNamed:@"myblue"]];
    _headIcon.userInteractionEnabled = YES;
    _imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    [_headIcon addGestureRecognizer:tap];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CWIDTH/2-100, CGRectGetMaxY(_headIcon.frame), 200, 30)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [_imageView addSubview:_headIcon];
    [_imageView addSubview:_nameLabel];
    [_imageView bringSubviewToFront:_headIcon];
    [self updateUserInfo];
//    [self.view bringSubviewToFront:_nameLabel];
//    [self.view bringSubviewToFront:_headIcon];
    
}

- (void)imageClicked:(UITapGestureRecognizer *)tap {
    if ([PublicManager sharedManager].userModel.token==nil) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
        return;
    }
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *picController = [[UIImagePickerController alloc] init];
        picController.delegate = self;
        picController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picController animated:YES completion:nil];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TipView showActivityIndicator];
        UIImagePickerController *picController = [[UIImagePickerController alloc] init];
        picController.sourceType = UIImagePickerControllerSourceTypeCamera;
        picController.delegate = self;
        [self presentViewController:picController animated:YES completion:^{
            [TipView hideActivityIndicator];
        }];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertView addAction:action1];
    [alertView addAction:action2];
    [alertView addAction:action3];
    [self presentViewController:alertView animated:YES completion:nil];
}



- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *origImage = info[UIImagePickerControllerOriginalImage];
    UIImage *image = [self scaleToSize:origImage size:CGSizeMake(100, 100)];
    _headIcon.image = origImage;
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否上传头像" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updaloadHeadIcon:image success:^{
            
        }];
    }];
    UIAlertAction *action2= [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertView addAction:action1];
    [alertView addAction:action2];
    [self presentViewController:alertView animated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo {
//    
//}

- (void)updaloadHeadIcon:(UIImage *)icon success:(void(^)(void))success{
    NSData *imageDate = UIImagePNGRepresentation(icon);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [TipView showTipViewWithText:@"上传中..." superView:nil];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@" token %@", [PublicManager sharedManager].userModel.token[@"apikey"]] forHTTPHeaderField:@"Authorization"];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[PublicManager sharedManager].userModel.token[@"apikey"] forKey:@"Authorization"];
   // NSDictionary *dict = @{@"Authorization":[PublicManager sharedManager].userModel.token[@"apikey"]};
    [manager POST:CINFO_HEADICON_UPLOAD parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:imageDate name:@"upload" fileName:@"photo.png" mimeType:@"multipart/form-data"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [PublicManager sharedManager].userModel.avatar = [result valueForKey:@"fullUrl"];
        NSLog(@"result:%@",result);
        [TipView showTipViewWithText:@"上传成功" superView:self.view];
        [self updateUserInfo];
        success();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        [TipView showTipViewWithText:@"上传失败(图片过大)" superView:self.view];
    }];
}

- (void)updateUserInfo {
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:[PublicManager sharedManager].userModel.avatar] placeholderImage:[UIImage imageNamed:@"myblue"]];
    if ([PublicManager sharedManager].userModel.username == nil) {
        _nameLabel.text = @"未登录";
    }else {
        _nameLabel.text = [PublicManager sharedManager].userModel.username;
    }

}

- (IBAction)collectAction:(id)sender {
    if ([PublicManager sharedManager].userModel.token) {
        MyCollectionViewController *mvmc = [[MyCollectionViewController alloc] init];
        [self presentViewController:mvmc animated:YES completion:nil];
    }else {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
}
- (IBAction)conmentAction:(id)sender {
    
    if ([PublicManager sharedManager].userModel.token) {
        ComentViewController *cvc = [[ComentViewController alloc] init];
        cvc.modalPresentationStyle = UIModalPresentationPopover;
        [self presentViewController:cvc animated:YES completion:nil];
    }else {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateUserInfo];
    [WYMCachesManager cachesSizeWithGetSizeBlock:^(unsigned long long cacheFileSize) {
        _cacheSize.text = [NSString stringWithFormat:@"%.2llu",cacheFileSize];
    }];
}

- (instancetype)init {
    if (self = [super init]) {
        UIStoryboard *storyBoard  = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"settingID"];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [WYMCachesManager cleanWithCompeleteBlock:^{
                [WYMCachesManager cachesSizeWithGetSizeBlock:^(unsigned long long cacheFileSize) {
                    _cacheSize.text = [NSString stringWithFormat:@"%.2llu",cacheFileSize];
                }];
            }];
        }
        if (indexPath.row == 3) {
            [PublicManager sharedManager].userModel = nil;
            [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"userinfo"];
            [self updateUserInfo];
        }
    }
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
 
    // Configure the cell...
    
    return cell;
}
*/


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
