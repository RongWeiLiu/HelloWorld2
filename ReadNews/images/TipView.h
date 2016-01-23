//
//  TipView.h
//  ISMovie
//
//  Created by qianfeng on 15/12/13.
//  Copyright © 2015年 yuming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipView : UIView

+ (void)showTipViewWithText:(NSString *)text superView:(UIView *)superView;

+ (void)showActivityIndicator;

+ (void)hideActivityIndicator;

@end
