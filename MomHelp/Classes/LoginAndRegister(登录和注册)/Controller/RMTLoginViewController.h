//
//  RMTLoginViewController.h
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseViewController.h"

@interface RMTLoginViewController : SGBaseViewController
//用户登陆成功之后会调用的回调
@property (nonatomic,strong) void (^userLoginSuccessBlock)(id data);

@end
