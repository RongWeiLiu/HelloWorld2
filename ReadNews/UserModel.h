//
//  UserModel.h
//  ReadNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JSONModel.h"
@interface TokenModel : JSONModel

@property (nonatomic,copy) NSString *apikey;
@property (nonatomic,copy) NSString *createAt;
@property (nonatomic,copy) NSString *dailyRate;
@property (nonatomic,copy) NSString *expiredAt;
@property (nonatomic,copy) NSString *hourlyRate;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSString *minutelyRate;
@property (nonatomic,copy) NSString *refreshedAt;
@property (nonatomic,copy) NSString *userId;

@end

@interface UserModel : JSONModel
@property (copy ,nonatomic)NSString *avatar;
@property (copy ,nonatomic)NSString *email;
@property (copy ,nonatomic)NSString *emailStatus;
@property (copy ,nonatomic)NSString *id;
@property (strong ,nonatomic)NSArray *roles;
@property (copy ,nonatomic)NSString *screenName;
@property (copy ,nonatomic)NSString *status;
@property (copy ,nonatomic)NSString *username;
@property (nonatomic) NSDictionary *token;
//@property (strong ,nonatomic)TokenModel *token;
@end


