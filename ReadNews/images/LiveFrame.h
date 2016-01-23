//
//  LiveFrame.h
//  ReadNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
@interface LiveFrame : NSObject

@property (nonatomic,strong) LiveModel *lModel;

@property (nonatomic,assign) CGRect updateTimeFrame;

@property (nonatomic,assign) CGRect contentFrame;

@property (nonatomic,assign) CGFloat rowHeight;


+ (NSMutableArray *)frameListFromModelList:(NSArray *)modelList;

@end
