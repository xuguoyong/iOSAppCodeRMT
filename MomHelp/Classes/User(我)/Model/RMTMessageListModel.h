//
//  RMTMessageListModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTMessageListModel : NSObject

@property (nonatomic,strong) NSString *content ;//= "<p>ceshi</p>";
@property (nonatomic,strong) NSString *createdAt;// = 1476683932000;
@property (nonatomic,strong) NSString *date;// = "2016-10-17 13:58:52";
@property (nonatomic,strong) NSString *noticeId;// = 8a80cb8157d137180157d138a4210000;
@property (nonatomic,strong) NSString *status;// = 0;
@property (nonatomic,strong) NSString *title;// = ceshi;
@property (nonatomic,strong) NSString *type;// = message;
@end
