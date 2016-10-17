//
//  SGAddressURL.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  这个类存放的全部都是请求的URL 包括主要的URL 还有一些appkey

#ifndef SGAddressURL_h
#define SGAddressURL_h

//正式库
#define MainURL  @"https://api.91stjk.com"
#define VersionType @""


////测试库
//#define MainURL  @"http://192.168.1.197:7777"
//#define VersionType @"beta"


#define ImagePerfix @"https://img.91stjk.com"


/** 首页数据接口*/
#define GET_HomePageDataURL @"/product/index"
/** 用户登录接口*/
#define POST_Login @"/oauth/token" 

/** 注册 */
#define POST_Register @"/user/register"
/** 获取验证码*/
#define POST_GetMesssageCode @"/sms/captcha"
/** 找忘记密码密码*/
#define POST_RegisPasswd @"/user/retrieve_password"

/** 获取用户信息*/
#define POST_GetUserInfo @"/user/userInfo"
/** 获取用户中心界面*/
#define GET_User_Center @"/user/userIndex"

/** 获取用户中心界面*/
#define GET_User_Center @"/user/userIndex"
/**消息列表*/
#define GET_Message_List @"/message/list"

/**消息详情*/
#define GET_Message_Details @"/message/details"

#endif /* SGAddressURL_h */


