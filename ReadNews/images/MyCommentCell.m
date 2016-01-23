//
//  MyCommentCell.m
//  ReadNews
//
//  Created by qianfeng on 15/12/21.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "MyCommentCell.h"
#import "UIImageView+WebCache.h"

@interface MyCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *originalArticle;
@property (nonatomic,strong) CommentsModel *cModel;

@end
@implementation MyCommentCell

- (void)updateCell:(CommentsModel *)model {
    _cModel = model;
    [_userIcon sd_setImageWithURL:[NSURL URLWithString:[PublicManager sharedManager].userModel.avatar] placeholderImage:[UIImage imageNamed:@""]];
    _userName.text = [PublicManager sharedManager].userModel.username;
    _originalArticle.text = model.article.title;
    _content.text = model.content;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[model.createdAt doubleValue]];
    NSString *str = [formatter stringFromDate:time];
    _timeLabel.text = str;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MyCommentCell" owner:nil options:nil][0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAction)];
        _originalArticle.userInteractionEnabled = YES;
        [_originalArticle addGestureRecognizer:tap];
        _userIcon.clipsToBounds = YES;
        _userIcon.layer.cornerRadius = 18;
    }
    return self;
}

- (void)clickedAction {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(gotoArticleDetail:articleID:)]) {
        [self.delegate gotoArticleDetail:_cModel.article.permalink articleID:_cModel.article.id];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        return;
    }
    // Configure the view for the selected state
}

@end
