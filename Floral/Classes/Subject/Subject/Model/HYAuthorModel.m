
//
//  HYAuthorModel.m
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYAuthorModel.h"

@implementation HYAuthorModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             @"desc":@"description",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
