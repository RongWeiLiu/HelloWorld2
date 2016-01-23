//
//  MyCommentCell.h
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@protocol MyCommentCellDelegate <NSObject>

- (void)gotoArticleDetail:(NSString *)articleUrl articleID:(NSString *)articleID;

@end
@interface MyCommentCell : UITableViewCell

- (void)updateCell:(CommentsModel *)model;

@property (nonatomic,weak) id<MyCommentCellDelegate> delegate;

@end
