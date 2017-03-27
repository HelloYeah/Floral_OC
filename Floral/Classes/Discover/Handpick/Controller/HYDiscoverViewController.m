//
//  HYDiscoverViewController.m
//  HYLive
//
//  Created by Sekorm on 2017/3/23.
//  Copyright © 2017年 YL. All rights reserved.
//

#import "HYDiscoverViewController.h"

@interface HYDiscoverViewController ()

@end

@implementation HYDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Color(200, 200, 200);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"TOP" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
}


- (void)test {

}

@end
