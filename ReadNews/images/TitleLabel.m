//
//  TitleLabel.m
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "TitleLabel.h"

@implementation TitleLabel

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    if (scale == 0) {
        self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
    }else {
        self.textColor = [UIColor redColor];
    }
    
}

@end
