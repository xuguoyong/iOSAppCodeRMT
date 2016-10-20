//
//  RMTPutPasswrdView.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/19.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTPutPasswrdView.h"

@implementation RMTPutPasswrdView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.passwd = [[NSMutableString alloc] init];
    for (NSInteger i = 500; i < 506; i ++) {
        UIView *view = [self.passwdBgView viewWithTag:i];
        view.hidden = YES;
    }
}


-(void)showInWindow
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0f;
    }];
    
}



- (IBAction)closeButtonClick:(UIButton *)sender {
    
     __weak typeof(self)weakView = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakView removeFromSuperview];
    }];
}

- (IBAction)delectButtonClick:(id)sender {
    
    if (self.passwd.length <= 0) {
        return;
    }
    [self.passwd deleteCharactersInRange:NSMakeRange(self.passwd.length - 1, 1)];    
    for (NSInteger i = 500; i < 506; i ++) {
        UIView *view = [self.passwdBgView viewWithTag:i];
        view.hidden = YES;
    }
    
    
    for (NSInteger i = 0; i < self.passwd.length; i ++) {
        UIView *view = [self.passwdBgView viewWithTag:i+500];
        view.hidden = NO;
    }
    
    
}

- (IBAction)numberPadButtonClick:(UIButton *)sender {

    [self.passwd appendString:[NSString stringWithFormat:@"%d",(int)(sender.tag - 1000)]];
   
    for (NSInteger i = 500; i < 506; i ++) {
        UIView *view = [self.passwdBgView viewWithTag:i];
        view.hidden = YES;
    }
    
    
    for (NSInteger i = 0; i < self.passwd.length; i ++) {
        UIView *view = [self.passwdBgView viewWithTag:i+500];
        view.hidden = NO;
    }
    
    
    if (self.passwd.length ==6) {
        if (self.userHasPutPassWord) {
            self.userHasPutPassWord(self.passwd);
            [self closeButtonClick:nil];
        }
    }
    
    
}



@end
