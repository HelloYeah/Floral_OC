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


@interface HYProfileViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) HYProfileHeaderView * headerView;
@property (nonatomic,strong) UITableView *userHomeTableView;
@end

@implementation HYProfileViewController



#pragma mark - ******************** lift cycle *********************
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.userHomeTableView];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"匿名用户";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"pc_setting_40x40"] style:UIBarButtonItemStylePlain target:self action:@selector(settingClick)];
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
        cell.textLabel.textColor = Color(64, 64, 64);
        cell.textLabel.font = kFont(16);
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"我的发布";
            cell.imageView.image = [UIImage imageNamed:@"f_p_cart_19x19"];
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"我的消息";
            cell.imageView.image = [UIImage imageNamed:@"f_p_order_19x19"];
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"优惠券";
            cell.imageView.image = [UIImage imageNamed:@"f_p_course_19x19"];
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"我的订单";
            cell.imageView.image = [UIImage imageNamed:@"f_p_order_19x19"];
        }
            break;
        case 4:
        {
            cell.textLabel.text = @"我的购物车";
            cell.imageView.image = [UIImage imageNamed:@"f_p_cart_19x19"];
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[UIView new] init];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    HUD.label.text = @"功能尚未完善";
    HUD.bezelView.backgroundColor = [UIColor whiteColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}




#pragma mark UI Event

- (void)settingClick {

    HYSettingViewController *settingVC = [[HYSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark  getter/setter
- (UITableView *)userHomeTableView {
    
    if (!_userHomeTableView) {
        _userHomeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49) style:UITableViewStylePlain];
        
        _userHomeTableView.delegate = self;
        _userHomeTableView.dataSource = self;
        _userHomeTableView.backgroundColor = Color(240,240,240);
        _userHomeTableView.tableHeaderView = self.headerView;
        _userHomeTableView.tableFooterView = [UIView new];
        _userHomeTableView.showsVerticalScrollIndicator = NO;
    }
    return _userHomeTableView;
}

- (HYProfileHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[HYProfileHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,200)];
        _headerView.checkUserInfomationBlock = ^{
            NSLog(@"点击了头像！！！");
        };
    }
    return _headerView;
}

@end
