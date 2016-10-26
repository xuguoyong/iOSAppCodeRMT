//
//  RMTUserInfoModel.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTUserInfoModel.h"


@implementation RMTUserInfoModel

static RMTUserInfoModel *_userInfoModelInstance;
+(RMTUserInfoModel *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfoModelInstance = [[RMTUserInfoModel alloc] init];
    });
    return _userInfoModelInstance;
}


/**
 保存accesstoken
 */
+ (void)saveAccessToken:(NSString *)access_token
{
    [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

/**
 获取accesstoken

 @return accesstoken
 */
+(NSString *)getAccessToken
{
    NSString *access_tokrn = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    
    return access_tokrn;
}
//清除Token
+ (void)clearAccountToken
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"access_token"];
     [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 判断用户是否登录
 */
+ (BOOL)isUserLogin
{
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (user) {
        //已经登录了
        return YES;
    }
    return NO;
}
- (NSString *)headPortrait
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_headPortrait];
    return img;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    NSLog(@"%@这个类缺少%@字段没有定义",NSStringFromClass([self class]),key);
}




@end
