//
//  DQMacro.h
//  Le123PhoneClient
//
//  Created by caoyu on 2017/6/17.
//  Copyright © 2017年 Ying Shi Da Quan. All rights reserved.
//

#pragma once

#pragma mark - Device
//Platform
#define IS_IPHONE UIUserInterfaceIdiomPhone ==[[UIDevice currentDevice] userInterfaceIdiom]
#define IS_IPAD   UIUserInterfaceIdiomPad ==[[UIDevice currentDevice] userInterfaceIdiom]

//Version
#define IOS_SYSTEMVERSION [[UIDevice currentDevice].systemVersion floatValue]
#define IOS_7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#pragma mark - APP
#define NTYAppVersion() [NSBundle mainBundle].infoDictionary[@ "CFBundleShortVersionString"]
#define NTYAppBuild() [[[NSBundle mainBundle] infoDictionary] objectForKey:@ "CFBundleVersion"]
#define NTYAppName() [[[NSBundle mainBundle] infoDictionary] objectForKey:@ "CFBundleDisplayName"]
#pragma mark - UserDefault
#define UserDefault [NSUserDefaults standardUserDefaults]

#pragma mark - UIColor
#define COLOR_RGBA(r,g,b,a)        [UIColor colorWithRed: (float)(r) / 255.0 green: (float)(g) / 255.0 blue: (float)(b) / 255.0 alpha: a]
#define COLOR_RGB(r,g,b)           COLOR_RGBA(r, g, b, 1)
#define COLOR_HEX(hex)             COLOR_RGB(((hex) & 0xFF0000) >> 16,((hex) & 0xFF00) >> 8,((hex) & 0xFF))
#define COLOR_HEXA(hex,a)          COLOR_RGBA(((hex) & 0xFF0000) >> 16,((hex) & 0xFF00) >> 8,((hex) & 0xFF), a)
#define isSameColor(color1,color2) CGColorEqualToColor(color1.CGColor, color2.CGColor)

#pragma mark - UIScreen
#define SCREEN_SCALE  [UIScreen mainScreen].scale
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

//
#define kScreenHeight                    [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth                     [[UIScreen mainScreen] bounds].size.width
// 针对各个机型屏幕长宽比设置部分控件frame
#define Changex(xwidth) [[NSString stringWithFormat:@"%f",((xwidth/2)*kScreenWidth)/375] floatValue]
#define Changey(yheight) [[NSString stringWithFormat:@"%f",((yheight/2)*kScreenHeight)/667] floatValue]

//云盘使用错误码
#define ERRORCODE503 503 //服务器出错
#define ERRORCODE211 211 //无云盘码
#define ERRORCODE212 212 //服务器端请求地址超时

#define SHORT_BORDER MIN(SCREEN_HEIGHT, SCREEN_WIDTH)
#define LONG_BORDER  MAX(SCREEN_HEIGHT, SCREEN_WIDTH)

#pragma mark - NSURL
#define NTYURL(urlString) [NSURL nty_URLWithString:urlString]

#pragma mark - CGRect
#define RECT(x,y,w,h)     CGRectMake(x,y,w,h)
#define RECT_WIDTH(rect)  CGRectGetWidth(rect)
#define RECT_HEIGHT(rect) CGRectGetHeight(rect)

#define RECT_LEFT(rect)   CGRectGetMinX(rect)
#define RECT_TOP(rect)    CGRectGetMinY(rect)
#define RECT_RIGHT(rect)  CGRectGetMaxX(rect)
#define RECT_BOTTOM(rect) CGRectGetMaxY(rect)

#define RECT_CENTER_X(rect) CGRectGetMidX(rect)
#define RECT_CENTER_Y(rect) CGRectGetMidY(rect)

#pragma mark - CGSize
#define SIZE(w,h) CGSizeMake(w,h)

#pragma mark - CGPoint
#define POINT(x,y) CGPointMake(x,y)

#pragma mark - UIEdgeInsets
#define INSETS(t,l,b,r) UIEdgeInsetsMake(t,l,b,r)

#pragma mark - UIOffset
#define OFFSET(horizontal,vertical) UIOffsetMake(horizontal, vertical)

#pragma mark - NSString
#define STRING(fmt, ...) [NSString stringWithFormat:fmt,##__VA_ARGS__]

#pragma mark - NSIndexPath
#define INDEXPATH(section, row) [NSIndexPath indexPathForRow:row inSection: section]

#pragma mark - FILENAME
#ifndef __FILENAME__
    #define __FILENAME__ ({(strrchr(__FILE__, '/')?:(__FILE__ - 1)) + 1;})
#endif // ifndef __FILENAME__

#pragma mark -
#define POINT2STR(point)         NSStringFromCGPoint(point)
#define VECTOR2STR(vector)       NSStringFromCGVector(vector)
#define SIZE2STR(size)           NSStringFromCGSize(size)
#define RECT2STR(rect)           NSStringFromCGRect(rect)
#define TRANSFORM2STR(transform) NSStringFromCGAffineTransform(transform)
#define INSETS2STR(insets)       NSStringFromUIEdgeInsets(insets)
#define OFFSET2STR(offset)       NSStringFromUIOffset(offset)
#define CLASS2STR(className)     NSStringFromClass([className class])

#define POINT_STR()       CGPointFromString(string);
#define VECTOR_STR()      CGVectorFromString(string);
#define SIZE_STR()        CGSizeFromString(string);
#define RECT_STR()        CGRectFromString(string);
#define TRANSFORM_STR()   CGAffineTransformFromString(string);
#define INSETS_STR()      UIEdgeInsetsFromString(string);
#define OFFSET_STR()      UIOffsetFromString(string);
#define CLASS_STR(string) NSClassFromString(string)

#pragma mark - UUID
#define NTYUUIDString() [[NSUUID UUID] UUIDString]

#pragma mark - Check Null or Empty
#define isEmpty(aItem) \
( \
aItem == nil \
||[aItem isEmpty] \
)

#define _S(value, fallback) \
isEmpty(value)? (fallback):(value)
#define NONNULL_STR(_obj_) (_obj_)? (_obj_):@ ""

