//
//  RMTBuyHealthCarToolBar.h
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTBuyHealthCarToolBar : UIView

/**
 点击购买按钮的会会调用的回调
 */
@property (nonatomic,strong) void(^buyButtonClick)(id data);


/**
 设置数据

 @param carName 健康卡的名称
 @param price   健康卡的价格 
 */
- (void)sethealthCarName:(NSString *)carName andPrice:(NSString *)price;
@end
