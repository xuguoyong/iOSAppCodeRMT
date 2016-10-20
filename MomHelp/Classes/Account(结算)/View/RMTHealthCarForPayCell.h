//
//  RMTHealthCarForPayCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTHealthCarForPayCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *CarImageView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *tLabel;
//增值中
@property (weak, nonatomic) IBOutlet UILabel *incrementLabel;
//数量
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
//代金券
@property (weak, nonatomic) IBOutlet UILabel *CashCouponLabel;
//当前
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;

@end
