//
//  PublicManager.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "PublicManager.h"
#import "NewsPageModel.h"
//设置主题
@implementation PublicManager

+ (PublicManager *)sharedManager {
    static PublicManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PublicManager alloc] init];
        manager.logined = NO;
    });
    return manager;
}

//- (instancetype)init {
//    if (self = [super init]) {
//        
//////        _allPagesAry = [[NSMutableArray alloc] init];
////        if (![[NSUserDefaults standardUserDefaults] valueForKey:@"newsPagesAry"]) {
////            
////            [[NSUserDefaults standardUserDefaults] setValue:self.allPagesAry forKey:@"newsPagesAry"];
////            
////        }
////       _newsPagesAry = [[NSMutableArray alloc] init];
////       [_newsPagesAry setArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"newsPagesAry"]];
//    }
//    return self;
//}

- (UserModel *)userModel {
    if (_userModel == nil) {
        _userModel = [[UserModel alloc] init];
    }
    return _userModel;
}

- (NSMutableArray *)allPagesAry {
    if (_allPagesAry == nil) {
        _allPagesAry = [[NSMutableArray alloc] init];
      NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"newsPages" ofType:@"plist"];
        NSArray *titles = [NSArray arrayWithContentsOfFile:filePath];
        for (NSDictionary *dict in titles) {
            NewsPageModel *pModel = [[NewsPageModel alloc] init];
            [pModel setValuesForKeysWithDictionary:dict];
            [_allPagesAry addObject:pModel];
        }
        
    }
    return _allPagesAry;
}

@end
