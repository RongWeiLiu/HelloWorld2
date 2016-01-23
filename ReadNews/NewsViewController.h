//
//  NewsViewController.h
//  ReadNews
//
//  Created by qianfeng on 15/12/16.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewsDelegate <NSObject>

- (void)changIndex:(NSInteger)index;

@end
@interface NewsViewController : UIViewController

@property (nonatomic) id<NewsDelegate> delegate;

@end
