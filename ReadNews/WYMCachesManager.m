//
//  WYMCachesManager.m
//  ISMovie
//
//  Created by qianfeng on 15/12/5.
//  Copyright © 2015年 yuming. All rights reserved.
//

#import "WYMCachesManager.h"
#import "SDImageCache.h"
@implementation WYMCachesManager {
    GetCachesFileSizeBlock _getCachesFileSizeBlock;
    CleanCompeleteBlock _cleanCompeleteBlock;
}

+ (void)cachesSizeWithGetSizeBlock:(GetCachesFileSizeBlock)cacheFileSizeBlock {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    unsigned long long fileSize = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = paths[0];
    NSArray *fileNameArry = [fileManager subpathsAtPath:cachesPath];
    for (NSString *fileName in fileNameArry) {
        NSString *fileFullName = [cachesPath stringByAppendingPathComponent:fileName];
        fileSize += [fileManager attributesOfItemAtPath:fileFullName error:nil].fileSize/1024.0/1024.0;
    }
    fileSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    cacheFileSizeBlock(fileSize);
}
+ (void)cleanWithCompeleteBlock:(CleanCompeleteBlock)cleanCompeleteBlock {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = paths[0];
    NSArray *fileNameArry = [fileManager subpathsAtPath:cachesPath];
    for (NSString *fileName in fileNameArry) {
        NSString *fileFullName = [cachesPath stringByAppendingPathComponent:fileName];
        [fileManager removeItemAtPath:fileFullName error:nil];
    }
    [[SDImageCache sharedImageCache] cleanDisk];
    cleanCompeleteBlock();
}

@end
