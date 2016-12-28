/**
 *  OCTabBar.h
 *  Reference : https://github.com/PanXianyue/BlogDemo/tree/master/XYTabBarDemo
 *
 *  Created by coder4869 on 12/28/16.
 *  Copyright © 2016 coder4869. All rights reserved.
 */

#import <UIKit/UIKit.h>

extern NSUInteger const kTabBarBadgeViewDelta;

@interface UITabBar (Swizzling)

@property(nonatomic, strong) UITabBarController *controller;

@end
