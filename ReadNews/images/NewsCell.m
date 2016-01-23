//
//  NewsCell.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "NewsCell.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
@interface NewsCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTime;
@property (weak, nonatomic) IBOutlet UIImageView *pcitureView;

@end
@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil][0];
    }
    return self;
}

- (void)updateCell:(ResultModel *)nModel {
    [self.pcitureView sd_setImageWithURL:[NSURL URLWithString:nModel.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage.jpg"]];
    self.titleLabel.text = nModel.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[nModel.createdAt doubleValue]];
    NSString *str = [formatter stringFromDate:time];
    _updateTime.text = str;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
