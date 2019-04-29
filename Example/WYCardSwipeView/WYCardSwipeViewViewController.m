//
//  WYCardSwipeViewViewController.m
//  WYCardSwipeView
//
//  Created by 407671883@qq.com on 04/28/2019.
//  Copyright (c) 2019 407671883@qq.com. All rights reserved.
//

#import "WYCardSwipeViewViewController.h"
#import <WYCardSwipeView.h>

@interface WYCardSwipeViewViewController ()<WYCardSwipeViewDelegate>

@property (nonatomic, strong) WYCardSwipeView *cardSwipeView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation WYCardSwipeViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupView];
    [self setupNavigationItem];
}

- (void)setupView {
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.cardSwipeView];

    //初始化数据源
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    NSMutableArray *items = [NSMutableArray new];
    for (NSDictionary *dic in arr) {
        WYCardItem *item = [[WYCardItem alloc] init];
        [item setValuesForKeysWithDictionary:dic];
        [items addObject:item];
    }
    
    self.cardSwipeView.items = items;
    //设置初始位置，默认为0
    self.cardSwipeView.selectedIndex = 3;
}

- (void)setupNavigationItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上一个" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一个" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"正常滚动",@"自动居中"]];
    seg.selectedSegmentIndex = 0;
    [seg addTarget:self action:@selector(segMethod:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = seg;
}

#pragma mark - sel methods

- (void)switchPrevious {
    NSInteger index = _cardSwipeView.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [_cardSwipeView swipeToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = _cardSwipeView.selectedIndex + 1;
    index = index > _cardSwipeView.items.count - 1 ? _cardSwipeView.items.count - 1 : index;
    [_cardSwipeView swipeToIndex:index animated:true];
}

- (void)segMethod:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
            _cardSwipeView.pagingEnabled = false;
            break;
        case 1:
            _cardSwipeView.pagingEnabled = true;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - card swipe view delegate

- (void)cardSwipeViewDidSelectedAt:(NSInteger)index {
    NSLog(@"选中了：%zd",index);
    
    // 更新背景图
    WYCardItem *item = _cardSwipeView.items[index];
    _imageView.image = [UIImage imageNamed:item.imageName];
}

#pragma mark - getter & setter

- (WYCardSwipeView *)cardSwipeView {
    if (!_cardSwipeView) {
        _cardSwipeView = [[WYCardSwipeView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64)];
        _cardSwipeView.delegate = self;
        //分页切换
        _cardSwipeView.pagingEnabled = false;
    }
    return _cardSwipeView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        
        // 高斯模糊
        UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = _imageView.bounds;
        [_imageView addSubview:effectView];
    }
    return _imageView;
}


@end
