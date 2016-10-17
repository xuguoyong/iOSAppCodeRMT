//
//  SGShowMesssageTool.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGShowMesssageTool.h"
#import "LoadingHUDView.h"
#import "MBProgressHUD.h"
#import "UIImage+GIF.h"
#import "AFNetworkReachabilityManager.h"

@implementation SGShowMesssageTool
+ (void)initialize
{
    [SVProgressHUD setBackgroundLayerColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.3]];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
}
/**
 *  快速闪现一个提示文字 提示（字数最好不要超过20个字）
 *
 *  @param message 提示文字 默认消失时间为1s
 */
+(void)showMessage:(NSString *)message
{
    
  
    [self showMessage:message showTime:1.0f];


}
/**
 *  闪现一个提示文字
 *
 *  @param message  提示文字
 *  @param showTime 文字显示时间
 */

static XGYLabel *showMessageLabel_;
+ (void)showMessage:(NSString *)message showTime:(CGFloat)showTime
{

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window viewWithTag:1000000000000]/*上一个Label没有消失之前不予许显示下一个提示*/) {
        return;
    }
   
    if (showMessageLabel_ == nil) {
        showMessageLabel_= [[XGYLabel alloc] init];
        showMessageLabel_.lineSpacing = 1.0f;
        showMessageLabel_.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.65];
        showMessageLabel_.textColor = [UIColor whiteColor];
        
        showMessageLabel_.layer.cornerRadius = 5.0f;
        showMessageLabel_.numberOfLines = 0;
        showMessageLabel_.clipsToBounds = YES;
        showMessageLabel_.textInsets = UIEdgeInsetsMake(5, 10, 5, 10);
        showMessageLabel_.textAlignment  = NSTextAlignmentCenter;
        showMessageLabel_.font = [UIFont systemFontOfSize:14.0f];
        showMessageLabel_.width =d_screen_width-10.0f*2;
  }
    showMessageLabel_.text = message;
  
    [showMessageLabel_ sizeToFit];
    [window addSubview:showMessageLabel_];
    [window bringSubviewToFront:showMessageLabel_];
    showMessageLabel_.tag = 1000000000000;
    showMessageLabel_.center = window.center;
    showMessageLabel_.alpha = 0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        showMessageLabel_.alpha = 1.0f;
    }];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(showTime/*延迟执行时间*/ * NSEC_PER_SEC));
    __weak typeof(self)weakself = self;
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
       [weakself hideMeesageLabelWithView:showMessageLabel_];
    });
  
}
/**
 *  隐藏显示的文字
 *
 *  @param view
 */
+(void)hideMeesageLabelWithView:(UIView *)view
{
    
    [UIView animateWithDuration:0.25 animations:^{
        view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
   
    }];

}

/**
 *  在View上显示正在加载的动画
 */

+ (void)showLoadingHUD
{
   
    
    [SVProgressHUD show];
   
    
}
/**
 *  在View上显示正在加载的动画
 */

+ (void)showLoadingHUDWithErrorMessage:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD showErrorWithStatus:message];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f/*延迟执行时间*/ * NSEC_PER_SEC));
  
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
       [SVProgressHUD dismiss];
    });

}

/**
 *  在View上显示正在加载的动画
 */

+ (void)showLoadingHUDWithSuccessMessage:(NSString *)message
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    
}


/**
 *  隐藏View上正在加载的动画
 */


+ (void)hideLoadingHUD
{
    [SVProgressHUD dismiss];
  
}

/**
 *  判断当前是否有网络
 *
 *  @return
 */
+ (BOOL)isHaveNetWork
{
    NSString *networkState = [[NSUserDefaults standardUserDefaults] objectForKey:@"networkState"];
    if (![networkState isEqualToString:@"haveNetwork"]) {
        return NO;
    }
    
    return YES;
    
}


@end
