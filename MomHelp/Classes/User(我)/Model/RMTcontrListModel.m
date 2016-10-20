//
//  RMTcontrListModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTcontrListModel.h"

@implementation RMTcontrListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"list":@"RMTcontrListModel"};
}
- (NSString *)headUrl
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_headUrl];
    return img;
}
@end
