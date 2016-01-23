//
//  LiveFrame.m
//  ReadNews
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LiveFrame.h"

@implementation LiveFrame

- (void)setLModel:(LiveModel *)lModel {
    
    _lModel = lModel;
    CGFloat gap = 10;
    CGFloat SCREENW = [UIScreen mainScreen].bounds.size.width;
    _updateTimeFrame = CGRectMake(gap, gap,200,30);
    CGSize contentSize = [lModel.node_content boundingRectWithSize:CGSizeMake(SCREENW-2*gap, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _contentFrame = CGRectMake(gap, CGRectGetMaxY(_updateTimeFrame),SCREENW-2*gap, contentSize.height);
    
    _rowHeight = CGRectGetMaxY(_contentFrame);
}

+ (NSMutableArray *)frameListFromModelList:(NSArray *)modelList {
    NSMutableArray *frameList = [[NSMutableArray alloc] init];
    for (LiveModel *lModel in modelList) {
        LiveFrame *frame = [[LiveFrame alloc] init];
        [frame setLModel:lModel];
        [frameList addObject:frame];
    }
    return frameList;
}

@end
