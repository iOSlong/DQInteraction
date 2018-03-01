//
//  RankModule.h
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
extern NSString* const ModuleRank;

/// Notification定义
// extern NSNotificationName const RankNotification
// extern NSNotificationName const RankNotification
// extern NSNotificationName const RankNotification

/// Options Key的定义
// extern NSString* const RankOptionsKey;
// extern NSString* const RankOptionsKey;
// extern NSString* const RankOptionsKey;

/// 模块工厂
@interface RankFactory : NSObject
/**
 *  创建模块入口
 *
 *  @param options 创建模块需要的参数
 *
 *  @return nil表示无法创建模块入口
 */
+ (UIViewController*)viewControllerWithOptions:(NSDictionary*)options;
@end
