//
//  SGAddressURL.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  这个类存放的全部都是请求的URL 包括主要的URL 还有一些appkey

#ifndef SGAddressURL_h
#define SGAddressURL_h

////正式库
//#define MainURL  @"https://api.91stjk.com"
//#define VersionType @""
//#define UionPayModel @"01"

////测试库 liuying
#define MainURL  @"http://192.168.1.197:7777"
#define VersionType @"beta_liuying"
#define UionPayModel @"00"

//测试库 liyong
//#define MainURL  @"http://192.168.1.167:7777"
//#define VersionType @"beta_liyong"
//#define UionPayModel @"00"

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

/**人脉成员*/
#define GET_Friend_MemberList @"/profit/myprofit"

/**人脉菜单*/
#define GET_Friend_Muenue @"/profit/profithome"
/**人脉收益*/
#define GET_Friend_Profits @"/profit/profits"

/**我的钱包*/
#define GET_Money_Packgae @"/account/findBalance"
/**近期收支*/
#define GET_Money_ResentMoneyList @"/account/logList"

/**阿里云的SDK请求后台参数解接口*/
#define GET_Aliyun_SDKPamark @"/oss/clientSts"
/**修改头像API*/
#define POST_Change_User_HeadPortrait @"/user/headPortrait"

/**修改性别API*/
#define POST_Change_User_Sex @"/user/sex"
/**修改昵称*/
#define POST_Change_User_Nick @"/user/nike"
/**修改生日*/
#define POST_Change_User_Birthday @"/user/birthday"
/**意见反馈*/
#define POST_User_Feel_Back @"/feedback/save"


/**修改地区*/
#define POST_Change_User_Area @"/user/area"
/**获取地区*/
#define GET_Area_List @"/area/china"

/**提现记录*/
#define GET_Win_Money_Record @"/account/findLogType"
/**收益记录*/
#define GET_Receve_Money_Record @"/account/profitLog"

/**档案列表*/
#define GET_Record_List @"/healthRecord/list"
/**档案详情*/
#define GET_Record_Detail @"/healthRecord/details"
/**档案添加备注*/
#define POST_Add_Remark_Record @"/healthRecord/addRemark"
/**添加档案*/
#define POST_Add_Record @"/healthRecord/save"
/**申请提现*/
#define POST_Extract_Money @"/extract/create"
/**结算首页*/
#define GET_Reimbursement_List @"/reimbursement/list"
/**结算详情*/
#define GET_Reimbursement_Detail @"/reimbursement/detail"
/**结算的健康档案*/
#define GET_HealthRecord_UserList @"/healthRecord/usedList"
/**卡包列表*/
#define GET_CardPackaget_List @"/cardpackage/list"
/**直购列表*/
#define GET_Product_List @"/product/list"
/**转让列表*/
#define GET_Transfer_List @"/cardpackage/transferList"
/**是否可以转让*/
#define GET_Product_Usable @"/product/usable"
/**转让*/
#define POST_Cardpackage_Transfer @"/cardpackage/transfer"
/**购买直购商品*/
#define GET_Product_Buy @"/product/buy"
/**购买转让卡商品*/
#define GET_CardPackage_Buy @"/cardpackage/buy"


#endif /* SGAddressURL_h */


