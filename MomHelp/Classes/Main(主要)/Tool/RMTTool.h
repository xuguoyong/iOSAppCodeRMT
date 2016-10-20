//
//  RMTTool.h
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTTool : NSObject
/**
 验证手机号码是否正确

 */
#pragma mark - 手机号码
+ (BOOL)isMobilePhoneNumberRegex:(NSString *)phoneNumber;

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) value;

#pragma mark - 验证是否是数字
+ (BOOL)isNumberRegex:(NSString *)number;
@end
