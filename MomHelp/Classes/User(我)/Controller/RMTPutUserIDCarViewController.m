//
//  RMTPutUserIDCarViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/21.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTPutUserIDCarViewController.h"
#import "RMTTransPasswordFirstViewController.h"

#import <AFNetworking.h>

@interface RMTPutUserIDCarViewController ()
@property (weak, nonatomic) IBOutlet UITextField *IDCartextField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation RMTPutUserIDCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交易密码";
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    self.nextButton.layer.cornerRadius = 5.0f;
    self.nextButton.layer.masksToBounds = YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)nextButtonClick:(UIButton *)sender {
    
     [self.view endEditing:YES];
    
    if (![RMTTool checkUserIdCard:self.IDCartextField.text]) {
     
        [SGShowMesssageTool showMessage:@"输入身份证号码有误,请重新输入" showTime:2.0f];
        return;
    }

    
    // 创建请求类
    AFHTTPSessionManager *manager = [self manager];
    
      NSString *allURL = [NSString stringWithFormat:@"%@%@",MainURL,GET_Certification_identityCard];
    [manager GET:allURL parameters:@{@"identityCard":self.IDCartextField.text} progress:^(NSProgress * _Nonnull downloadProgress) {
        // 这里可以获取到目前数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *object = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([object isEqualToString:@"true"]) {
            RMTTransPasswordFirstViewController *pas =[[RMTTransPasswordFirstViewController alloc] initWithNibName:@"RMTTransPasswordFirstViewController" bundle:nil];
            pas.carNumber = self.IDCartextField.text;
            [self.navigationController pushViewController:pas animated:YES];
        }else
        {
            [SGShowMesssageTool showMessage:@"身份证验证失败，请重新输入~"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
   
    
}
/**  获取网络请求的单利*/
-(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //设置响应的数据类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    // 超时时间
    manager.requestSerializer.timeoutInterval = 60.0f;
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 声明获取到的数据格式
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    if (access_token!=nil) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"bearer %@",access_token] forHTTPHeaderField:@"Authorization"];
    }
    return manager;
}



@end
