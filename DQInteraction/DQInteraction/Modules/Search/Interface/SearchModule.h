//
//  SearchModule.h
//  DQInteraction
//
//  Created by lxw on 2018/03/01.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  管理程序的主界面
 */

/// 模块名称
extern NSString* const ModuleSearch;

/// Notification定义
// extern NSNotificationName const SearchNotification
// extern NSNotificationName const SearchNotification
// extern NSNotificationName const SearchNotification

/// Options Key的定义
// extern NSString* const SearchOptionsKey;
// extern NSString* const SearchOptionsKey;
// extern NSString* const SearchOptionsKey;

/// 模块工厂
@interface SearchFactory : NSObject
/**
 *  创建模块入口
 *
 *  @param options 创建模块需要的参数
 *
 *  @return nil表示无法创建模块入口
 */
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options;
@end
