//
//  RMTAdModel.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTAdModel.h"

@implementation RMTAdModel

- (NSString *)adImg
{
    NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,_adImg];
    return img;

}

@end
