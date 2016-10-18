//
//  RMTTitianViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTTitianViewController.h"

@interface RMTTitianViewController ()
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouxufeiLabel;

@property (weak, nonatomic) IBOutlet UITextField *tixianTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation RMTTitianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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


- (IBAction)completeButtonClick:(id)sender {
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
