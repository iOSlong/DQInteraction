//
//  UIDevice+NTYExtension.m
//  Fibra
//
//  Created by wangchao9 on 2017/6/22.
//  Copyright © 2017年 wangchao9. All rights reserved.
//

#import "UIDevice+NTYExtension.h"
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <NetworkExtension/NetworkExtension.h>
#import <OpenUDID/OpenUDID.h>
#import "KeychainItemWrapper.h"
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>


@implementation UIDevice (DeviceName)
+ (NSString*)deviceName {
    static NSString *deviceVersion = nil;
    if (deviceVersion == nil) {
        NSDictionary *deviceVersionNames = @{
            @"i386":@"Simulator",
            @"x86_64":@"Simulator",

            @"iPhone1,1":@"iPhone 1",
            @"iPhone1,2":@"iPhone 3",
            @"iPhone2,1":@"iPhone 3S",
            @"iPhone3,1":@"iPhone 4",
            @"iPhone3,2":@"iPhone 4",
            @"iPhone4,1":@"iPhone 4S",
            @"iPhone5,1":@"iPhone 5",
            @"iPhone5,2":@"iPhone 5",
            @"iPhone5,3":@"iPhone 5C",
            @"iPhone5,4":@"iPhone 5C",
            @"iPhone6,1":@"iPhone 5S",
            @"iPhone6,2":@"iPhone 5S",
            @"iPhone7,1":@"iPhone 6Plus",
            @"iPhone7,2":@"iPhone 6",
            @"iPhone8,1":@"iPhone 6S",
            @"iPhone8,2":@"iPhone 6SPlus",
            @"iPhone8,4":@"iPhone SE",
            @"iPhone9,1":@"iPhone 7",
            @"iPhone9,2":@"iPhone 7Plus",
            @"iPhone9,3":@"iPhone 7",
            @"iPhone9,4":@"iPHone 7Plus",

            @"iPhone10,1":@"iPhone 8",
            @"iPhone10,4":@"iPhone 8",
            @"iPhone10,2":@"iPhone 8Plus",
            @"iPhone10,2":@"iPhone 8Plus",

            @"iPhone10,3":@"iPhone X",
            @"iPhone10,6":@"iPhone X",

            @"iPod1,1":@"iPodTouch",
            @"iPod2,1":@"iPodTouch2",
            @"iPod3,1":@"iPodTouch3",
            @"iPod4,1":@"iPodTouch4",
            @"iPod5,1":@"iPodTouch5",
            @"iPod7,1":@"iPodTouch6",

            @"iPad1,1":@"iPad 1",

            @"iPad2,1":@"iPad 2",
            @"iPad2,2":@"iPad 2",
            @"iPad2,3":@"iPad 2",
            @"iPad2,4":@"iPad 2",

            @"iPad3,1":@"iPad 3",
            @"iPad3,2":@"iPad 3",
            @"iPad3,3":@"iPad 3",
            @"iPad3,4":@"iPad 4",
            @"iPad3,5":@"iPad 4",
            @"iPad3,6":@"iPad 4",

            @"iPad6,11":@"iPad 5",
            @"iPad6,12":@"iPad 5",

            @"iPad4,1":@"iPad Air",
            @"iPad4,2":@"ipad Air",
            @"iPad4,3":@"iPad Air",

            @"iPad5,3":@"iPad Air2",
            @"iPad5,4":@"iPad Air2",

            @"iPad6,3":@"iPad Pro", // 9.7 inch
            @"iPad6,4":@"iPad Pro", // 9.7 inch

            @"iPad6,7":@"iPad Pro", // 12.9 inch
            @"iPad6,8":@"iPad Pro", // 12.0 inch

            @"iPad7,1":@"iPad Pro 2", // 12.9 inch
            @"iPad7,2":@"iPad Pro 2", // 12.9 inch

            @"iPad7,3":@"iPad Pro 2", // 10.5 inch
            @"iPad7,4":@"iPad Pro 2", // 10.5 inch

            @"iPad2,5":@"iPad Mini",
            @"iPad2,6":@"iPad Mini",
            @"iPad2,7":@"iPad Mini",

            @"iPad4,4":@"iPad Mini 2",
            @"iPad4,5":@"iPad Mini 2",
            @"iPad4,6":@"iPad Mini 2",

            @"iPad4,7":@"iPad Mini 3",
            @"iPad4,8":@"iPad Mini 3",
            @"iPad4,9":@"iPad Mini 3",

            @"iPad5,1":@"iPad Mini 4",
            @"iPad5,2":@"iPad Mini 4",
        };
        NSString *deviceVersionInfo = [self deviceModel];
        deviceVersion = [deviceVersionNames valueForKey:deviceVersionInfo];
        if (!deviceVersion) {
            deviceVersion = deviceVersionInfo;
        }
    }

    return deviceVersion;
} /* deviceName */

+ (NSString*)deviceModel {
    static dispatch_once_t onceToken;
    static NSString       *platform;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;uname(&systemInfo);
        platform = @(systemInfo.machine);
    });
    return platform;
}

+ (NSDictionary*)wifiInfo {
    NSArray      *ifs  = (__bridge_transfer NSArray*)CNCopySupportedInterfaces();
    NSDictionary *info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer NSDictionary*)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if ([info count]) {
            break;
        }
    }
    return info;
}

+ (NSString*)wifiName {
    NSDictionary *info     = [self wifiInfo];
    NSString     *wifiName = info[@"SSID"];
    return wifiName?:@"";
}

+ (NSString*)macAddress {
    NSDictionary *info           = [self wifiInfo];
    NSString     *wifiMACAddress = [info[@"BSSID"] stringByReplacingOccurrencesOfString:@":" withString:@""];
    return wifiMACAddress?:@"20000000";
}
#if 0
    #warning "6p cannot get right network state"

#endif // if 0

+ (NSString*)idfv {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString*)idfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}



+ (NSString*)nty_systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString*)resolution {
    CGRect  bounds = [[UIScreen mainScreen] bounds];
    CGSize  size   = bounds.size;
    CGFloat scale  = [UIScreen mainScreen].scale;

    return [NSString stringWithFormat:@"%.0f_%.0f",size.width * scale,size.height * scale];
}

+ (BOOL)isIPhoneX {
    if (LONG_BORDER == 812 && SHORT_BORDER == 375) {
        return YES;
    }
    return NO;
}

NSString* const keyDQUUID = @"dq_uuid";
+ (NSString*)deviceID {
    static dispatch_once_t onceToken;
    static NSString       *deviceID;
    dispatch_once(&onceToken, ^{
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString       *deviceIDInDefaults   = [standardUserDefaults objectForKey:keyDQUUID];
        if (!isEmpty(deviceIDInDefaults)) {
            deviceID = deviceIDInDefaults;
        } else {
            //从keychain里获取
            KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
            deviceID = [keychain objectForKey:(__bridge id)kSecValueData];

            //都获取不到值的情况，重新创建
            if (isEmpty(deviceID)) {
                deviceID = [OpenUDID value];
                /// 因为审核会奔溃, 采用异步的方式写入
                [Dispatch async:DISPATCH_QUEUE_PRIORITY_DEFAULT name:@"save-keychain" execute:^{
                    [keychain setObject:@"DQ_IPHONE_CLIENT_UUID" forKey:(__bridge id)kSecAttrService];
                    [keychain setObject:deviceID forKey:(__bridge id)kSecValueData];
                }];
            }
            [standardUserDefaults setObject:deviceID forKey:keyDQUUID];
            [standardUserDefaults synchronize];
        }
    });
    return deviceID;
}

+ (NSString*)ipAddress {
    NSString       *address    = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr  = NULL;
    int             success    = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr != NULL && temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([@(temp_addr->ifa_name) isEqualToString:@"en0"]) {
                    address = @(inet_ntoa(((struct sockaddr_in*)temp_addr->ifa_addr)->sin_addr));
                    break;
                }
            }

            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);

    return address;
}

+ (uint64_t)freeDiskSize {
    NSError      *error      = nil;
    NSString     *path       = [Path document];
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:path error:&error];
    if (attributes) {
        uint64_t       capacity = [attributes[NSFileSystemSize] unsignedLongLongValue];
        uint64_t       freeSize = [attributes[NSFileSystemFreeSize] unsignedLongLongValue];
        const uint64_t reserve  = 200 * 1024 * 1024;                  /// 200m保留空间
        const CGFloat  GB       = 1024 * 1024 * 1024;
        NSLog(@"Memory Capacity of %.2f GB with %.2f GB Free memory available.", capacity / GB, (freeSize - reserve) / GB);
        return freeSize - reserve;
    }

    NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %@", [error domain], @([error code]));
    return 0;
}

+ (uint64_t)diskCapacity {
    NSError      *error      = nil;
    NSString     *path       = [Path document];
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:path error:&error];
    if (attributes) {
        uint64_t capacity = [attributes[NSFileSystemSize] unsignedLongLongValue];
        return capacity;
    }

    NSLog(@"Error %@", error);
    return 0;
}

+ (void)setOrientation:(UIDeviceOrientation)orientation {
    NSNumber *orientationUnknown = @(UIInterfaceOrientationUnknown);
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    NSNumber *orientationTarget = @(orientation);
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}
@end
