//
//  RMTReimburListModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTReimburListModel : NSObject


@property (nonatomic,strong) NSString *alreadyMoneyDate;// ;// "<null>";
@property (nonatomic,strong) NSString *cardNo ;// "<null>";
@property (nonatomic,strong) NSString *cardPackageIds ;// 2c9180835756b4030157652fe3aa0170;
@property (nonatomic,strong) NSString *certificationName ;// "<null>";
@property (nonatomic,strong) NSString *createdAt ;// 1474948259000;
@property (nonatomic,strong) NSString *date ;// "2016-09-27 11:50:59";
@property (nonatomic,strong) NSString *healthRecordId ;// 2c918083575070d6015751a8891f00ab;
@property (nonatomic,strong) NSString *mobile ;// "<null>";
@property (nonatomic,strong) NSString *moneyDate ;// "<null>";
@property (nonatomic,strong) NSString *nike ;// "<null>";
@property (nonatomic,strong) NSString *recordDate ;// "2016-08-21";
@property (nonatomic,strong) NSString *reimbursementId ;// 2c91808357665c51015769c45dbd003d;
@property (nonatomic,strong) NSString *reimbursementWorth ;// "0.1";
@property (nonatomic,strong) NSString *remark ;// "\n\n";
@property (nonatomic,strong) NSString *status ;// audit;
@property (nonatomic,strong) NSString *type ;// medical;
@property (nonatomic,strong) NSString *worth ;// "<null>";

//用于判断是否是选中
@property (nonatomic,assign) BOOL isSelect;


@end
