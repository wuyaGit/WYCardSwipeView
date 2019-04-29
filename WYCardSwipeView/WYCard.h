//
//  WYCard.h
//  WYCardSwipeView
//
//  Created by Highden on 2019/4/28.
//  Copyright © 2019年 https://github.com/wuyaGit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYCardItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface WYCard : UICollectionViewCell

@property (nonatomic, strong) WYCardItem *item;
@end

NS_ASSUME_NONNULL_END
