
//
//  HYHomeViewController.m
//  HYLive
//
//  Created by Sekorm on 2017/3/23.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYSubjectViewController.h"
#import "HYCollectionSectionHeader.h"
#import "UIViewController+HUD.h"
#import "HYNetworkTool.h"
#import "HYArtcleModel.h"
#import "HYCategoryModel.h"
#import "HYAuthorModel.h"

@interface HYSubjectViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSArray *dataArray;
@end
//http://m.htxq.net/servlet/SysArticleServlet?action=mainList&currentPageIndex=1&pageSize=10&isVideo=0
@implementation HYSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"花田小憩";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self loadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[UICollectionViewCell description] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    HYArtcleModel *artcelModel = self.dataArray[indexPath.item];
    HYAuthorModel *au = artcelModel.author;
    HYCategoryModel *category = artcelModel.category;
    NSLog(@"%ld--%ld---%@--%@--%@",indexPath.row,indexPath.item,artcelModel.desc,au.userName,category.name);
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self showIndicatorHint:@"加载中"  yOffset:0];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud:YES];
    });
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth, 50);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HYCollectionSectionHeader description] forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    
    return cell;
}


- (void)loadData {
    
    [[HYNetworkTool shareTool] GET:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList&currentPageIndex=1&pageSize=10&isVideo=0" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        if (result.count > 0) {
           self.dataArray = [HYArtcleModel mj_objectArrayWithKeyValuesArray:result];
           [self.collectionView reloadData];
        }else{
           // [self showHint:@"网络异常"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //[self showHint:@"网络异常"];
    }];

}


- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth * 0.45 , kScreenHeight * 0.4);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.height = kScreenHeight - kTopBarHeight - kTabBarHeight;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[UICollectionViewCell description]];
        _collectionView.backgroundColor = Color(246, 246, 246);
        [_collectionView registerClass:[HYCollectionSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HYCollectionSectionHeader description]];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            NSLog(@"刷新！！！");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_collectionView.mj_header endRefreshing];
            });
        }];
   
        
        _collectionView.mj_header = header;
        
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            NSLog(@"加载！！！");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_collectionView.mj_footer endRefreshing];
            });
        }];
        
    }
    return _collectionView;
}

@end
