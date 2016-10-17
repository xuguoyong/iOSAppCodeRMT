//
//  SGBaseHttpTool.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SGBaseHttpTool : NSObject


/**
 GET请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)getDataWithURL:(NSString *)url parma:(NSDictionary *)parma showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud logData:(BOOL)logObject success:(void (^)(NSDictionary *responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure;
/**
 POST请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)postDataWithURL:(NSString *)url parma:(NSDictionary *)parma showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud logData:(BOOL)logObject success:(void (^)(NSDictionary *responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure;

#pragma mark --以下两个是内部方法
/**
 *  显示加载动画
 */
+ (void)showHUD;
/**
 *  隐藏加载动画
 */
+ (void)hideHUD;

@end
