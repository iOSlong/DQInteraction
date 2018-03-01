//
//  UserCenterViewController.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "UserCenterViewController.h"
#import "UserCenterBusiness.h"

#pragma mark - Constant

@interface UserCenterViewController ()
@end

@implementation UserCenterViewController

#pragma mark - Object Cycle
- (instancetype)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

///  添加要追踪的属性
//// DQMEMD_TRACE_CHILDREN(self.business);

- (void)dealloc {
}

#pragma mark - Override
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Build UI

#pragma mark - Load Data

#pragma mark - 功能1
#pragma mark  Delegate & DataSource
#pragma mark Helper

#pragma mark - 功能2
#pragma mark  Delegate & DataSource
#pragma mark Helper
@end
