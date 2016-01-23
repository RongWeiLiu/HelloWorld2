//
//  LiveCell.m
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "LiveCell.h"

@interface LiveCell ()
@property ( nonatomic)  UILabel *startTime;

@property ( nonatomic)  UILabel *content;

@end
@implementation LiveCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _startTime = [[UILabel alloc] init];
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_startTime];
        [self.contentView addSubview:_content];
    }
    return self;
}

- (void)updateCell:(LiveFrame *)lFrame {
    _startTime.frame = lFrame.updateTimeFrame;
    _content.frame = lFrame.contentFrame;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *time = [NSDate dateWithTimeIntervalSince1970:[lFrame.lModel.node_created doubleValue]];
        NSString *str = [formatter stringFromDate:time];
        _startTime.text = str;
        _content.text = lFrame.lModel.node_content;
        _startTime.text = str;
        if ([lFrame.lModel.node_color isEqualToString:@"红色"]) {
            _content.textColor = [UIColor redColor];
        }else {
            _content.textColor = [UIColor blackColor];
        }
}

//- (void)updateCell:(LiveModel *)lModel {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[lModel.node_created doubleValue]];
//    NSString *str = [formatter stringFromDate:time];
//    _startTime.text = str;
//    _content.text = lModel.node_content;
//    if ([lModel.node_color isEqualToString:@"红色"]) {
//        _content.textColor = [UIColor redColor];
//    }else {
//        _content.textColor = [UIColor blackColor];
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
