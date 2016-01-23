//
//  ArticleCommentFrame.m
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "ArticleCommentFrame.h"

@implementation ArticleCommentFrame

- (void)setAcMocel:(OthersCommentsDetailModel *)acMocel {
    _acMocel = acMocel;
    CGFloat gap = 10;
    CGFloat SCREENW = [UIScreen mainScreen].bounds.size.width;
    _iconFrame = CGRectMake(gap, gap, 40, 40);
    _userNameFrame = CGRectMake(CGRectGetMaxX(_iconFrame)+gap, gap, 200, 20);
    CGSize contentSize = [_acMocel.content boundingRectWithSize:CGSizeMake(SCREENW-2*gap, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    _contentFrame = CGRectMake(gap, CGRectGetMaxY(_iconFrame)+gap, contentSize.width, contentSize.height);
    _updateTimeFrame = CGRectMake(gap, CGRectGetMaxY(_contentFrame), 200, 30);
    _rowHeight = CGRectGetMaxY(_updateTimeFrame);
    
}
+ (NSMutableArray *)frameListFromModelList:(NSArray *)modelList {
    
    NSMutableArray *frameList = [[NSMutableArray alloc] init];
    for (OthersCommentsDetailModel *ocModel in modelList) {
        ArticleCommentFrame *frame = [[ArticleCommentFrame alloc] init];
        frame.acMocel = ocModel;
        [frameList addObject:frame];
    }
    return frameList;
    
}

@end
