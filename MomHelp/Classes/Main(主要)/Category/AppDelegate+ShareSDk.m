//
//  AppDelegate+ShareSDk.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "AppDelegate+ShareSDk.h"
//＝＝＝＝＝＝＝＝＝＝ShareSDK头文件＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
@implementation AppDelegate (ShareSDk)

-(void)initShareSdk
{
#pragma mark ===Share社会化分享======
    //
    [ShareSDK registerApp:@"ac50a6a8cb9c" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),@(SSDKPlatformSubTypeWechatTimeline),@(SSDKPlatformSubTypeWechatSession),@(SSDKPlatformSubTypeQQFriend)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeWechat:
            {
                [ShareSDKConnector connectWeChat:[WXApi class]];
            }
                break;
            case SSDKPlatformTypeQQ:
            {
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            }
                break;
            case SSDKPlatformTypeSinaWeibo:
            {
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
            }
                break;
                
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:weiboAppKey
                                          appSecret:weiboAppSecret
                                        redirectUri:weiboRedireURL
                                           authType:SSDKAuthTypeBoth];
                break;
                
                
            case SSDKPlatformTypeWechat:
                //设置微信应用信息
                [appInfo SSDKSetupWeChatByAppId:weixinAppKey
                                      appSecret:weixinAppSecret];
                
                break;
            case SSDKPlatformTypeQQ:
                //设置QQ应用信息，其中authType设置为只用SSO形式授权
                [appInfo SSDKSetupQQByAppId:QQAppKey
                                     appKey:QQAppSecret
                                   authType:SSDKAuthTypeSSO];
                break;
            default:
                break;
        }
        
    }];

}


@end
