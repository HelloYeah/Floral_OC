

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
#import "HYCollectionTopView.h"
#import "HYSysCategoryServletModel.h"

#define kTopViewHeight 700 * kScreenWidthRatio

@interface HYSubjectViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) HYCollectionTopView *topView;
@property (nonatomic,assign) NSInteger  currentPageIndex;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HYSubjectViewController

#pragma mark - lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"花田小憩";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"f_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self requestGetSysCategoryServlet];
    [self loadData];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.collectionView.contentOffset = CGPointMake(0, - kTopViewHeight);
    });
}

#pragma mark - delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    ;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HYSubjectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HYSubjectCollectionCell description] forIndexPath:indexPath];
    HYArtcleModel *artcelModel = self.dataArray[indexPath.item];
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

#pragma mark - UIEvents
- (void)searchClick {

}

#pragma mark - request
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
            [self showHint:@"网络异常" ];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"网络异常"];
    }];

}

- (void)requestGetSysCategoryServlet {
    
    [[HYNetworkTool shareTool] GET:@"http://m.htxq.net/servlet/SysCategoryServlet?action=getList" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *result = responseObject[@"result"];
        if (result.count > 0){
            
            NSArray *tempArray = [HYSysCategoryServletModel mj_objectArrayWithKeyValuesArray:result];
            self.topView.sysCategoryServlets = tempArray;
            self.topView.wallpapers = @[@"http://static.htxq.net/UploadFiles/2017/03/07/20170307141120878968.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/07/20170307140812696393.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/09/20170309164146893568.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/09/20170309162757806146.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/08/20170308204222254187.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/08/20170308175120532126.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/08/20170308103232421179.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/10/20170310101058200296.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/20/20170320194126563667.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/16/20170316140412690242.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/16/20170316184955243776.jpg",
                                        @"http://static.htxq.net/UploadFiles/2017/03/17/20170317184723774861.jpg",
                                        ];
        }else{
            [self showHint:@"网络异常" ];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self showHint:@"网络异常"];
    }];
    
}

#pragma mark - getter/setter
- (HYCollectionTopView *)topView {
    
    if (!_topView) {
        _topView = [[HYCollectionTopView alloc] initWithFrame:CGRectMake(0, - kTopViewHeight, kScreenWidth, kTopViewHeight)];
    }
    return _topView;
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
        
        _collectionView.contentInset = UIEdgeInsetsMake(kTopViewHeight, 0, 0, 0);
        [_collectionView addSubview: self.topView];
        
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
        _collectionView.mj_header.ignoredScrollViewContentInsetTop = kTopViewHeight;
        
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
