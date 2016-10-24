//
//  RMTProductListView.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTDirctBuyProductModel.h"
@interface RMTProductListView : UIView
@property (nonatomic,strong) NSMutableArray *productList;
@property (nonatomic,strong) void (^didSelectWillBuyCarModel)(RMTDirctBuyProductModel *productModel);

@end
