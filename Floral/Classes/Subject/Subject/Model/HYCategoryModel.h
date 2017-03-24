//
//  HYCategoryModel.h
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYCategoryModel : NSObject
// 专题创建时间
//var createDate : String?
@property (nonatomic,copy) NSString *createDate;
// 专题类型ID
//var id : String?
@property (nonatomic,copy) NSString *ID;
// 专题类型名称
//var name : String?
@property (nonatomic,copy) NSString *name;
// 专题序号
//var order : Int?
@property (nonatomic,assign) NSInteger  order;

@end
