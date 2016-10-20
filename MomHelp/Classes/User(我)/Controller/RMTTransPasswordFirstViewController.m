//
//  RMTTransPasswordFirstViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTransPasswordFirstViewController.h"

@interface RMTTransPasswordFirstViewController ()
@property (weak, nonatomic) IBOutlet UITextField *transPassordTextField;
@property (weak, nonatomic) IBOutlet UITextField *comfirTransPasswdTextField;

@end

@implementation RMTTransPasswordFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易密码";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)commitButtonClick:(id)sender {
}


@end
