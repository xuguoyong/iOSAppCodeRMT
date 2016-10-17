//
//  RMTForgotPasswdViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTForgotPasswdViewController.h"
#import "RMTRegisPasswdViewController.h"
@interface RMTForgotPasswdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation RMTForgotPasswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
}

- (IBAction)nextButtonClick:(UIButton *)sender {
    //判断手机号码
    if (![RMTTool isMobilePhoneNumberRegex:self.phoneNumberTextField.text]) {
        [SGShowMesssageTool showMessage:@"请输入正确的手机号码"];
        return;
    }
    
    //到后台回获取验证码
    __weak typeof(self)weakself = self;
    [RMTDataService postDataWithURL:POST_GetMesssageCode parma:@{@"mobile":self.phoneNumberTextField.text} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"验证码发送成功"];
        
        RMTRegisPasswdViewController *regis = [[RMTRegisPasswdViewController alloc] initWithNibName:@"RMTRegisPasswdViewController" bundle:nil];
        regis.mobile = self.phoneNumberTextField.text;
        [weakself.navigationController pushViewController:regis animated:YES];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
  
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
