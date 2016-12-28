//
//  TabBarViewController.m
//  iOSDemo
//
//  Created by coder4869 on 12/27/16.
//  Copyright © 2016 coder4869. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "CenterViewController.h"
#import "UserViewController.h"
#import "OCTabBar.h"

@interface TabBarViewController ()
@property(nonatomic, strong) UITabBarItem *userItem;
@property(nonatomic, strong) HomeViewController *homeVC;
@property(nonatomic, strong) UINavigationController *listNav;
@property(nonatomic, strong) UserViewController *userVC;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUI {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setViewControllers:@[self.homeVC, self.listNav, self.userVC] animated:YES]; //set vcs
    [self setSelectedIndex:1];
}

#pragma mark - setter and getter

- (HomeViewController*)homeVC {
    if (!_homeVC) {
        _homeVC = [HomeViewController new];
        [_homeVC.view setBackgroundColor:[UIColor whiteColor]];
        [_homeVC.tabBarItem setImage:[UIImage imageNamed:@"home"]];
        [_homeVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [_homeVC setTitle:@"Home"];
        [_homeVC.tabBarItem setBadgeValue:@"5"];
    }
    return _homeVC;
}
- (UINavigationController*)listNav {
    if (!_listNav) {
        CenterViewController * listVC = [CenterViewController new];
        [listVC.tabBarItem setImage:[UIImage imageNamed:@"list"]];
        [listVC.tabBarItem setSelectedImage:[[UIImage imageNamed:@"list"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//        [_listVC setTitle:@" "];
        _listNav = [[UINavigationController alloc] initWithRootViewController:listVC];
    }
    return _listNav;
}
-(UserViewController*)userVC {
    if (!_userVC) {
        _userVC = [UserViewController new];
        [_userVC.view setBackgroundColor:[UIColor grayColor]];
        self.userItem = [[UITabBarItem alloc] initWithTitle:@"User" image:[UIImage imageNamed:@"user"] tag:1103];
        [self.userItem setBadgeValue:@"10"];
        [_userVC setTabBarItem:self.userItem];
    }
    return _userVC;
}

@end
