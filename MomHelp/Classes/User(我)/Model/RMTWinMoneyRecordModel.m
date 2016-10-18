//
//  RMTWinMoneyRecordModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTWinMoneyRecordModel.h"

@implementation RMTWinMoneyRecordModel

- (NSString *)headUrl
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_headUrl];
    return img;
}

@end
