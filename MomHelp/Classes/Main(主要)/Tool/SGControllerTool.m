//
//  SGControllerTool.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGControllerTool.h"
#import "SGTabBarController.h"
#import "RMTLoginViewController.h"
#import "SGNavigationController.h"
@implementation SGControllerTool

/**
 *  选择根控制器
 *  1 直接进入首页
 *  2 进入登录页面
 *  3 显示新特性（版本更新或者是第一次版本的介绍）
 */
+ (void)chooseRootViewControllerWithControllerType:(RMTControllerType)controllerType
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    //叛判断当前是否已经登录，如果已经登录就返回YES
    switch (controllerType) {
        case LoginController:
        {
         RMTLoginViewController *login = [[RMTLoginViewController alloc] initWithNibName:@"RMTLoginViewController" bundle:nil];
            SGNavigationController *nav = [[SGNavigationController alloc] initWithRootViewController:login];
            window.rootViewController =nav;
        }
            break;
        case TabBarController:
        {
            
            window.rootViewController =[[SGTabBarController alloc] init];
        }
            break;
            
        default:
            break;
    }
    
//
    /*
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本：显示SGTabBarViewController
        [UIApplication sharedApplication].statusBarHidden = NO;
        window.rootViewController = [[SGTabBarController alloc] init];
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[SGNewfeatureViewController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
     
     */
}



+ (void)popToLoginControllerTarget:(UIViewController *)target
{
    RMTLoginViewController *login = [[RMTLoginViewController alloc] initWithNibName:@"RMTLoginViewController" bundle:nil];
    SGNavigationController *nav = [[SGNavigationController alloc] initWithRootViewController:login];
    [target presentViewController:nav animated:YES completion:nil];
}


@end
