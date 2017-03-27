
//
//  HYCollectionTopView.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYCollectionTopView.h"
#import "HYSysCategoryServletModel.h"
#import "UIImageView+WebCache.h"

#define kTopContentViewHeight 240 * kScreenWidthRatio
#define kMidContentViewHeight 160 * kScreenWidthRatio
#define kBotContentViewHeight 300 * kScreenWidthRatio
#define kSysCategoryServletHeight 80 * kScreenWidthRatio
#define kWallpaperWidth kScreenWidth * 0.3
#define kTitleLabelHeight 50 * kScreenWidthRatio
#define kLeftMargin 20 * kScreenWidthRatio

@interface HYCollectionTopView ()
@property (nonatomic,strong) UIView *topContentView;
@property (nonatomic,strong) UIView *midContentView;
@property (nonatomic,strong) UIView *botContentView;
@property (nonatomic,strong) UIScrollView *topScrollView;
@property (nonatomic,strong) UIScrollView *midScrollView;
@property (nonatomic,strong) UIScrollView *botScrollView;

@end

@implementation HYCollectionTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topContentView];
        [self addSubview:self.midContentView];
        [self addSubview:self.botContentView];
    }
    return self;
}

- (void)setWallpapers:(NSArray *)wallpapers {
    
    _wallpapers = wallpapers;
    CGFloat x = kLeftMargin * 0.5;
    CGFloat y = kLeftMargin * 0.5;
    CGFloat width = kWallpaperWidth;
    CGFloat height = kBotContentViewHeight - kTitleLabelHeight - y - kLeftMargin;
    for (int i = 0; i < wallpapers.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i * (width + kLeftMargin * 0.5), y, width, height)];
        [_botScrollView addSubview:imageView];
        NSURL *URL = [NSURL URLWithString:wallpapers[i]];
        [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        if (i == wallpapers.count - 1) {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"全部壁纸 >";
            [label sizeToFit];
            label.center = CGPointMake(imageView.width * 0.5, imageView.height * 0.5);
            label.font = kBoldFont(12);
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [imageView addSubview:label];
        }
    }
    _botScrollView.contentSize = CGSizeMake(wallpapers.count * (width + kLeftMargin * 0.5) + kLeftMargin * 0.5, 0);
}

- (void)setSysCategoryServlets:(NSArray *)sysCategoryServlets {
    
    _sysCategoryServlets = sysCategoryServlets;
    
    [self setMidContentViewWithData:sysCategoryServlets];
    [self setTopContentViewWithData:sysCategoryServlets];
}
- (void)setTopContentViewWithData:(NSArray *)sysCategoryServlets {
    
    CGFloat x = kLeftMargin;
    CGFloat y = 0;
    CGFloat width = 0.8 * kScreenWidth;
    CGFloat height = kTopContentViewHeight * 0.7;
    for (int i = 0; i < sysCategoryServlets.count; i++) {
        
        HYSysCategoryServletModel *model = sysCategoryServlets[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i * (width + kLeftMargin), y, width, height)];
        [_topScrollView addSubview:imageView];
        NSURL *URL = [NSURL URLWithString:model.img];
        [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = model.name;
        [label sizeToFit];
        label.left = imageView.left + kLeftMargin;
        label.top = imageView.bottom + kLeftMargin;
        label.font = kBoldFont(17);
        label.textColor = Color(50, 50, 50);
        [_topScrollView addSubview:label];
    }
    _topScrollView.contentSize = CGSizeMake(sysCategoryServlets.count * (width + kLeftMargin) + kLeftMargin, 0);

}


- (void)setMidContentViewWithData:(NSArray *)sysCategoryServlets {
    
    CGFloat x = kLeftMargin;
    CGFloat y = (kMidContentViewHeight - kTitleLabelHeight- kSysCategoryServletHeight) * 0.3;
    CGFloat width = kSysCategoryServletHeight;
    CGFloat height = kSysCategoryServletHeight;
    for (int i = 0; i < sysCategoryServlets.count; i++) {
        
        HYSysCategoryServletModel *model = sysCategoryServlets[i];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x + i * (width + kLeftMargin), y, width, height)];
        [_midScrollView addSubview:imageView];
        imageView.layer.cornerRadius = 4 * kScreenWidthRatio;
        imageView.layer.masksToBounds = YES;
        NSURL *URL = [NSURL URLWithString:model.img];
        [imageView sd_setImageWithURL:URL placeholderImage:[UIImage imageNamed:@"placeholder"]];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = model.name;
        [label sizeToFit];
        label.center = CGPointMake(imageView.width * 0.5, imageView.height * 0.5);
        label.font = kBoldFont(12);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:label];
    }
    _midScrollView.contentSize = CGSizeMake(sysCategoryServlets.count * (width + kLeftMargin) + kLeftMargin, 0);
}

- (UIView *)topContentView {
    
    if (!_topContentView) {
        _topContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopContentViewHeight)];
        [_topContentView addSubview:self.topScrollView];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"";
        [_topContentView addSubview:titleLabel];
        
        UIView *separateLine = [self separateLine];
        [_topContentView addSubview:separateLine];
        separateLine.top = _topContentView.height - kLineHeight;
    }
    return _topContentView;
}

- (UIView *)midContentView {
    
    if (!_midContentView) {
        _midContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopContentViewHeight, kScreenWidth, kMidContentViewHeight)];
        [_midContentView addSubview:self.midScrollView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"专题分类";
        titleLabel.font = kBoldFont(17);
        [titleLabel sizeToFit];
        titleLabel.left = kLeftMargin;
        titleLabel.centerY = kTitleLabelHeight * 0.5;
        [_midContentView addSubview:titleLabel];
        
        UIView *separateLine = [self separateLine];
        [_midContentView addSubview:separateLine];
        separateLine.top = _midContentView.height - kLineHeight;
    }
    return _midContentView;
}

- (UIView *)botContentView {
    
    if (!_botContentView) {
        _botContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopContentViewHeight + kMidContentViewHeight, kScreenWidth, kBotContentViewHeight)];
        [_botContentView addSubview:self.botScrollView];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"壁纸";
        titleLabel.font = kBoldFont(17);
        [titleLabel sizeToFit];
        titleLabel.left = kLeftMargin;
        titleLabel.centerY = kTitleLabelHeight * 0.5;
        [_botContentView addSubview:titleLabel];
        
        UIView *separateLine = [self separateLine];
        [_botContentView addSubview:separateLine];
        separateLine.top = _botContentView.height - kLineHeight;
    }
    return _botContentView;
}

- (UIView *)separateLine {
    
    UIView *separateLine = [[UIView alloc] init];
    separateLine.height = kLineHeight;
    separateLine.width = kScreenWidth;
    separateLine.backgroundColor = Color(180, 180, 180);
    return separateLine;
}

- (UIScrollView *)topScrollView {
    
    if (!_topScrollView){
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopContentViewHeight)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _topScrollView;
}

- (UIScrollView *)midScrollView {
    
    if (!_midScrollView){
        _midScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTitleLabelHeight, kScreenWidth, kMidContentViewHeight - kTitleLabelHeight)];
        _midScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _midScrollView;
}

- (UIScrollView *)botScrollView {
    
    if (!_botScrollView){
        _botScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTitleLabelHeight, kScreenWidth, kBotContentViewHeight - kTitleLabelHeight)];
        _botScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _botScrollView;
}



@end
