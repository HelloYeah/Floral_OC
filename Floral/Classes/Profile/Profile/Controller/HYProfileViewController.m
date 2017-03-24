//
//  ViewController.h
//  YLSetting
//
//  Created by HelloYeah on 16/11/29.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "HYProfileViewController.h"
#import "HYNavigationController.h"
#import "HYSettingViewController.h"
#import "HYProfileHeaderView.h"
#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface HYProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HYProfileHeaderView * headerView;
@property (nonatomic,strong) UIButton * settingBtn;
@property (nonatomic,strong) UITableView *userHomeTableView;
@end

@implementation HYProfileViewController



#pragma mark - ******************** lift cycle *********************
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.userHomeTableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.settingBtn];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - ******************** delegate *********************
#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = Color(250,250,250);
        cell.textLabel.textColor = Color(255, 109, 0);
        cell.textLabel.font = kFont(15);
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"我的特权";
            cell.imageView.image = [UIImage imageNamed:@"myVip_icon"];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"我的钱包";
            cell.imageView.image = [UIImage imageNamed:@"myWallets_icon"];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"我的活动";
            cell.imageView.image = [UIImage imageNamed:@"myActivity_icon"];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"我的提问";
            cell.imageView.image = [UIImage imageNamed:@"myQuestion_icon"];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"我的回答";
            cell.imageView.image = [UIImage imageNamed:@"myAnswer_icon"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    HUD.label.text = @"功能尚未完善";
    HUD.bezelView.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat headH = - offsetY;
    if (headH <= 64 ) {
        headH = 64;
    }
    
    [self.headerView alphaWithHeight:headH orignHeight:kHeaderViewHeight];
}

#pragma mark UI Event

- (void)settingClick {

    HYSettingViewController *settingVC = [[HYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark  getter/setter
- (UITableView *)userHomeTableView {
    
    if (!_userHomeTableView) {
        _userHomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49) style:UITableViewStylePlain];
        
        _userHomeTableView.delegate = self;
        _userHomeTableView.dataSource = self;
        _userHomeTableView.backgroundColor = Color(250,250,250);
        _userHomeTableView.tableFooterView = [UIView new];
        _userHomeTableView.showsVerticalScrollIndicator = NO;
        _userHomeTableView.contentInset = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
        
    }
    return _userHomeTableView;
}

- (HYProfileHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[HYProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
        _headerView.checkUserInfomationBlock = ^{
            NSLog(@"点击了头像！！！");
        };
    }
    return _headerView;
}

- (UIButton *)settingBtn{
    
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 10 - 44, 20, 44, 44)];
        _settingBtn.imageView.contentMode = UIViewContentModeCenter;
        [_settingBtn setImage:[UIImage imageNamed:@"Setting"]  forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

@end
