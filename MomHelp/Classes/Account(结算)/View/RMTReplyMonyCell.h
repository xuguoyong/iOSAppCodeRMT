//
//  RMTReplyMonyCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTReplyMonyCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *moneyTextFied;
@property (nonatomic,strong) void (^getHowmuchMoney)(NSString *money);
@end
