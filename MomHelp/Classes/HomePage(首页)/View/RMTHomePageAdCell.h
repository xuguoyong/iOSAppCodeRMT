//
//  RMTHomePageAdCell.h
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#define advImagesScale (260/640.0f)
@class RMTHomepageModel;


@interface RMTHomePageAdCell : UITableViewCell <UIScrollViewDelegate>
@property (nonatomic,strong)RMTHomepageModel *model;
@end
