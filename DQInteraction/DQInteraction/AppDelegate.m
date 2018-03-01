//
//  AppDelegate.m
//  DQInteraction
//
//  Created by lxw on 2018/2/28.
//  Copyright © 2018年 lxw. All rights reserved.
//

#import "AppDelegate.h"
#import "RecommendViewController.h"
#import "ChannelViewController.h"
#import "RankViewController.h"
#import "TopicViewController.h"
#import "UserCenterViewController.h"
#import "DQNavigationController.h"
#import "DQTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setViewControllers];
    
    return YES;
}
- (void)setViewControllers {
    
    
    RecommendViewController *recommendVC = [[RecommendViewController alloc] init];
    recommendVC.title = @"首页";
    
    ChannelViewController *channelVC = [[ChannelViewController alloc] init];
    channelVC.title = @"频道";

    TopicViewController *topicVC = [[TopicViewController alloc] init];
    topicVC.title = @"专题";

    RankViewController *rankVC = [[RankViewController alloc] init];
    rankVC.title = @"排行榜";

    UserCenterViewController *userCenterVC = [[UserCenterViewController alloc] init];
    userCenterVC.title = @"个人中心";
    
    DQNavigationController *recommendNav = [[DQNavigationController alloc] initWithRootViewController:recommendVC];
    recommendNav.title = @"首页";

    DQNavigationController *channelNav = [[DQNavigationController alloc] initWithRootViewController:channelVC];
    channelNav.title = @"频道";
    
    DQNavigationController *topicNav = [[DQNavigationController alloc] initWithRootViewController:topicVC];
    topicNav.title = @"专题";

    DQNavigationController *rankNav = [[DQNavigationController alloc] initWithRootViewController:rankVC];
    rankNav.title = @"排行榜";

    DQNavigationController *userCenterNav = [[DQNavigationController alloc] initWithRootViewController:userCenterVC];
    userCenterNav.title = @"排行榜";

    DQTabBarController *tabBarController = [[DQTabBarController alloc] init];
    tabBarController.viewControllers = @[recommendNav,channelNav,topicNav,rankNav,userCenterNav];
    
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
