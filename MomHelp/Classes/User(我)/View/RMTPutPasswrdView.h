//
//  RMTPutPasswrdView.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTPutPasswrdView : UIView
@property (weak, nonatomic) IBOutlet UIView *passwdBgView;
@property (nonatomic,strong) NSMutableString *passwd;

@property (nonatomic,strong) void(^userHasPutPassWord)(NSString *passwd);
-(void)showInWindow;

@end
