//
//  RMTRegisterViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTRegisterViewController.h"
#import "RMTRegisterCompeleteViewController.h"
@interface RMTRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation RMTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"注册";
}
- (IBAction)nextButtonClick:(UIButton *)sender {
    //获取验证码
    //判断手机号码
    if (![RMTTool isMobilePhoneNumberRegex:self.phoneNumberTextField.text]) {
        [SGShowMesssageTool showMessage:@"请输入正确的手机号码"];
        return;
    }
    if (self.passwdTextField.text.length <= 0 ||self.passwdTextField.text.length >= 18)
    {
        [SGShowMesssageTool showMessage:@"请输入6~18位数的密码"];
        return;
    }
    
        //到后台回获取验证码
    __weak typeof(self)weakself = self;
    [RMTDataService postDataWithURL:POST_GetMesssageCode parma:@{@"mobile":self.phoneNumberTextField.text} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
      
        RMTRegisterCompeleteViewController *complete = [[RMTRegisterCompeleteViewController alloc] initWithNibName:@"RMTRegisterCompeleteViewController" bundle:nil];
        complete.mobile =weakself.phoneNumberTextField.text;
        complete.passwd =weakself.passwdTextField.text;
        [weakself.navigationController pushViewController:complete animated:YES];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}

- (IBAction)loginButtonClick:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


@end
