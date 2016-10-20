//
//  RMTCarPackageModel.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTCarPackageModel.h"

@implementation RMTCarPackageModel

-(NSString *)image
{
    if (self.covers.count >0) {
        NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,[self.covers firstObject]];
        return img;
    }
    
    return nil;
}
@end
