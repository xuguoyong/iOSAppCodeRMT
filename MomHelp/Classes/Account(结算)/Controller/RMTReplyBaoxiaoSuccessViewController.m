//
//  RMTReplyBaoxiaoSuccessViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/21.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTReplyBaoxiaoSuccessViewController.h"

@interface RMTReplyBaoxiaoSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *homePageButton;
@property (weak, nonatomic) IBOutlet UIButton *accountButton;

@end

@implementation RMTReplyBaoxiaoSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请成功";
    self.homePageButton.layer.borderWidth = 0.5f;
    self.homePageButton.layer.borderColor = MainColor.CGColor;
    self.homePageButton.layer.cornerRadius = 5.0f;
    self.homePageButton.layer.masksToBounds = YES;
    
    self.accountButton.layer.borderWidth = 0.5f;
    self.accountButton.layer.borderColor = MainColor.CGColor;
    self.accountButton.layer.cornerRadius = 5.0f;
    self.accountButton.layer.masksToBounds = YES;
    
 
}
- (void)leftButtonClickToback:(UIBarButtonItem *)bar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender == self.homePageButton) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabbarItem object:nil userInfo:@{@"index":@"0"}];
    }else
    {
        [self leftButtonClickToback:nil];
    }
}


@end
