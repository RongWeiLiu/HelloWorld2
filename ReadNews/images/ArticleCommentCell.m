//
//  ArticleCommentCell.m
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "ArticleCommentCell.h"
#import "UIImageView+WebCache.h"
#import "ArticleCommentFrame.h"
@interface ArticleCommentCell ()

@property (nonatomic) UIImageView *IconView;
@property (nonatomic) UILabel *userNameView;
@property (nonatomic) UILabel *content;
@property (nonatomic) UILabel *updateTime;

@end

@implementation ArticleCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _IconView = [[UIImageView alloc] init];
        _IconView.clipsToBounds = YES;
        _IconView.layer.cornerRadius = 20;
        _userNameView = [[UILabel alloc] init];
        _content = [[UILabel alloc] init];
        _content.numberOfLines = 0;
        _content.font = [UIFont systemFontOfSize:15];
        _updateTime = [[UILabel alloc] init];
        _updateTime.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_IconView];
        [self.contentView addSubview:_userNameView];
        [self.contentView addSubview:_content];
        [self.contentView addSubview:_updateTime];
        
    }
    return self;
}

- (void)updateCell:(ArticleCommentFrame *)frame {
    _IconView.frame = frame.iconFrame;
    _userNameView.frame = frame.userNameFrame;
    _content.frame = frame.contentFrame;
    _updateTime.frame = frame.updateTimeFrame;
    [_IconView sd_setImageWithURL:[NSURL URLWithString:frame.acMocel.user.avatar] placeholderImage:[UIImage imageNamed:@"myblue"]];
    _userNameView.text = frame.acMocel.user.name;
    _content.text = frame.acMocel.content;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[frame.acMocel.createdAt doubleValue]];
    NSString *str = [formatter stringFromDate:time];
    _updateTime.text = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        return;
    }
    // Configure the view for the selected state
}

@end
