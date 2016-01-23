//
//  UserModel.m
//  ReadNews
//
//  Created by qianfeng on 15/12/18.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "UserModel.h"


//@property (copy ,nonatomic)NSString *avatar;
//@property (copy ,nonatomic)NSString *email;
//@property (copy ,nonatomic)NSString *emailStatus;
//@property (copy ,nonatomic)NSString *id;
//@property (strong ,nonatomic)NSArray *roles;
//@property (copy ,nonatomic)NSString *screenName;
//@property (copy ,nonatomic)NSString *status;
//@property (copy ,nonatomic)NSString *username;
//@property (nonatomic) NSDictionary *token;

@interface UserModel ()

@end
@implementation UserModel
@synthesize id = _id;


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        [aDecoder setValue:_username forKey:@"username"];
//    }
//}
//
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    aCoder valueForKey:@""
//}

@end


@implementation TokenModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@synthesize id = _id;

@end