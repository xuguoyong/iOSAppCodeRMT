//
//  RMTMoneyModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTMoneyModel : NSObject


@property (nonatomic,strong) NSString *accountId ;// 2c918082574ccdbf01574d4faf4e0019;
@property (nonatomic,strong) NSString *accountLogType ;// transfer;
@property (nonatomic,strong) NSString *accountLogTypeName ;// "\U8f6c\U8ba9";
@property (nonatomic,strong) NSString *contrUserId ;// "<null>";
@property (nonatomic,strong) NSString *createdAt ;// 1475919683000;
@property (nonatomic,strong) NSString *date ;// "2016-10-08";
@property (nonatomic,strong) NSString *headUrl ;// "<null>";
//@property (nonatomic,strong) NSString *id ;// 2c918084577a62cf0157a3ab1dc23062;
@property (nonatomic,strong) NSString *lastModified ;// 1475919683000;
@property (nonatomic,strong) NSString *money ;// "0.54";
@property (nonatomic,strong) NSString *nick ;// "\U8001\U738b";
@property (nonatomic,strong) NSString *note ;// "<null>";
@property (nonatomic,strong) NSString *status ;// pendingPayment;
@property (nonatomic,strong) NSString *userId ;// 2c918082574ccdbf01574d4faf4a0018;
@property (nonatomic,strong) NSString *userName ;// "<null>";
@property (nonatomic,strong) NSString *withdrawBankCard ;// "<null>";
@property (nonatomic,strong) NSString *withdrawName ;// "<null>";



@property (nonatomic,strong) NSString *balance;// = "0.37";
@property (nonatomic,strong) NSString *bankCard;// = 5516;
@property (nonatomic,strong) NSString *certificationName;// = "\U8d3e**";
//@property (nonatomic,strong) NSString *id = 2c918082574ccdbf01574d4faf4e0019;
//@property (nonatomic,strong) NSString *money;// = "<null>";
@property (nonatomic,strong) NSString *poundage;// = "0.008";
@property (nonatomic,strong) NSString *tradePassword;// = "";

@end
