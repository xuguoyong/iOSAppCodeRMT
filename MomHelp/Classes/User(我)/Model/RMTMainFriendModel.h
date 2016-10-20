//
//  RMTMainFriendModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTMainFriendModel : NSObject
@property (nonatomic,strong) NSString *headUrl ;// "customer/2c918082574ccdbf01574d4faf4a0018/1476413930381";
@property (nonatomic,strong) NSString *isHadRecommender ;// 1;
@property (nonatomic,strong) NSString *nick ;// "\U8001\U738b";
@property (nonatomic,strong) NSString *questions ;// "https://m.91stjk.com/detail/questions.html";
@property (nonatomic,strong) NSString *share ;// "https://m.91stjk.com/detail/share/share_2.html";
@property (nonatomic,strong) NSString *sumContacts ;// 3;
@property (nonatomic,strong) NSString *sumProfit ;// 0;
@property (nonatomic,strong) NSString *userId ;// 2c918082574ccdbf01574d4faf4a0018;

@property (nonatomic,strong) NSMutableArray *contrList;
@end
