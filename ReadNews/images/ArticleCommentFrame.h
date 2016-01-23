//
//  ArticleCommentFrame.h
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OthersCommentModel.h"

@interface ArticleCommentFrame : NSObject

@property (nonatomic,strong) OthersCommentsDetailModel *acMocel;

@property (nonatomic) CGRect iconFrame;
@property (nonatomic) CGRect userNameFrame;
@property (nonatomic) CGRect contentFrame;
@property (nonatomic) CGRect updateTimeFrame;
@property (nonatomic,assign) CGFloat rowHeight;

+ (NSMutableArray *)frameListFromModelList:(NSArray *)modelList;

@end
