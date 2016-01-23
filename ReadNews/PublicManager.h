//
//  PublicManager.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface PublicManager : NSObject

@property (nonatomic,strong) NSMutableArray *newsPagesAry;

@property (nonatomic,strong) NSMutableArray *allPagesAry;

@property (nonatomic,assign) BOOL logined;

@property (nonatomic,strong) UserModel *userModel;

+ (PublicManager *)sharedManager;

@end
