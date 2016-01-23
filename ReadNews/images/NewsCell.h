//
//  NewsCell.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResultModel;
@interface NewsCell : UITableViewCell

- (void)updateCell:(ResultModel *)nModel;

@end
