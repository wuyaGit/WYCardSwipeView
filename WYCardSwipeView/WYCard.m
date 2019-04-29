//
//  WYCard.m
//  WYCardSwipeView
//
//  Created by Highden on 2019/4/28.
//  Copyright © 2019年 https://github.com/wuyaGit. All rights reserved.
//

#import "WYCard.h"

@interface WYCard ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation WYCard

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.imageView];
    [self addSubview:self.textLabel];
}

#pragma mark - getter & setter

- (void)setItem:(WYCardItem *)item {
    _item = item;
    
    _imageView.image = [UIImage imageNamed:item.imageName];
    _textLabel.text = item.title;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        CGFloat labelHeight = self.bounds.size.height * 0.20f;
        CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, imageViewHeight)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = true;
    }
    return _imageView;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        CGFloat labelHeight = self.bounds.size.height * 0.20f;
        CGFloat imageViewHeight = self.bounds.size.height - labelHeight;
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageViewHeight, self.bounds.size.width, labelHeight)];
        _textLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        _textLabel.font = [UIFont systemFontOfSize:22];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.adjustsFontSizeToFitWidth = true;
    }
    return _textLabel;
}

@end
