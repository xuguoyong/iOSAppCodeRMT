//
//  RMTFriendDistributingCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTFriendDistributingCell.h"
#import "RMTLevelDetaiListModel.h"
@implementation RMTFriendDistributingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(RMTFriendListModel *)model
{
    RMTLevelDetaiListModel *model1 = [model.levelDetaiList objectAtIndex:0];
    
    self.one_titleLabel.text = model1.levelName;
    self.one_rewardLabel.text =[NSString stringWithFormat:@"奖励 %@",model1.rewardRatio];
    self.one_friend_number.text = [NSString stringWithFormat:@"%@人",model1.contactsSum];
    self.one_moneyLabel.text = [NSString stringWithFormat:@"收益 ¥ %.1f",[model1.profitPer floatValue]];
    
     RMTLevelDetaiListModel *model2 = [model.levelDetaiList objectAtIndex:1];
    
    self.two_titleLabel.text = model2.levelName;
    self.two_rewardLabel.text =[NSString stringWithFormat:@"奖励 %@",model2.rewardRatio];
    self.two_friend_number.text = [NSString stringWithFormat:@"%@人",model2.contactsSum];
    self.two_moneyLabel.text = [NSString stringWithFormat:@"收益 ¥ %.1f",[model2.profitPer floatValue]];
    
     RMTLevelDetaiListModel *model3 = [model.levelDetaiList objectAtIndex:2];
    
    self.three_titleLabel.text = model3.levelName;
    self.three_rewardLabel.text =[NSString stringWithFormat:@"奖励 %@",model3.rewardRatio];
    self.three_friend_number.text = [NSString stringWithFormat:@"%@人",model3.contactsSum];
    self.three_moneyLabel.text = [NSString stringWithFormat:@"收益 ¥ %.1f",[model3.profitPer floatValue]];

}






@end
