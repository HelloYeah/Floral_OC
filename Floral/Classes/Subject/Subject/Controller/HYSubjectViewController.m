
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
#import "HYSubjectCollectionCell.h"
#import "HYDetailController.h"

@interface HYSubjectViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSInteger  currentPageIndex;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end
//http://m.htxq.net/servlet/SysArticleServlet?action=mainList&currentPageIndex=1&pageSize=10&isVideo=0
@implementation HYSubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"花田小憩";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"f_search"] style:UIBarButtonItemStylePlain target:self action:@selector(loadData)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.currentPageIndex = 1;
    [self loadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYSubjectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HYSubjectCollectionCell description] forIndexPath:indexPath];
    HYArtcleModel *artcelModel = self.dataArray[indexPath.item];
    HYAuthorModel *au = artcelModel.author;
    HYCategoryModel *category = artcelModel.category;
    NSLog(@"%ld--%ld---%@--%@--%@",indexPath.row,indexPath.item,artcelModel.desc,au.userName,category.name);
    cell.artcleModel = artcelModel;
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYDetailController *detail = [[HYDetailController alloc] init];
    HYArtcleModel *artcelModel = self.dataArray[indexPath.item];
    detail.artcleModel = artcelModel;
    [self.navigationController pushViewController:detail animated:YES];
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(kScreenWidth, 50);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    HYCollectionSectionHeader *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HYCollectionSectionHeader description] forIndexPath:indexPath];
    if (indexPath.item == 0) {
        cell.leftLabel.text = @"专题";
    }
    
    return cell;
}




- (void)loadData {
    
    NSDictionary *parameters = @{@"currentPageIndex":@(self.currentPageIndex)};
    
    [[HYNetworkTool shareTool] GET:@"http://m.htxq.net/servlet/SysArticleServlet?action=mainList&pageSize=10&isVideo=0" parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [_collectionView.mj_footer endRefreshing];
        NSArray *result = responseObject[@"result"];
        if (result.count > 0) {
           self.currentPageIndex += 1;
           [self.dataArray addObjectsFromArray:[HYArtcleModel mj_objectArrayWithKeyValuesArray:result]];
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
        
        CGFloat margin = 12.5 * kScreenWidthRatio;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, margin, 0,  margin);
        CGFloat width = (kScreenWidth - 3 * margin) / 2.0;
        flowLayout.itemSize = CGSizeMake(width, kScreenHeight * 0.45);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionView.height = kScreenHeight - kTopBarHeight - kTabBarHeight;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HYSubjectCollectionCell class] forCellWithReuseIdentifier:[HYSubjectCollectionCell description]];
        _collectionView.backgroundColor = Color(240, 240, 240);
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
                [self loadData];
            });
        }];
        
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
