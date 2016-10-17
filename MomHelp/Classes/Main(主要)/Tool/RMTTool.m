//
//  RMTTool.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTool.h"

@implementation RMTTool
#pragma mark - 手机号码
+ (BOOL)isMobilePhoneNumberRegex:(NSString *)phoneNumber{
    
    if (!phoneNumber) {
        return NO;
    }
    NSString *regex = @"^(1(([34578][0-9])|(45)|(47)|(7[6-8])))\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isValid = [predicate evaluateWithObject:phoneNumber];
    return isValid;
}



@end
