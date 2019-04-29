//
//  WYCardSwipeView.m
//  WYCardSwipeView
//
//  Created by Highden on 2019/4/28.
//  Copyright © 2019年 https://github.com/wuyaGit. All rights reserved.
//

#import "WYCardSwipeView.h"
#import "WYCardSwipeFlowLayout.h"
#import "WYCard.h"

@interface WYCardSwipeView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat dragStartX;
@property (nonatomic, assign) CGFloat dragEndX;
@end

@implementation WYCardSwipeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    //避免UINavigation对UIScrollView产生的便宜问题
    [self addSubview:[UIView new]];
    [self addSubview:self.collectionView];
}

#pragma mark - public methos

- (void)swipeToIndex:(NSInteger)index animated:(BOOL)animated {
    _selectedIndex = index;
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    [self performDelegateMethod];
}

#pragma mark - private methods

// 设置cell居中
- (void)fixCellToCenter {
    //最小滚动距离
    float dragMiniDistance = self.bounds.size.width / 20.f;
    
    if (_dragStartX - _dragEndX >= dragMiniDistance) {
        _selectedIndex -= 1;//向右
    }else if (_dragEndX - _dragStartX >= dragMiniDistance) {
        _selectedIndex += 1;//向左
    }
    NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
    _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
    _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
    [self scrollToCenter];
}

// 设置collectionView滚动到中间
- (void)scrollToCenter {
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    [self performDelegateMethod];
}

- (void)performDelegateMethod {
    if ([_delegate respondsToSelector:@selector(cardSwipeViewDidSelectedAt:)]) {
        [_delegate cardSwipeViewDidSelectedAt:_selectedIndex];
    }
}

#pragma mark - scroll view delegate

//在不使用分页滚动的情况下需要手动计算当前选中位置 -> _selectedIndex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_pagingEnabled) {
        return;
    }
    if (!_collectionView.visibleCells.count) {
        return;
    }
    if (!scrollView.isDragging) {
        return;
    }
    
    CGRect currentRect = _collectionView.bounds;
    currentRect.origin.x = _collectionView.contentOffset.x;
    for (WYCard *card in _collectionView.visibleCells) {
        if (CGRectContainsRect(currentRect, card.frame)) {
            NSInteger index = [_collectionView indexPathForCell:card].item;
            if (index != _selectedIndex) {
                _selectedIndex = index;
            }
        }
    }
}

// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _dragStartX = scrollView.contentOffset.x;
}

// 停止拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!_pagingEnabled) {
        return;
    }
    _dragEndX = scrollView.contentOffset.x;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self fixCellToCenter];
    });
}

#pragma mark - collection view datasource & delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"WYCard";
    WYCard *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.item = self.items[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.item;
    [self scrollToCenter];
}

#pragma mark - getter & setter

- (void)setItems:(NSArray<WYCardItem *> *)items {
    _items = items;
    
    [_collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    if (self.items.count > selectedIndex) {
        [self swipeToIndex:selectedIndex animated:NO];
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        WYCardSwipeFlowLayout *flowLayout = [[WYCardSwipeFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.userInteractionEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[WYCard class] forCellWithReuseIdentifier:NSStringFromClass([WYCard class])];
    }
    return _collectionView;
}

@end
