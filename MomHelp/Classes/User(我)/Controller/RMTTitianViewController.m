//
//  RMTTitianViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTitianViewController.h"
#import "RMTPutPasswrdView.h"
#import "RMTTiXianSuccessViewController.h"
@interface RMTTitianViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLabel;

@property (weak, nonatomic) IBOutlet UITextField *tixianTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation RMTTitianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xebebeb);
    self.title = @"提现";
    
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.allMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",self.dataModel.balance];
    
    self.accountLabel.text =[NSString stringWithFormat:@"%@(%@)",self.dataModel.certificationName,self.dataModel.bankCard] ;
    self.shouxufeiLabel.text = [NSString stringWithFormat:@"手续费%.1f%%",[self.dataModel.poundage floatValue]*100];
    self.tipLabel.text = [NSString stringWithFormat:@"收取%.1f%%手续费，实际提现%.2f",[self.dataModel.poundage floatValue]*100,([self.tixianTextField.text intValue] *[self.dataModel.poundage floatValue])];
    self.tixianTextField.delegate = self;
   
}

#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
      
        if (isiPhone4 || isiPhone5) {
         self.view.transform = CGAffineTransformMakeTranslation(0, - 120);
        }
        
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![RMTTool isNumberRegex:string]) {
        return NO;
    }
    self.tipLabel.text = [NSString stringWithFormat:@"收取%.1f%%手续费，实际提现%.2f",[self.dataModel.poundage floatValue]*100,([self.tixianTextField.text intValue] *( 1- [self.dataModel.poundage floatValue])*10)];
    
    return YES;
}
- (IBAction)completeButtonClick:(id)sender {
    
    [self.view endEditing:YES];
    if ([self.tixianTextField.text intValue]%100 != 0  ||self.tixianTextField.text.length == 0) {
        [SGShowMesssageTool showMessage:@"提现金额只能是100的整数倍"];
        return;
    }
    
    
    
    RMTPutPasswrdView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMTPutPasswrdView" owner:nil options:nil]firstObject];
    __weak typeof(view)weakView = view;
    __weak typeof(self)weakself =self;
        [view showInWindow];
    view.userHasPutPassWord = ^(NSString *passwd)
    {
      
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself tixianAcitonWithPasswd:passwd];
        });
        
        
        [UIView animateWithDuration:0.25 animations:^{
            weakView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [weakView removeFromSuperview];
        }];
        
        
    };


    
    
    
    
}


#pragma mark ====输入密码后提现会调用的方法
-(void)tixianAcitonWithPasswd:(NSString *)passwd
{
    
   
    __weak typeof(self)weakself =self;
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    parmeters[@"money"] = self.tixianTextField.text;
    parmeters[@"tradePassword"] = passwd;
    [RMTDataService postDataWithURL:POST_Extract_Money parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        dispatch_async(dispatch_get_main_queue(), ^{
            RMTTiXianSuccessViewController *tixian = [[RMTTiXianSuccessViewController alloc] initWithNibName:@"RMTTiXianSuccessViewController" bundle:nil];
            [self.navigationController pushViewController:tixian animated:YES];
            
            if (self.tixianLater) {
                self.tixianLater(nil);
            }
            [weakself.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [SGShowMesssageTool showMessage:@"提现失败，请稍后重试~"];
   
    }];

}




- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
