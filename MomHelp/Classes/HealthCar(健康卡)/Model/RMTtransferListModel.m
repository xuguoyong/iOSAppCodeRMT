//
//  RMTtransferListModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTtransferListModel.h"

@implementation RMTtransferListModel


- (NSString *)cover
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_cover];
    return img;
}
@end
