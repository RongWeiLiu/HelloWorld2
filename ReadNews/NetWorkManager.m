//
//  NetWorkManager.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
#import "NewsModel.h"
#import "LiveModel.h"
#import "OthersCommentModel.h"
@implementation NetWorkManager

+ (void)requestUrl:(NSString *)url success:(void (^)(id))success failure:(void (^)(void))failure model:(id)model {
    __block id nModel = model;
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([model isKindOfClass:[NewsModel class]]) {
            nModel = [[NewsModel alloc] initWithData:responseObject error:nil];
        }else if ([model isKindOfClass:[NSMutableArray class]]) {
            NSArray *infoAry = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             nModel = [[NSMutableArray alloc] init];
            for (NSDictionary *dic in infoAry) {
                LiveModel *lModel = [[LiveModel alloc] initWithDictionary:dic error:nil];
                [nModel addObject:lModel];
            }
        }else if([model isKindOfClass:[OthersCommentModel class]]) {
            nModel = [[OthersCommentModel alloc] initWithData:responseObject error:nil];
        }
        success(nModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
