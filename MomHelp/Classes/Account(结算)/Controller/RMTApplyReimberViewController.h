//
//  RMTApplyReimberViewController.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseViewController.h"
#import "RMTReimburListModel.h"
@interface RMTApplyReimberViewController : SGBaseViewController
@property (nonatomic,strong) NSString *accountMoney;
@property (nonatomic,strong) NSString *healthCarMoney;
@property (nonatomic,strong) NSString *jiesuanMoney;
@property (nonatomic,strong) NSString *putMoney;

@property (nonatomic,strong) void (^aplyjisuanSuccess)(id data);
@end
