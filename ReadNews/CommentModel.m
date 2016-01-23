//
//  CommentModel.m
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "CommentModel.h"


//CTagModel
//CUserModel
//ArticleModel
//CommentsModel
@implementation CommentModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation CTagModel

@synthesize id = _id;

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
@implementation CUserModel

@synthesize id = _id;
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation ArticleModel

@synthesize id = _id;
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation CommentsModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

