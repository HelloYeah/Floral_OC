//
//  HYShoppingMallViewController.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYShoppingMallViewController.h"

@interface HYShoppingMallViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation HYShoppingMallViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = Color(200, 200, 200);
    
    [self setNav];
    
    [self.view addSubview:self.collectionView];
}

- (void)setNav {

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"f_p_cart_19x19"] style:UIBarButtonItemStylePlain target:self action:@selector(cartClick)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全国" style:UIBarButtonItemStylePlain target:self action:@selector(cartClick)];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth * 0.5, 30)];
    searchBar.placeholder = @"搜索你喜欢的宝贝";
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.layer.borderColor = Color(50, 50, 50).CGColor;
    searchField.layer.borderWidth = kLineHeight;
    searchField.layer.cornerRadius = 2.0;
    self.navigationItem.titleView = searchBar;
}

- (void)cartClick {

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 50;
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UICollectionViewCell description] forIndexPath:indexPath];
    cell.backgroundColor = Color(125, 250, 125);
    return cell;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat margin = 12.5 * kScreenWidthRatio;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0,  margin);
        CGFloat width = (kScreenWidth - 3 * margin) / 2.0;
        flowLayout.itemSize = CGSizeMake(width, kScreenHeight * 0.45);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.height = kScreenHeight - kTopBarHeight - kTabBarHeight;
        
//        _collectionView.contentInset = UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
//        [_collectionView addSubview: self.topView];
//        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[UICollectionViewCell description]];
        _collectionView.backgroundColor = Color(240, 240, 240);
//        [_collectionView registerClass:[HYCollectionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HYCollectionSectionHeader description]];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新！！！");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_collectionView.mj_header endRefreshing];
            });
        }];
        
        _collectionView.mj_header = header;
//        _collectionView.mj_header.ignoredScrollViewContentInsetTop = kTopViewHeight;
        
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            NSLog(@"加载！！！");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadData];
            });
        }];
        
    }
    return _collectionView;
}


- (void)loadData {

}
@end
