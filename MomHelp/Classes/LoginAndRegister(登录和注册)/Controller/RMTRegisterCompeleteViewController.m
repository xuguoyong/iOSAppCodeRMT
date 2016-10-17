//
//  RMTRegisterCompeleteViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTRegisterCompeleteViewController.h"

#define leftTimeLong 60

@interface RMTRegisterCompeleteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *messageCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int leftTime;

@end

@implementation RMTRegisterCompeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.leftTime = leftTimeLong;
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self addTime];
}

- (void)addTime
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(uploadTimeButtonTitle) userInfo:nil repeats:YES];
    [self.timer fire];

}
- (void)removeTime
{
    [self.timer invalidate];
    self.timer = nil;
    self.leftTime = leftTimeLong;
}
- (void)uploadTimeButtonTitle
{
    self.leftTime = self.leftTime -1;
    if (self.leftTime == 0) {
       [self.timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.leftTime = leftTimeLong;
         self.timeButton.enabled = YES;
        [self removeTime];
    }else
    {
        [self.timeButton setTitle:[NSString stringWithFormat:@"%d秒后重发",self.leftTime] forState:UIControlStateNormal];
       
        self.timeButton.enabled = NO;
    }


}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     self.leftTime = leftTimeLong;
    [self removeTime];
}
- (IBAction)timeButtonClick:(UIButton *)sender {
    //到后台回获取验证码
   
    if (!self.mobile) {
        return;
    }
    __weak typeof(self)weakself = self;
    [RMTDataService postDataWithURL:POST_GetMesssageCode parma:@{@"mobile":self.mobile} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"验证码发送成功"];
        [weakself addTime];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}
- (IBAction)completeButtonClick:(UIButton *)sender {
    
    __weak typeof(self)weakself = self;
    if (self.messageCodeTextField.text.length<=0) {
        [SGShowMesssageTool showMessage:@"请输入验证码"];
        return;
    }
    NSMutableDictionary *parma = [[NSMutableDictionary alloc] init];
    [parma setValue:self.mobile forKey:@"mobile"];
     [parma setValue:self.passwd forKey:@"password"];
     [parma setValue:self.messageCodeTextField.text forKey:@"captcha"];
    
    [RMTDataService postDataWithURL:POST_Register parma:parma showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        [weakself.navigationController popToRootViewControllerAnimated:YES];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)dealloc
{
    [self removeTime];
}

@end
