//
//  RMTMainFriendModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMainFriendModel.h"

@implementation RMTMainFriendModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"contrList":@"RMTcontrListModel"};
}
- (NSString *)headUrl
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_headUrl];
    return img;
}
@end
