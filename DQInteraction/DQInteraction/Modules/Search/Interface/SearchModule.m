//
//  SearchModule.m
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//
#import "SearchModule.h"
#import "SearchBusiness.h"
#import "SearchViewController.h"

/// 模块名称
NSString* const ModuleSearch = @"Search";

/// Options Key的定义
// NSString* const SearchOptionsKey = @"";
// NSString* const SearchOptionsKey = @"";
// NSString* const SearchOptionsKey = @"";

@implementation SearchFactory
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options {
    BOOL isOptionsValid = NO;

    /// 检查参数
    isOptionsValid = YES;


    SearchViewController*controller = [[SearchViewController alloc] init];
    SearchBusiness      *business   = [[SearchBusiness alloc] init];
    controller.business = business;
    return controller;
}
@end
