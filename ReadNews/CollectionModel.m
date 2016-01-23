//
//  CollectionModel.m
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "CollectionModel.h"

@implementation CollectionModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end



@implementation PostModel

@synthesize id = _id;

@end

@implementation CPaginatorModle
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end

@implementation CResultModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}


@end

@implementation CUSerModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end





