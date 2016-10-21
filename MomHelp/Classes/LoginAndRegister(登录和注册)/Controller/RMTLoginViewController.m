//
//  RMTLoginViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTLoginViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "RMTRegisterViewController.h"
#import "RMTForgotPasswdViewController.h"

@interface RMTLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNUumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswdButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation RMTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"view_leftAndBack_white_icon" highImageName:@"view_leftAndBack_white_icon" target:self action:@selector(loginVCleftButtonClickToback)];
    NSString *mobile = [[NSUserDefaults standardUserDefaults] objectForKey:@"mobile"];
    if (mobile) {
        self.phoneNUumberTextField.text = mobile;
    }

}

- (void)loginVCleftButtonClickToback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 所有按钮的点击事件

 @param sender 
 */
- (IBAction)allButtonClick:(UIButton *)sender {
     [self.view endEditing:YES];
    if (sender == self.loginButton/*登录按钮*/) {
        [self loginButtonClick:sender];
    }else if (sender == self.registerButton/*注册按钮*/)
    {
        RMTRegisterViewController *reg = [[RMTRegisterViewController alloc] init];
        [self.navigationController pushViewController:reg animated:YES];
        
    }else/*忘记密码*/
    {
        RMTForgotPasswdViewController *forgot = [[RMTForgotPasswdViewController alloc] init];
        [self.navigationController pushViewController:forgot animated:YES];
    }
    
}

- (void)loginButtonClick:(UIButton *)sender
{
    
    
    //判断手机号码
    if (![RMTTool isMobilePhoneNumberRegex:self.phoneNUumberTextField.text]) {
        [SGShowMesssageTool showMessage:@"请输入正确的手机号码"];
        return;
    }
   if (self.passwdTextField.text.length <= 0)
    {
        [SGShowMesssageTool showMessage:@"请输入密码"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:self.phoneNUumberTextField.text forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [RMTDataService postDataWithURL:POST_Login parma:@{@"mobile":self.phoneNUumberTextField.text,@"password":self.passwdTextField.text} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSString *token = [[responseObj objectForKey:@"data"] objectForKey:@"access_token"];
        [RMTUserInfoModel  saveAccessToken:token];
        [self loginVCleftButtonClickToback];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationUserLoginSuccess object:nil];
        if (self.userLoginSuccessBlock) {
            self.userLoginSuccessBlock(nil);
        }
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        NSLog(@"%@",error);
    }];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}





@end
