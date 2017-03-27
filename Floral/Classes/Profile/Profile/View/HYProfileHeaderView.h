//
//  SKUserInfoHeaderView.h
//  Sinfo
//
//  Created by Sekorm on 16/4/8.
//  Copyright © 2016年 yeliang. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface HYProfileHeaderView : UIView
@property (nonatomic,assign) BOOL updateUserInfo;
@property (nonatomic,copy) void(^checkUserInfomationBlock)();
@end
