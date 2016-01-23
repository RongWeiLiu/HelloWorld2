//
//  WYMCachesManager.h
//  ISMovie
//
//  Created by qianfeng on 15/12/5.
//  Copyright © 2015年 yuming. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^CleanCompeleteBlock)(void);
typedef void(^GetCachesFileSizeBlock)(unsigned long long cacheFileSize);
@interface WYMCachesManager : NSObject

+ (void)cachesSizeWithGetSizeBlock:(GetCachesFileSizeBlock)cacheFileSizeBlock;
+ (void)cleanWithCompeleteBlock:(CleanCompeleteBlock)cleanCompeleteBlock;

@end
