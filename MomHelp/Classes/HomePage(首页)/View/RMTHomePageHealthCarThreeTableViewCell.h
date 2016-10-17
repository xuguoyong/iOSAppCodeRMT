//
//  RMTHomePageHealthCarThreeTableViewCell.h
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTProductListModel.h"
#define itemW ((d_screen_width - 35)/3.0f)
@class RMTHomepageModel;
@interface RMTHomePageHealthCarThreeTableViewCell : UITableViewCell
@property (nonatomic,strong) RMTHomepageModel *model;
@property (nonatomic,strong) void(^touchImageViewAction)(NSInteger index,RMTProductListModel *productModel);
@end
