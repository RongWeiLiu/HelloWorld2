//
//  CommentModel.h
//  ReadNews
//
//  Created by qianfeng on 15/12/20.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "JSONModel.h"


//comments":[
//{
//    "id":"574636",
//    "parent":null,
//    "content":"是啊",
//    "isExcellent":0,
//    "isHighlight":false,
//    "upVotes":"0",
//    "downVotes":"0",
//    "createdAt":"1450574144",
//    "user":{
//        "id":"871290",
//        "name":"haoyunlai1992",
//        "avatar":"http://avatar.cdn.wallstcn.com/default",
//        "tags":null
//    },
//    "article":{
//        "channel":"news",
//        "title":"高盛：养孩子太贵了",
//        "permalink":"http://wallstreetcn.com/node/227657",
//        "threadId":"198003",
//        "id":"227657",
//        "commentStatus":"open"
//    }



@protocol CTagModel <NSObject>
@end
@interface CTagModel : JSONModel
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *tagName;
@end

@interface CUserModel : JSONModel
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,strong) NSArray<CTagModel> *tags;
@end


@interface ArticleModel : JSONModel

@property (nonatomic,copy) NSString *channel;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *permalink;
@property (nonatomic,copy) NSString *threadId;
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *commentStatus;

@end



@protocol CommentsModel <NSObject>



@end

@interface CommentsModel : JSONModel

@property (nonatomic,copy) NSString *parent;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *isExcellent;
@property (nonatomic,assign) BOOL isHighlight;
@property (nonatomic,copy) NSString *upVotes;
@property (nonatomic,copy) NSString *downVotes;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,strong) CUserModel *user;
@property (nonatomic,strong) ArticleModel *article;

@end


@interface CommentModel : JSONModel

@property (nonatomic,strong) NSArray<CommentsModel> *comments;


@end
