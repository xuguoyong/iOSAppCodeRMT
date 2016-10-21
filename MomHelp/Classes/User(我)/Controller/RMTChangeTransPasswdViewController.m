//
//  RMTChangeTransPasswdViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTChangeTransPasswdViewController.h"
#define leftTimeLong 60

@interface RMTChangeTransPasswdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int leftTime;
@end

@implementation RMTChangeTransPasswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =UIColorFromRGB(0xebebeb);
    self.title = @"修改交易密码";
    self.leftTime = leftTimeLong;
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)dealloc
{
    [self removeTime];
}
- (IBAction)timeButtonClick:(id)sender {
    
    
    
    
}

- (IBAction)completeButtonClick:(id)sender {
}

@end
