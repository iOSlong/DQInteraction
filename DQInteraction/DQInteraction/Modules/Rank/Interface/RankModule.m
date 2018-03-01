//
//  RankModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "RankModule.h"
#import "RankBusiness.h"
#import "RankViewController.h"

/// 模块名称
NSString* const ModuleRank = @"Rank";

/// Options Key的定义
// NSString* const RankOptionsKey = @"";
// NSString* const RankOptionsKey = @"";
// NSString* const RankOptionsKey = @"";

@implementation RankFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;


    RankViewController*controller = [[RankViewController alloc] init];
    RankBusiness      *business   = [[RankBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
