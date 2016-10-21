//
//  SGControllerTool.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RMTControllerType) {
    //以下是枚举成员
    LoginController = 0,
    TabBarController = 1,
} ;


@interface SGControllerTool : NSObject
/**
 *  选择根控制器
 *  1 直接进入首页
 *  2 进入登录页面
 *  3 显示新特性（版本更新或者是第一次版本的介绍）
 */
+ (void)chooseRootViewControllerWithControllerType:(RMTControllerType)controllerType;



/**
 跳转至登录控制器
 loginSuccess 登陆成功之后会走的回调
 */
+ (void)popToLoginControllerTarget:(UIViewController *)target loginSuccessBlock:(void(^)(id data))loginSuccess;

@end
