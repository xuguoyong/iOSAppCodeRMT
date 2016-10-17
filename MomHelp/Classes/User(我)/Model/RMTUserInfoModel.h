//
//  RMTUserInfoModel.h
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTUserInfoModel : NSObject


@property (nonatomic,strong) NSString *address ;// "<null>";
@property (nonatomic,strong) NSString *areaId ;// "<null>";
@property (nonatomic,strong) NSString *areaName ;// "<null>";
@property (nonatomic,strong) NSString *birthday ;// "<null>";
@property (nonatomic,strong) NSString *cityId ;// "<null>";
@property (nonatomic,strong) NSString *cityName ;// "<null>";
@property (nonatomic,strong) NSString *createdAt ;// 1476068815000;
@property (nonatomic,strong) NSString *headPortrait ;// "<null>";
//@property (nonatomic,strong) NSString *id ;// 2c91808357a8b6020157ac8eafe400c1;
@property (nonatomic,strong) NSString *mobile ;// "185****9493";
@property (nonatomic,strong) NSString *nick ;// "\U8bf7\U8bbe\U7f6e\U60a8\U7684\U6635\U79f0";
@property (nonatomic,strong) NSString *password ;// "";
@property (nonatomic,strong) NSString *provinceId ;// "<null>";
@property (nonatomic,strong) NSString *provinceName ;// "<null>";
@property (nonatomic,strong) NSString *sex ;// "<null>";
@property (nonatomic,strong) NSString *userName ;// 18588469493;
@property (nonatomic,strong) NSString *whetherBankCard ;// 0;
@property (nonatomic,strong) NSString *whetherCertification ;// 0;
@property (nonatomic,strong) NSString *whetherTransactionPassword ;// 0;



/**
 创建一个单例来保存信息
 */
+ (RMTUserInfoModel *)shareInstance;

/**
 保存accesstoken
 */
+ (void)saveAccessToken:(NSString *)access_token;

/**
 获取accesstoken
 
 @return accesstoken
 */
+ (NSString *)getAccessToken;

//清除Token
+ (void)clearAccountToken;

/**
 判断用户是否登录
 */
+ (BOOL)isUserLogin;
@end
