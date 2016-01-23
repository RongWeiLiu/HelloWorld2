//
//  NetWorkManager.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkManager : NSObject

+ (void)requestUrl:(NSString *)url success:(void(^)(id))success failure:(void(^)(void))failure model:(id)model;

@end
