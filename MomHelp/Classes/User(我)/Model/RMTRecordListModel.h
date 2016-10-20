//
//  RMTRecordListModel.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMTRecordListModel : NSObject
@property (nonatomic,strong) NSMutableArray *covers;
@property (nonatomic,strong) NSMutableArray *remark;
@property (nonatomic,strong) NSString *createdAt;// = 1474508251000;
@property (nonatomic,strong) NSString *healthRecordId;// = 2c918082574ccdbf01574f8a5fec0033;
@property (nonatomic,strong) NSString *recordDate;/// = "2016-09-22";
@property (nonatomic,strong) NSString *type;// = caseFile;
@property (nonatomic,strong) NSString *used;// = 1;
@property (nonatomic,strong) NSString *userId;// = 2c918082574ccdbf01574d4faf4a0018;

@end
