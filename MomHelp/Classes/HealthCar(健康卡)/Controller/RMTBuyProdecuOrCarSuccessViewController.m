//
//  RMTBuyProdecuOrCarSuccessViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/21.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTBuyProdecuOrCarSuccessViewController.h"

@interface RMTBuyProdecuOrCarSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation RMTBuyProdecuOrCarSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购买成功";
    self.completeButton.layer.cornerRadius = 5.0f;
    self.completeButton.layer.masksToBounds = YES;
    self.completeButton.layer.borderWidth = 0.5f;
    self.completeButton.layer.borderColor = MainColor.CGColor;
}

- (IBAction)compeleteButtonClick:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)leftButtonClickToback:(UIBarButtonItem *)bar
{
     [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
