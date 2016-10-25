//
//  RMTTiXianSuccessViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTiXianSuccessViewController.h"
#import "RMTMoneyViewController.h"
@interface RMTTiXianSuccessViewController ()

@end

@implementation RMTTiXianSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现成功";
    self.homePageButton.layer.borderWidth = 0.5f;
    self.homePageButton.layer.borderColor = MainColor.CGColor;
    self.homePageButton.layer.cornerRadius = 5.0f;
    self.homePageButton.layer.masksToBounds = YES;
    
    self.moneyButton.layer.borderWidth = 0.5f;
    self.moneyButton.layer.borderColor = MainColor.CGColor;
    self.moneyButton.layer.cornerRadius = 5.0f;
    self.moneyButton.layer.masksToBounds = YES;
    
     self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"view_leftAndBack_white_icon" highImageName:@"view_leftAndBack_white_icon" target:self action:@selector(leftButtonClickTobackSuccess:)];

    
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender == self.homePageButton) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationChangeTabbarItem object:nil userInfo:@{@"index":@"0"}];
    }else
    {
        [self leftButtonClickTobackSuccess:nil];
    }

}
- (void)leftButtonClickTobackSuccess:(UIBarButtonItem *)bar
{

    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[RMTMoneyViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    
}
@end
