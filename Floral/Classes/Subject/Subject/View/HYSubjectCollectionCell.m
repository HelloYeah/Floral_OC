//
//  HYSubjectCollectionCell.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYSubjectCollectionCell.h"
#import "HYArtcleModel.h"
#import "HYCategoryModel.h"
#import "UIImageView+WebCache.h"


#define kBottomHeight 60 * kScreenWidthRatio


@interface HYSubjectCollectionCell ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *readBtn;
@property (nonatomic,strong) UILabel *categoryLabel;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation HYSubjectCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.categoryLabel];
        [self addSubview:self.readBtn];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setArtcleModel:(HYArtcleModel *)artcleModel {
    
    _artcleModel = artcleModel;
    
    NSURL *URL = [NSURL URLWithString:artcleModel.smallIcon];
    [_imageView sd_setImageWithURL:URL  placeholderImage:[UIImage imageNamed:@"placehodler" ]];
    [_readBtn setTitle:kIntegerToStr(artcleModel.read) forState:UIControlStateNormal];
    [_readBtn sizeToFit];
    _readBtn.width = _readBtn.width + 8;
    _readBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8);
    _titleLabel.text = artcleModel.title;
    _categoryLabel.text = [NSString stringWithFormat:@"#%@",artcleModel.category.name];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _imageView.frame = self.bounds;
    _imageView.height = self.height - kBottomHeight;
    
    CGFloat margin = (kBottomHeight - kFont(12).lineHeight - kFont(15).lineHeight) / 3.0;
    
    _titleLabel.frame = CGRectMake(10, _imageView.bottom + margin, self.width - 20, kFont(15).lineHeight);
    _categoryLabel.frame = CGRectMake(10, _titleLabel.bottom + margin, self.width * 0.45, kFont(12).lineHeight);
    
    _readBtn.left = self.width - margin - _readBtn.width;
    _readBtn.top = _titleLabel.bottom + margin;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = kFont(15);
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}

- (UILabel *)categoryLabel {
    
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.font = kFont(12);
        _categoryLabel.textColor = Color(128, 128, 128);
    }
    return _categoryLabel;
}

- (UIButton *)readBtn {
    
    if (!_readBtn) {
        _readBtn = [[UIButton alloc] init];
        [_readBtn setImage:[UIImage imageNamed:@"hp_count"] forState:UIControlStateNormal];
        _readBtn.titleLabel.font = kFont(12);
        [_readBtn setTitleColor:Color(128, 128, 128) forState:UIControlStateNormal];
    }
    return _readBtn;
}

@end
