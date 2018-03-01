//
//  TopicModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "TopicModule.h"
#import "TopicBusiness.h"
#import "TopicViewController.h"

/// 模块名称
NSString* const ModuleTopic = @"Topic";

/// Options Key的定义
// NSString* const TopicOptionsKey = @"";
// NSString* const TopicOptionsKey = @"";
// NSString* const TopicOptionsKey = @"";

@implementation TopicFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;

    TopicViewController*controller = [[TopicViewController alloc] init];
    TopicBusiness      *business   = [[TopicBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
