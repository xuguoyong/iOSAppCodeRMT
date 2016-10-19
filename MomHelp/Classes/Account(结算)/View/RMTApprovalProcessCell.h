//
//  RMTApprovalProcessCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTApprovalProcessCell : UITableViewCell
//审核中的小圈圈
@property (weak, nonatomic) IBOutlet UIImageView *ToExamineImageView;
//打款中的小圈圈
@property (weak, nonatomic) IBOutlet UIImageView *pendingMoneyImageView;
//已打款中的小圈圈
@property (weak, nonatomic) IBOutlet UIImageView *alreadyMoneyImageView;
//左边的线
@property (weak, nonatomic) IBOutlet UIView *leftProgressView;
//右边的线
@property (weak, nonatomic) IBOutlet UIView *rightProgressView;
@property (weak, nonatomic) IBOutlet UILabel *firstDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstStauteLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoStauteLabel;

@property (weak, nonatomic) IBOutlet UILabel *threeStauteLabel;

@property (weak, nonatomic) IBOutlet UIView *remarkBgView;

@property (weak, nonatomic) IBOutlet UILabel *shenheLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;


@end
