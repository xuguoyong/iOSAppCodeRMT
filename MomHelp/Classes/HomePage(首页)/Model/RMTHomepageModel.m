//
//  RMTHomepageModel.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHomepageModel.h"
#import "RMTAdModel.h"
@implementation RMTHomepageModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"adResponseList" : @"RMTAdModel",
             @"productList" : @"RMTProductListModel"
             };
}
- (void)freeSeleData
{
    [self.adResponseList removeAllObjects];
    [self.productList removeAllObjects];
    self.adResponseList =nil;
    self.productList = nil;
}

@end
