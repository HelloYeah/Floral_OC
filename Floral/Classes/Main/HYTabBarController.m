//
//  HYTabBarController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "HYTabBarController.h"
#import "HYNavigationController.h"
#import "HYSubjectViewController.h"
#import "HYProfileViewController.h"
#import "HYDiscoverViewController.h"
#import "HYShoppingMallViewController.h"

@interface HYTabBarController ()

@end

@implementation HYTabBarController

+ (void)initialize {
    
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = Color(246, 246, 246);
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(0, - 2);

    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAtts[NSForegroundColorAttributeName] = Color(158, 158, 158);
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectAtts[NSForegroundColorAttributeName] = Color(21, 21, 21);
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self addChildViewControllerWithClassname:[HYSubjectViewController description] imagename:@"tb_0" title:@"专题"];
    [self addChildViewControllerWithClassname:[HYDiscoverViewController description] imagename:@"tb_0" title:@"发现"];
    [self addChildViewControllerWithClassname:[HYShoppingMallViewController description] imagename:@"tb_1" title:@"商城"];
    [self addChildViewControllerWithClassname:[HYProfileViewController description] imagename:@"tb_2" title:@"我的"];
}

// 添加子控制器
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    HYNavigationController *nav = [[HYNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_selected"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}

@end
