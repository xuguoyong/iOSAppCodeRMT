//
//  RMTCarPackageModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTCarPackageModel : NSObject

@property (nonatomic,strong) NSString *totalWorth;
@property (nonatomic,strong) NSString *buyByMonth ;// 1;
@property (nonatomic,strong) NSString *buyByWeek ;// 0;
@property (nonatomic,strong) NSMutableArray *canResaleDate ;//                     (
@property (nonatomic,strong) NSString *canTransferDate;
@property (nonatomic,strong) NSString *cardNo ;// 8101475904992013;
@property (nonatomic,strong) NSString *cardPackageDetail ;// "http://m.91stjk.com/detail/cardbar_detail.html?cardPackageId;//";
@property (nonatomic,strong) NSString *cardPackageId ;// 2c918084577a62cf0157a2caf30d2f5a;
@property (nonatomic,strong) NSMutableArray *cardPackageIncrementResponses ;//                     (

@property (nonatomic,strong) NSMutableArray *covers ;//                     (

@property (nonatomic,strong) NSString *createdAt ;// 1475904992000;
@property (nonatomic,strong) NSString *currentValue ;// "0.1";
@property (nonatomic,strong) NSString *currentValueAndServiceCharge ;// 0;
@property (nonatomic,strong) NSString *currentValueAndServiceChargeTotal ;// 0;
@property (nonatomic,strong) NSString *currentValueTotal ;// "0.1";
@property (nonatomic,strong) NSString *date ;// "2016-10-08 13:36:32";
@property (nonatomic,strong) NSString *dayIncrement ;// 0;
@property (nonatomic,strong) NSString *dayIncrementPercen ;// "0.006666666666666667";
@property (nonatomic,strong) NSString *details ;// "<null>";
@property (nonatomic,strong) NSString *incrementValue ;// 0;
@property (nonatomic,strong) NSString *incrementValueTotal ;// 0;
@property (nonatomic,strong) NSString *level ;// 0;
@property (nonatomic,strong) NSString *monthIncrement ;// "0.2";
@property (nonatomic,strong) NSString *number ;// 1;
@property (nonatomic,strong) NSString *originalBuyDay ;// 1475904992000;
@property (nonatomic,strong) NSString *originalWorth ;// 0;
@property (nonatomic,strong) NSString *productId ;// 2c918082572189800157219ba3b20000;
@property (nonatomic,strong) NSString *resaleDate ;// 1475904992000;
@property (nonatomic,strong) NSString *status ;// increment;
@property (nonatomic,strong) NSString *subTitle ;// "";
@property (nonatomic,strong) NSString *surplusValue ;// 0;
@property (nonatomic,strong) NSString *title ;// "\U5168\U4fdd\U5065\U5eb7\U5361100\U5143";
@property (nonatomic,strong) NSString *transferExpireTime ;// 1474469630000;
@property (nonatomic,strong) NSString *transferTime ;// 1474469630000;
@property (nonatomic,strong) NSString *userId ;// 2c918082574ccdbf01574d4faf4a0018;
@property (nonatomic,strong) NSString *weekIncrement ;// "0.05";
@property (nonatomic,strong) NSString *worth ;// "0.1";
@property (nonatomic,strong) NSString *cashCoupon;

//判断是否是选中
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong) NSString *image;

@end
