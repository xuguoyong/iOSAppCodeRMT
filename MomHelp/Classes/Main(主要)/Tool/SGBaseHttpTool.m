//
//  SGBaseHttpTool.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseHttpTool.h"
#import "SGHttpTool.h"
#import <MJExtension.h>
@implementation SGBaseHttpTool

/**
 GET请求

 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)getDataWithURL:(NSString *)url parma:(NSDictionary *)parma showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud logData:(BOOL)logObject success:(void (^)(NSDictionary *responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure{
    // 没有网络就不去请求数据 做一个友好的提示
    if (![SGShowMesssageTool isHaveNetWork]) {
        if (failure) {
            failure(nil,@"-10086",SGNotNetWorkingTips);
        }
        [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
    }
    // 显示状态栏上面的菊花
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if (showHud) {
           [SGShowMesssageTool showLoadingHUD];
        }
       
    });
    
    NSString *allURL = [NSString stringWithFormat:@"%@%@",MainURL,url];
    
    [SGHttpTool get:allURL params:parma success:^(id responseObj) {
     
        if (success && [responseObj isKindOfClass:[NSDictionary class]]) {
            
           NSString *code =  [NSString stringWithFormat:@"%@",responseObj[@"statusCode"]];
            
            //首先判断是否是需要重新登录
            if ([code intValue] ==6/*需要重新登录*/) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserNeedLogin object:nil];
                // 隐藏状态栏上面的菊花
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [SGShowMesssageTool hideLoadingHUD];
                });
                return ;
            }
            
            if ([code intValue] == 0) {
                success(responseObj);//请求成功
            }else//请求失败
            {
               if (showError && responseObj[@"message"]/*如果需要显示失败信息，就显示*/) {
                    [SGShowMesssageTool showMessage:[NSString stringWithFormat:@"%@",responseObj[@"message"]]];
                }
                if (failure) {
                    failure(nil,responseObj[@"statusCode"],responseObj[@"message"]);
                }
            }
        }
        // 隐藏状态栏上面的菊花
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
          [SGShowMesssageTool hideLoadingHUD];
        });
    } failure:^(NSError *error) {
        if (failure) {
            failure(error,[NSString stringWithFormat:@"%ld",error.code],[error localizedDescription]);
        }
        
        // 隐藏状态栏上面的菊花
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SGShowMesssageTool hideLoadingHUD];
         [SGShowMesssageTool showMessage:@"网络连接不畅，请稍后重试~"];
            
          
        });
    }];
    
    
}
/**
 POST请求
 
 @param url       请求的服务器地址
 @param parma     请求参数 是一个字典
 @param showError 请求错误时是否需要显示后台的错误提示
 @param showHud   是否需要显示加载的loading图标
 @param success   请求成功之后会调用的回调方法 将请求结果返回
 @param failure   失败会走的回调
 */
+ (void)postDataWithURL:(NSString *)url parma:(NSDictionary *)parma showErrorMessage:(BOOL)showError showHUD:(BOOL)showHud logData:(BOOL)logObject success:(void (^)(NSDictionary *responseObj))success failure:(void (^)(NSError *error,NSString *errorCode,NSString *remark))failure{
    // 没有网络就不去请求数据 做一个友好的提示
    if (![SGShowMesssageTool isHaveNetWork]) {
        if (failure) {
            failure(nil,@"-10086",SGNotNetWorkingTips);
        }
        [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if (showHud) {
            [SGShowMesssageTool showLoadingHUD];
        }
    });
    NSString *allURL = [NSString stringWithFormat:@"%@%@",MainURL,url];
    [SGHttpTool post:allURL params:parma success:^(id responseObj) {
        if (success && [responseObj isKindOfClass:[NSDictionary class]]) {
            
            NSString *code =  [NSString stringWithFormat:@"%@",responseObj[@"statusCode"]];
            //首先判断是否是需要重新登录
            if ([code intValue] ==6/*需要重新登录*/) {
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserNeedLogin object:nil];
                // 隐藏状态栏上面的菊花
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    [SGShowMesssageTool hideLoadingHUD];
                    
                });
                return ;
               
            }
            
            if ([code intValue] ==0) {
                success(responseObj);//请求成功
            }else//请求失败
            {
                if (showError && responseObj[@"message"]/*如果需要显示失败信息，就显示*/) {
                  
                    [SGShowMesssageTool showMessage:[NSString stringWithFormat:@"%@",responseObj[@"message"]] showTime:2.0f];
                }
                if (failure) {
                    failure(nil,responseObj[@"statusCode"],responseObj[@"message"]);
                }
            }
        }
        
        // 隐藏状态栏上面的菊花
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             [SGShowMesssageTool hideLoadingHUD];

        });
    } failure:^(NSError *error) {
        if (failure) {
            failure(error,[NSString stringWithFormat:@"%ld",error.code],[error localizedDescription]);
        }
        // 隐藏状态栏上面的菊花
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            [SGShowMesssageTool hideLoadingHUD];
            [SGShowMesssageTool showMessage:@"网络连接不畅，请稍后重试~"];
        });
    }];
}


#pragma mark --以下两个是内部方法
+ (void)showHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SGShowMesssageTool showLoadingHUD];
    });
    
    
}

+ (void)hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
       [SGShowMesssageTool hideLoadingHUD];
    });
   
}



@end
