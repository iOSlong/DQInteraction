//
//  UserCenterModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "UserCenterModule.h"
#import "UserCenterBusiness.h"
#import "UserCenterViewController.h"

/// 模块名称
NSString* const ModuleUserCenter = @"UserCenter";

/// Options Key的定义
// NSString* const UserCenterOptionsKey = @"";
// NSString* const UserCenterOptionsKey = @"";
// NSString* const UserCenterOptionsKey = @"";

@implementation UserCenterFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;

    UserCenterViewController*controller = [[UserCenterViewController alloc] init];
    UserCenterBusiness      *business   = [[UserCenterBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
