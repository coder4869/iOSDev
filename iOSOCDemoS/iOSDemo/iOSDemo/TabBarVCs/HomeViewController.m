//
//  HomeViewController.m
//  iOSDemo
//
//  Created by coder4869 on 12/27/16.
//  Copyright © 2016 coder4869. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)createUI {
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, KScreenWidth, 44)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"AddTitle"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:nil];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.rightBarButtonItem = addButton;
    [navBar setItems:@[navItem]];
    [self.view addSubview:navBar];
}
@end
