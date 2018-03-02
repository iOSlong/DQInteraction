//
//  UIDevice+NTYExtension.h
//  Fibra
//
//  Created by wangchao9 on 2017/6/22.
//  Copyright © 2017年 wangchao9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (DeviceName)

/**
 * 设备型号
 *
 *  @return 返回"iPhone1,1"类似的字符串
 */
+ (NSString*)deviceModel;
/**
 *  设备型号
 *  @return 返回"iPhone 4S"类似的字符串
 *  @note 请参考 https://www.theiphonewiki.com/wiki/Models
 */
+ (NSString*)deviceName;

/**
 *  获取手机的mac地址
 *  @note 离线模式下无法获取mac地址
 *  @return mac地址
 */
+ (NSString*)macAddress;
+ (NSString*)wifiName;
/**
 *  获取ip地址
 *
 *  @return ip地址
 */
+ (NSString*)ipAddress;
/**
 *  @brief  获取系统版本号
 *
 *  @return 系统版本号字符串
 */
+ (NSString*)nty_systemVersion;

/**
 *  @brief  获取屏幕分辨率
 *
 *  @return 返回格式为  宽_高的字符串
 */
+ (NSString*)resolution;

/**
 *  判断设备是否是iPhoneX
 *
 *  @return YES 是, NO 否
 */
+ (BOOL)isIPhoneX;


+ (NSString*)deviceID;
+ (NSString*)idfv;
+ (NSString*)idfa;
+ (uint64_t)freeDiskSize;
+ (uint64_t)diskCapacity;

/**
 * 设备旋转
 *
 * @param orientation 设备旋转方向。
 *
 * @return none
 */
+ (void)setOrientation:(UIDeviceOrientation)orientation;

@end
