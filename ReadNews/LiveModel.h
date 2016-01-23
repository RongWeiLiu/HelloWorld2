//
//  LiveModel.h
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "JSONModel.h"

@interface LiveModel : JSONModel

@property (nonatomic,copy) NSString *nid;
@property (nonatomic,copy) NSString *node_title;
@property (nonatomic,copy) NSString *node_created;
@property (nonatomic,copy) NSString *node_content;
@property (nonatomic,copy) NSString *node_icon;
@property (nonatomic,copy) NSString *node_color;
@property (nonatomic,copy) NSString *node_format;

@end
