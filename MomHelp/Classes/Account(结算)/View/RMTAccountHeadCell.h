//
//  RMTAccountHeadCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTAccountHeadCell : UITableViewCell
//可报销金额
@property (weak, nonatomic) IBOutlet UILabel *ReLabel;
//累计报销
@property (weak, nonatomic) IBOutlet UILabel *CumulativeLabel;

@end
