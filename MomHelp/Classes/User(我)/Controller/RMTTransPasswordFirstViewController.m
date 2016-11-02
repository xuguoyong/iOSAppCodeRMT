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
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)commitButtonClick:(id)sender {

    if (![self.transPassordTextField.text isEqualToString:self.comfirTransPasswdTextField.text]) {
        [SGShowMesssageTool showMessage:@"两次输入的密码不一致，请重新输入"];
        return;
    }
    
    [RMTDataService postDataWithURL:POST_Set_TradePassword parma:@{@"tradePassword":self.comfirTransPasswdTextField.text,@"identityCard":self.carNumber} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
      
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
}


@end
