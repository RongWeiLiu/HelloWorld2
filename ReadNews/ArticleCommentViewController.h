//
//  ArticleCommentViewController.h
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^CallBack)(void);
@interface ArticleCommentViewController : UIViewController
@property (nonatomic,copy) NSString *detailID;
@property (nonatomic,copy) NSString *threadID;

@property (nonatomic,copy) CallBack myCallBack;

//- (instancetype)initWithCallBack:(CallBack)myCallBack;
@end
