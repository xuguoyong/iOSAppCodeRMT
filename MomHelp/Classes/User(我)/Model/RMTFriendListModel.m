//
//  RMTFriendListModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTFriendListModel.h"

@implementation RMTFriendListModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"myNewPeopList" : @"RMTmyNewPeopListModel",
             @"levelDetaiList" : @"RMTLevelDetaiListModel"
             };

}

- (NSString *)headUrl
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_headUrl];
    return img;
}
@end
