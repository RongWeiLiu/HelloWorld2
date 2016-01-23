//
//  LiveCell.h
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"
#import "LiveFrame.h"
@interface LiveCell : UITableViewCell

- (void)updateCell:(LiveFrame *)lFrame;

@end
