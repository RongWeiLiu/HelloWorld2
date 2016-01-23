//
//  NewsModel.h
//  ReadNews
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 程来运. All rights reserved.
//

#import "JSONModel.h"

@protocol TagModel <NSObject>
@end
@interface TagModel : JSONModel
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *tagName;
@end


@interface USerModel : JSONModel
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *username;
@property (nonatomic,copy) NSString *screenName;
@end





@protocol ResultModel
@end
@interface ResultModel : JSONModel
@property (nonatomic,copy) NSString *id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *slug;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *codeType;
@property (nonatomic,copy) NSString *createdAt;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *summaryHtml;
@property (nonatomic,copy) NSString *commentStatus;
@property (nonatomic,copy) NSString<Optional> *sourceName;
@property (nonatomic,copy) NSString<Optional> *sourceUrl;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *commentCount;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,strong) NSArray<Optional,TagModel> *tags;
@property (nonatomic,strong) USerModel *user;
@end




@interface PaginatorModle : JSONModel
@property (nonatomic,copy) NSString *total;
@property (nonatomic,copy) NSString *previous;
@property (nonatomic,copy) NSString *next;
@property (nonatomic,copy) NSString *last;
@end

@interface NewsModel : JSONModel
@property (nonatomic,strong) PaginatorModle *paginator;
@property (nonatomic,strong) NSArray<ResultModel> *results;

@end
