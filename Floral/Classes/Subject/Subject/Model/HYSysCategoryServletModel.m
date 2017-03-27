

//
//  HYSysCategoryServletModel.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYSysCategoryServletModel.h"

@implementation HYSysCategoryServletModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
