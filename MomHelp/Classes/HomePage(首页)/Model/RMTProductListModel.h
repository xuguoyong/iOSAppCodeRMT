//
//  RMTProductListModel.h
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTBaseModel.h"

@interface RMTProductListModel : RMTBaseModel

//这个字段暂时用不上
//@property (nonatomic,strong) NSMutableArray *covers;

@property (nonatomic,strong) NSString *limitApieceBuyNumber ;// 1000;
@property (nonatomic,strong) NSString *number ;// 44641;
@property (nonatomic,strong) NSString *productDetail ;// "https://m.91stjk.com/detail/healthCard_detail.html?productId;//";
@property (nonatomic,strong) NSString *productId ;// 2c918082572189800157219ba3b20000;
@property (nonatomic,strong) NSString *productShare ;// "https://m.91stjk.com/detail/share/share_1.html";
@property (nonatomic,strong) NSString *quantityList ;// 1;
@property (nonatomic,strong) NSString *title ;// "\U5168\U4fdd\U5065\U5eb7\U5361100\U5143";
@property (nonatomic,strong) NSString *userId ;// "<null>";
@property (nonatomic,strong) NSString *worth ;// 100;
@end
