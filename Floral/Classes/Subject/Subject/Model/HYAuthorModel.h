//
//  HYAuthorModel.h
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYAuthorModel : NSObject
// 认证类型: 专家
@property (nonatomic,strong) NSString *auth;
// 所在城市
@property (nonatomic,strong) NSString *city;
// 简介
@property (nonatomic,strong) NSString *content;
// 是否订阅
@property (nonatomic,assign) NSInteger  dingYue;
// 头像
@property (nonatomic,strong) NSString *headImg;
//var headImg : String?
//{
//    didSet{
//        if !headImg!.hasPrefix("http://") {
//            headImg = "http://static.htxq.net/" + headImg!
//        }
//    }
//}
// 用户id

@property (nonatomic,strong) NSString *ID;
// 标示: 官方认证
@property (nonatomic,strong) NSString *identity;
// 用户名
@property (nonatomic,strong) NSString *userName;
// 手机号
//var  : Int64 = 18618234090
@property (nonatomic,assign) NSInteger  mobile;
// 订阅数
//var subscibeNum : Int  = 0
@property (nonatomic,assign) NSInteger  subscibeNum;
// 认证的等级, 1是yellow, 2是个人认证
//var newAuth : Int = 0
@property (nonatomic,assign) NSInteger  newAuth;
//{
//    didSet{
//        switch newAuth {
//        case 1:
//            authImage = UIImage(named: "u_vip_yellow")
//        case 2:
//            authImage = UIImage(named: "personAuth")
//        default:
//            authImage = UIImage(named: "u_vip_blue")
//        }
//    }
//}
//var authImage : UIImage?
@property (nonatomic,strong) NSString *authImage;
// 经验值
//var experience : Int = 0
@property (nonatomic,assign) NSInteger  experience;
// 等级
//var level : Int = 1
@property (nonatomic,assign) NSInteger  level;
// 积分
//var integral : Int = 0
@property (nonatomic,assign) NSInteger  integral;


@end
