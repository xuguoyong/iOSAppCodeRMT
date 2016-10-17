//
//  RMTUserInfoTableViewCell.h
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTUserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userNikeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userMobileLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailRLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorimageView;

@end
