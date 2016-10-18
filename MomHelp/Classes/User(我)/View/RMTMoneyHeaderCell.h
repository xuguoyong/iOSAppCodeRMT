//
//  RMTMoneyHeaderCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTMoneyHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@property (nonatomic,strong) void(^bankCarButtonClick)(id data);
@property (nonatomic,strong) void(^tixianButtonClick)(id data);
@end
