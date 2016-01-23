//
//  NewsDetailViewController.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController

@property (nonatomic,copy) NSString *requestUrl;
@property (nonatomic,copy) NSString *detailID;
@property (nonatomic,copy) NSString *kind;
@property (nonatomic,copy) UIImage *image;

@end
