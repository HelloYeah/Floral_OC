//
//  SKUserInfoHeaderView.m
//  Sinfo
//
//  Created by Sekorm on 16/4/8.
//  Copyright © 2016年 yeliang. All rights reserved.
//

#import "HYProfileHeaderView.h"
#import "UIView+Frame.h"

#define SKUserInfoHeaderImageWidth (60 * kScreenWidthRatio)
#define SKUserInfoVipImageWidth (60 * kScreenWidthRatio)
#define SKUserInfoVipImageHeight (25 * kScreenWidthRatio)
#define SKUserInfoNameAndCompanyHeight (25 * kScreenWidthRatio)
static const NSInteger SKUserInfoSpace = 10;
@interface HYProfileHeaderView ()

/** 透明边框 */
@property (nonatomic, strong) UIView *HeaderBorderView;

/** 背景视图 */
@property (nonatomic, strong ) UIImageView *bgImgView;

/** vip标志图片 */
@property (nonatomic, strong) UIImageView *vipImgView;

/** 头像 */
@property (nonatomic, strong) UIImageView *headerImgView;
/** 名称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 公司 */
@property (nonatomic, strong) UILabel *companyLabel;

@end

@implementation HYProfileHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
        [self setUserInfoData];
    }
    return self;
}

#pragma mark  -  初始化设置

- (void)setUpSubviews
{
    self.backgroundColor = Color(250, 250, 250);
    self.bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.clipsToBounds = YES;
    self.bgImgView.userInteractionEnabled = YES;
    [self addSubview:self.bgImgView];
    
    self.HeaderBorderView = [[UIView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoHeaderImageWidth)/2 - SKUserInfoSpace / 2,
                                                                    (self.height - SKUserInfoHeaderImageWidth)/2 -SKUserInfoSpace / 2,
                                                                    SKUserInfoHeaderImageWidth + SKUserInfoSpace,
                                                                    SKUserInfoHeaderImageWidth + SKUserInfoSpace)];
    self.HeaderBorderView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.3];
    self.HeaderBorderView.layer.cornerRadius = SKUserInfoHeaderImageWidth / 2 + SKUserInfoSpace / 2;
    self.HeaderBorderView.layer.masksToBounds = YES;
    [self addSubview:self.HeaderBorderView];
    self.headerImgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoHeaderImageWidth)/2,
                                                                      (self.height - SKUserInfoHeaderImageWidth)/2,
                                                                      SKUserInfoHeaderImageWidth,
                                                                      SKUserInfoHeaderImageWidth)];
    self.headerImgView.layer.cornerRadius = SKUserInfoHeaderImageWidth / 2;
    self.headerImgView.layer.masksToBounds = YES;
    [self addSubview:self.headerImgView];
    self.vipImgView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - SKUserInfoVipImageWidth)/2,
                                                                   self.headerImgView.top - SKUserInfoVipImageHeight,
                                                                   SKUserInfoVipImageWidth,
                                                                   SKUserInfoVipImageHeight)];
    [self addSubview:self.vipImgView];
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(SKUserInfoSpace,
                                                              self.headerImgView.bottom + SKUserInfoSpace,
                                                              kScreenWidth - 2 * SKUserInfoSpace,
                                                              SKUserInfoNameAndCompanyHeight)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = kFont(15);
    self.nameLabel.textColor = Color(120, 120, 120);
    [self addSubview:self.nameLabel];
    self.companyLabel = [[UILabel alloc]initWithFrame:CGRectMake(SKUserInfoSpace,
                                                                 self.nameLabel.bottom,
                                                                 kScreenWidth - 2 * SKUserInfoSpace,
                                                                 SKUserInfoNameAndCompanyHeight)];
    self.companyLabel.textAlignment = NSTextAlignmentCenter;
    self.companyLabel.font = kFont(12);
    self.companyLabel.textColor = Color(200, 200, 200);
    [self addSubview:self.companyLabel];
    
    self.nameLabel.backgroundColor = [UIColor clearColor];
    self.headerImgView.userInteractionEnabled = YES;
    [self.headerImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
    self.nameLabel.userInteractionEnabled = YES;
    [self.nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
    self.companyLabel.userInteractionEnabled = YES;
    [self.companyLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(checkUserInfomation)]];
    
}

/**
 *  设置用户信息
 */
- (void)setUserInfoData{

    self.companyLabel.text = @"这家伙很懒什么都没留下";
    self.nameLabel.text = @"匿名用户";
    self.vipImgView.image = [UIImage imageNamed:@"user_vip_crown"];
    self.headerImgView.image = [UIImage imageNamed:@"LOGO_85x85_"];
    
}

#pragma mark - 监听事件
- (void)checkUserInfomation{
    if (self.checkUserInfomationBlock) {
        self.checkUserInfomationBlock();
    }
}



@end
