//
//  HYCollectionSectionHeader.m
//  Floral
//
//  Created by Sekorm on 2017/3/24.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYCollectionSectionHeader.h"

#define kMargin 12.5 * kScreenWidthRatio

@implementation HYCollectionSectionHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        [self addSubview:self.iconView];
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    if (self.leftLabel.text.length > 0) {
        [self.leftLabel sizeToFit];
        self.leftLabel.left = kMargin;
        self.leftLabel.centerY = self.height * 0.5;
    }
    if (self.rightLabel.text.length > 0) {
        [self.rightLabel sizeToFit];
        self.rightLabel.right = self.width - kMargin;
        self.rightLabel.centerY = self.height * 0.5;
    }
    
}

- (UILabel *)leftLabel {
    
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
    }
    return _rightLabel;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}


@end
