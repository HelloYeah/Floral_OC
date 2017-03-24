//
//  HYArtcleModel.h
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYCategoryModel.h"
#import "HYAuthorModel.h"

@interface HYArtcleModel : NSObject

// 描述创建时间, 比如昨天, 今天, 去年等
@property (nonatomic,copy) NSString *createDateDesc;
// 摘要
@property (nonatomic,copy) NSString *desc;
// 评论数
@property (nonatomic,assign) NSInteger fnCommentNum;
// 点赞数
@property (nonatomic,assign) NSInteger favo;
// 文章ID

@property (nonatomic,assign) NSInteger ID;
// 序号
@property (nonatomic,assign) NSInteger order;
// 文章的H5地址
@property (nonatomic,copy) NSString *pageUrl;
// 阅读数
@property (nonatomic,assign) NSInteger read;
// 分享数
@property (nonatomic,assign) NSInteger share;
// 用户分享的URL
@property (nonatomic,copy) NSString *sharePageUrl;
// 缩略图
@property (nonatomic,copy) NSString *smallIcon;
// 文章标题
@property (nonatomic,copy) NSString *title;
// 是否是首页的, 如果是首页不显示时间
@property (nonatomic,assign) NSInteger isNotHomeList;
// 作者
//var author : Author?
@property (nonatomic,strong) HYAuthorModel *author;
// 所属分类
//var category : Category?
@property (nonatomic,strong) HYCategoryModel *category;
@end
