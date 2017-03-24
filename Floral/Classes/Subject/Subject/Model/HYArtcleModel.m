
//
//  HYArtcleModel.m
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYArtcleModel.h"

@implementation HYArtcleModel
+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{
             @"ID":@"id",
             };
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
