//
//  AppDelegate.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "AppDelegate.h"
#import "SGTabBarController.h"
#import "SGControllerTool.h"
#import "AppDelegate+NetWorking.h"
#import "AppDelegate+ShareSDk.h"
#import "SGShowMesssageTool.h"
#import "UPPaymentControl.h"
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    开启网络监听
    [self openNetWorkingMonitor];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
  
    //初始化shareSDK
    [self initShareSdk];
//    选择根控制器
   // [SGControllerTool chooseRootViewController];
    self.window.rootViewController = [[SGTabBarController alloc] init];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAlipayPayStaues object:nil userInfo:@{@"stautes":resultDic}];
        }];
    }else if ([url.host isEqualToString:@"uppayresult"])
    {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            
            //结果code为成功时，先校验签名，校验成功后做后续处理
            if([code isEqualToString:@"success"]) {
                
                //交易成功
            }
            else if([code isEqualToString:@"fail"]) {
                //交易失败
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUionPayStaues object:nil userInfo:@{@"stautes":code}];
        }];
    }
    
    
  
    
    return YES;

}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
             [[NSNotificationCenter defaultCenter] postNotificationName:NotificationAlipayPayStaues object:nil userInfo:@{@"resultCode":resultDic}];
        }];
        
       
    }else if ([url.host isEqualToString:@"uppayresult"])
    {
        [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            
            //结果code为成功时，先校验签名，校验成功后做后续处理
            if([code isEqualToString:@"success"]) {
                
                //交易成功
            }
            else if([code isEqualToString:@"fail"]) {
                //交易失败
            }
            else if([code isEqualToString:@"cancel"]) {
                //交易取消
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUionPayStaues object:nil userInfo:@{@"stautes":code}];
        }];
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
