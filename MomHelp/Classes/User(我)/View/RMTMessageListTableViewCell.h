//
//  RMTMessageListTableViewCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTMessageListModel.h"
@interface RMTMessageListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *readView;
@property (nonatomic,strong) RMTMessageListModel *model;

@end
