//
//  WYCardSwipeFlowLayout.m
//  WYCardSwipeView
//
//  Created by Highden on 2019/4/28.
//  Copyright © 2019年 https://github.com/wuyaGit. All rights reserved.
//

#import "WYCardSwipeFlowLayout.h"

// 居中卡片宽度与据屏幕宽度比例
static float CardWidthScale = 0.7f;
static float CardHeightScale = 0.8f;

@implementation WYCardSwipeFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, [self collectionInset], 0, [self collectionInset]);
}

#pragma mark - private

// 宽
- (CGFloat)cellWidth {
    return self.collectionView.bounds.size.width * CardWidthScale;
}

// 间隔
- (CGFloat)cellMargin {
    return (self.collectionView.bounds.size.width - [self cellWidth]) / 7;
}

// 设置左右缩进
- (CGFloat)collectionInset {
    return self.collectionView.bounds.size.width / 2.f - [self cellWidth] / 2.f;
}

// 防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes {
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

#pragma mark - overlay

// 最小纵向间距
- (CGFloat)minimumLineSpacing {
    return [self cellMargin];
}

// cell大小
- (CGSize)itemSize {
    return CGSizeMake([self cellWidth], self.collectionView.bounds.size.height * CardHeightScale);
}

// 是否实时刷新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// 设置缩放动画
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    // 扩大控制范围，防止出现闪屏现象
    CGRect bigRect = rect;
    bigRect.size.width = rect.size.width + 2*[self cellWidth];
    bigRect.origin.x = rect.origin.x - [self cellWidth];
    
    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:bigRect]];
    // 屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    // 刷新cell缩放
    for (UICollectionViewLayoutAttributes *attributes in arr) {
        CGFloat distance = fabs(attributes.center.x - centerX);
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
        CGFloat scale = fabs(cos(apartScale * M_PI/4));
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

@end
