//
//  NetworkTool.h
//  MiaowShow
//
//  Created by  on 16/6/14.
//  Copyright © 2016年 . All rights reserved.
//

#import "AFNetworking.h"

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWIFI // WIFI
};

@interface HYNetworkTool : AFHTTPSessionManager
+ (instancetype)shareTool;

// 判断网络类型
+ (NetworkStates)getNetworkStates;
@end
