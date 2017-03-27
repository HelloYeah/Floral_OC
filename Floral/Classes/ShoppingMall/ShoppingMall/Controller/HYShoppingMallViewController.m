//
//  HYShoppingMallViewController.m
//  Floral
//
//  Created by Sekorm on 2017/3/27.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYShoppingMallViewController.h"

@interface HYShoppingMallViewController ()

@end

@implementation HYShoppingMallViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = Color(200, 200, 200);
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

@end
