//
//  RMTFriendListModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTFriendListModel : NSObject



@property (nonatomic,strong) NSString *headUrl ;// "customer/2c918082574ccdbf01574d4faf4a0018/1476413930381";
@property (nonatomic,strong) NSString *nick ;// "\U8001\U738b";
@property (nonatomic,strong) NSString *questions ;// "https://m.91stjk.com/detail/questions.html";
@property (nonatomic,strong) NSString *share ;// "https://m.91stjk.com/detail/share/share_2.html";
@property (nonatomic,strong) NSString *sumContacts ;// 3;
@property (nonatomic,strong) NSString *sumProfit ;// 0;
@property (nonatomic,strong) NSString *userId ;// 2c918082574ccdbf01574d4faf4a0018;
@property (nonatomic,strong) NSMutableArray *myNewPeopList ;//
@property (nonatomic,strong) NSMutableArray *levelDetaiList ;//         (
//                          {

//                          },
//                          {
//                              contactsSum ;// 1;
//                              levelIndex ;// 2;
//                              levelName ;// "\U4e8c\U7ea7\U4eba\U8109";
//                              profitPer ;// 0;
//                              rewardRatio ;// "1.0%";
//                          },
//                          {
//                              contactsSum ;// 0;
//                              levelIndex ;// 3;
//                              levelName ;// "\U4e09\U7ea7\U4eba\U8109";
//                              profitPer ;// 0;
//                              rewardRatio ;// "3.0%";
//                          }
//                          );
//@property (nonatomic,strong) NSString *myNewPeopList ;//         (
//                         {
//                             date ;// "2016-10-08 11:13:49";
//                             headUrl ;// "customer/2c918082574ccdbf01574fa7e0f80048/1475892571928";
//                             levelIndex ;// 2;
//                             levelName ;// "\U4e8c\U7ea7\U4eba\U8109";
//                             nick ;// "\U6881\U548f\U742a";
//                         },
//                         {
//                             date ;// "2016-09-30 10:35:15";
//                             headUrl ;// "customer/2c9180835756b403015764203a8b0119/1474958509160";
//                             levelIndex ;// 1;
//                             levelName ;// "\U4e00\U7ea7\U4eba\U8109";
//                             nick ;// "\U82cf\U6253\U7eff";
//                         },
//                         {
//                             date ;// "2016-09-27 09:25:28";
//                             headUrl ;// "customer/2c91808357665c510157693f2292001b/1474940055222";
//                             levelIndex ;// 1;
//                             levelName ;// "\U4e00\U7ea7\U4eba\U8109";
//                             nick ;// "\U5218\U5c0f\U73b2";
//                         }
//                         );
//
@end
