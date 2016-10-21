//
//  RMTCurrentMoneyDataCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTTextView.h"
@interface RMTCurrentMoneyDataCell : UITableViewCell  <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *healthAccountLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectCarLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) RMTTextView *textView;
@property (nonatomic,strong) void (^getText)(NSString *remark);

@end
