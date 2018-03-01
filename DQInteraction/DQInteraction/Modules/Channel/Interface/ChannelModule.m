//
//  ChannelModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "ChannelModule.h"
#import "ChannelBusiness.h"
#import "ChannelViewController.h"

/// 模块名称
NSString* const ModuleChannel = @"Channel";

/// Options Key的定义
// NSString* const ChannelOptionsKey = @"";
// NSString* const ChannelOptionsKey = @"";
// NSString* const ChannelOptionsKey = @"";

@implementation ChannelFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;

    ChannelViewController*controller = [[ChannelViewController alloc] init];
    ChannelBusiness      *business   = [[ChannelBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
