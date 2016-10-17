//
//  AppDelegate+NetWorking.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "AppDelegate+NetWorking.h"
#import "AFNetworkReachabilityManager.h"
@implementation AppDelegate (NetWorking)
//开启器网络监听
- (void)openNetWorkingMonitor
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
               // debugLog(@"未识别的网络");
                [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
               // debugLog(@"不可达的网络(未连接)");
                  [[NSUserDefaults standardUserDefaults] setObject:@"noNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                //debugLog(@"2G,3G,4G...的网络");
                 [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                //debugLog(@"wifi的网络");
                 [[NSUserDefaults standardUserDefaults] setObject:@"haveNetwork" forKey:@"networkState"];
                break;
            default:
                break;
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
  [manager startMonitoring];
    
    
}
@end
