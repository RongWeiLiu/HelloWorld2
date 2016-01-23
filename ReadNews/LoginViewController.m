//
//  LoginViewController.m
//  ReadNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "EmailCheckViewController.h"

@interface LoginViewController ()<NSURLConnectionDataDelegate> {
    UIView *_loginView;
    UIView *_registerView;
    UITextField *_userName;
    UITextField *_password;
    UITextField *_email;
    UITextField *_registerUserName;
    UITextField *_registerPassword;
    NSMutableData *_resultData;
    BOOL _isLoginSatus;
  
    __weak IBOutlet UIButton *backBtn;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLoginView];
    [self createRegisterView];
    _isLoginSatus = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)closeView:(id)sender {
    if (!_isLoginSatus) {
        [UIView animateWithDuration:2.0 animations:^{
            _loginView.transform = CGAffineTransformMakeTranslation(0, 0);
            _registerView.transform = CGAffineTransformMakeTranslation(0, 700);
            _isLoginSatus = YES;
        }];
        [backBtn setImage:[UIImage imageNamed:@"kClose"] forState:UIControlStateNormal];
    }else {
        _loginView.hidden = YES;
        _registerView.hidden = YES;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (IBAction)openRegisterView:(id)sender {
    [UIView animateWithDuration:2.0 animations:^{
         _loginView.transform = CGAffineTransformMakeTranslation(0, -600);
        _registerView.transform = CGAffineTransformMakeTranslation(0, 70-1000);
        _isLoginSatus = NO;
    }];
    [backBtn setImage:[UIImage imageNamed:@"backW"] forState:UIControlStateNormal];
   
}

- (void)createLoginView {
    
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, CWIDTH, 200)];
    _userName = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CWIDTH-20, 30)];
    _userName.placeholder = @"用户名/邮箱";
    
    _password = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_userName.frame), CWIDTH-20, 30)];
    _password.placeholder = @"密码";
    _password.secureTextEntry = YES;
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_password.frame)+10, CWIDTH-40, 30)];
    loginBtn.backgroundColor = [UIColor blueColor];
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAtcion) forControlEvents:UIControlEventTouchUpInside];
    _userName.text = @"haoyunlai1992";
    _password.text = @"12345678";
    [_loginView addSubview:_userName];
    [_loginView addSubview:_password];
    [_loginView addSubview:loginBtn];
    [self.view addSubview:_loginView];
    
}

- (void)loginAtcion {
    _resultData = [[NSMutableData alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:CINFO_MORE_LOGIN]];
    NSDictionary *infoDict = @{@"identify":_userName.text,@"password":_password.text};
    //NSMutableData *infoData = [[NSMutableData alloc] init];
    NSData *infoData = [NSJSONSerialization dataWithJSONObject:infoDict options:NSJSONWritingPrettyPrinted error:nil];
    //    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:infoData];
    //    [archiver encodeObject:infoDict forKey:@"infoDict"];
    //    [archiver finishEncoding];
    [request setValue:@"application/json" forHTTPHeaderField:@"Conten_type"];
    [request setValue:[NSString stringWithFormat:@"%ld",infoData.length] forHTTPHeaderField:@"Content_type"];
    
    [request setHTTPBody:infoData];
    [request setHTTPMethod:@"POST"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];

}

- (void)createRegisterView {
    
    _registerView = [[UIView alloc] initWithFrame:CGRectMake(0, 1000, CWIDTH, 200)];
    _registerUserName = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, CWIDTH-20, 30)];
    _registerUserName.placeholder = @"用户名";
    _registerUserName.text = @"haoyunlai";
    _email = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_registerUserName.frame), CWIDTH-20, 30)];
    _email.placeholder = @"邮箱";
    _email.text = @"763823472@qq.com";
    _registerPassword = [[UITextField alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_email.frame), CWIDTH-20, 30)];
    _registerPassword.placeholder = @"密码";
    _registerPassword.text = @"12345678";
    UIButton *registerBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_registerPassword.frame)+10, CWIDTH-40, 30)];
    registerBtn.backgroundColor = [UIColor blueColor];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [_registerView addSubview:_registerUserName];
    [_registerView addSubview:_registerPassword];
    [_registerView addSubview:_email];
    [_registerView addSubview:registerBtn];
    [self.view addSubview:_registerView];
    
}


- (void)registerAction {
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content_type"];
//    NSDictionary *infoDict = @{@"username":_registerUserName.text,@"password":_registerPassword.text,@"email":_email.text};
//    NSMutableData *infoData = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:infoData];
//    [archiver encodeObject:infoDict forKey:@"infoDict"];
//    [archiver finishEncoding];
//    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%ld",[infoData length]] forHTTPHeaderField:@"Content_length"];
//   // manager.responseSerializer
//    [manager POST:CINFO_MORE_REGIST parameters:infoDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",result);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
    
    _resultData = [[NSMutableData alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:CINFO_MORE_REGIST]];
    NSDictionary *infoDict = @{@"username":_registerUserName.text,@"password":_registerPassword.text,@"email":_email.text};
    //NSMutableData *infoData = [[NSMutableData alloc] init];
    NSData *infoData = [NSJSONSerialization dataWithJSONObject:infoDict options:NSJSONWritingPrettyPrinted error:nil];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:infoData];
//    [archiver encodeObject:infoDict forKey:@"infoDict"];
//    [archiver finishEncoding];
    [request setValue:@"application/json" forHTTPHeaderField:@"Conten_type"];
    [request setValue:[NSString stringWithFormat:@"%ld",infoData.length] forHTTPHeaderField:@"Content_type"];
    
    [request setHTTPBody:infoData];
    [request setHTTPMethod:@"POST"];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_resultData appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_resultData options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@",dict);
    //NSLog(@"%@",dict[@""]);
    if (dict[@"errors"]) {
        NSString *message = dict[@"errors"][0][@"message"];
        static NSString *resultString = nil;
        if ([message isEqualToString:@"ERR_USER_USERNAME_ALREADY_TAKEN"]) {
            resultString = @"用户名被占用";
        }else if ([message isEqualToString:@"ERR_USER_EMAIL_ALREADY_TAKEN"]) {
            resultString = @"此邮箱已被注册";
        }else if ([message isEqualToString:@"ERR_USER_EMAIL_ALREADY_TAKEN"]) {
            resultString = @"用户名或密码错误";
        }else if ([message isEqualToString:@"Please input username or email"]) {
            resultString = @"请输入用户名或密码";
        }
        [TipView showTipViewWithText:resultString superView:self.view];
    }else {
        if ([dict[@"emailStatus"] isEqualToString:@"inactive"]) {
            [TipView showTipViewWithText:@"注册成功" superView:self.view];
             [[PublicManager sharedManager].userModel setValuesForKeysWithDictionary:dict];
            _userName.text = [PublicManager sharedManager].userModel.username;
            _userName.text = _registerUserName.text;
            _password.text = _registerPassword.text;
            EmailCheckViewController *ecvc = [[EmailCheckViewController alloc] init];
            [self presentViewController:ecvc animated:YES completion:^{
                [UIView animateWithDuration:2.0 animations:^{
                    _loginView.transform = CGAffineTransformMakeTranslation(0, 0);
                    _registerView.transform = CGAffineTransformMakeTranslation(0, 0);
                }];
            }];
           
            [backBtn setImage:[UIImage imageNamed:@"backW"] forState:UIControlStateNormal];
        }else {
             [[PublicManager sharedManager].userModel setValuesForKeysWithDictionary:dict];
             [TipView showTipViewWithText:@"登陆成功" superView:self.view];
            NSData *userInfo = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
            [[NSUserDefaults standardUserDefaults] setValue:userInfo forKey:@"userinfo"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
       
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init {
    if (self = [super init]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"loginID"];
        
    }
    return self;
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
