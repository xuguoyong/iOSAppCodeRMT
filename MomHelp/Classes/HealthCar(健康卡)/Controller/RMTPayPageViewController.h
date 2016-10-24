//
//  RMTPayPageViewController.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  支付界面

#import "SGBaseViewController.h"

typedef NS_ENUM(NSUInteger,BuyCarType) {
    BuyCarType_trasfer = 100,//转让卡
    BuyCarType_direct_buy//直购
};

@interface RMTPayPageViewController : SGBaseViewController
@property (nonatomic,strong) NSString *numberCar;
@property (nonatomic,strong) NSString *productID;
@property (nonatomic,strong) NSString *trabsferMoney;
@property (nonatomic,strong) NSString *payPassword;
@property (nonatomic,strong) void (^buySccessBlock)(id data);



@property (nonatomic,assign) BuyCarType buyType;
@end
