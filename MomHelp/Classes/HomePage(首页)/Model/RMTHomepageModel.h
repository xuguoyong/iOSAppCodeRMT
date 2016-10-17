//
//  RMTHomepageModel.h
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTBaseModel.h"
@class RMTAdModel;
@interface RMTHomepageModel : RMTBaseModel

/**
 首页滚动的图片 取前三张显示
 */
@property (nonatomic,strong) NSMutableArray *adResponseList;
/**
 产品列表
 */
@property (nonatomic,strong) NSMutableArray *productList;


/**
 释放
 */
- (void)freeSeleData;

@end
