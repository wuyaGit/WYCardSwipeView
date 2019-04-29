//
//  WYCardSwipeView.h
//  WYCardSwipeView
//
//  Created by Highden on 2019/4/28.
//  Copyright © 2019年 https://github.com/wuyaGit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYCardItem.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WYCardSwipeViewDelegate <NSObject>

@optional

/**
 * 滚动后目标idx
 */
- (void)cardSwipeViewDidSelectedAt:(NSInteger)index;

@end

@interface WYCardSwipeView : UIView

// 当前选中位置
@property (nonatomic, assign) NSInteger selectedIndex;

// 设置数据源
@property (nonatomic, strong) NSArray<WYCardItem *> *items;

// 代理
@property (nonatomic, weak) id<WYCardSwipeViewDelegate> delegate;

// 是否分页，默认为true
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 * 手动滚动到某个卡片位置
 */
- (void)swipeToIndex:(NSInteger)index animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
