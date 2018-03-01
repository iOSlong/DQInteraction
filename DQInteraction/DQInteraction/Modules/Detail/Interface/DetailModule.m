//
//  DetailModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "DetailModule.h"
#import "DetailBusiness.h"
#import "DetailViewController.h"

/// 模块名称
NSString* const ModuleDetail = @"Detail";

/// Options Key的定义
// NSString* const DetailOptionsKey = @"";
// NSString* const DetailOptionsKey = @"";
// NSString* const DetailOptionsKey = @"";

@implementation DetailFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;

    NTYRAssert(isOptionsValid, nil, @"Detail: Invalid options. %@", options );

    DetailViewController*controller = [[DetailViewController alloc] init];
    DetailBusiness      *business   = [[DetailBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
