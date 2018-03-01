//
//  RecommendModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "RecommendModule.h"
#import "RecommendBusiness.h"
#import "RecommendViewController.h"

/// 模块名称
NSString* const ModuleRecommend = @"Recommend";

/// Options Key的定义
// NSString* const RecommendOptionsKey = @"";
// NSString* const RecommendOptionsKey = @"";
// NSString* const RecommendOptionsKey = @"";

@implementation RecommendFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;

    RecommendViewController*controller = [[RecommendViewController alloc] init];
    RecommendBusiness      *business   = [[RecommendBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
