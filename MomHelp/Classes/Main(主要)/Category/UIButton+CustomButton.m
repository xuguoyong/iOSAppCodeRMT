//
//  UIButton+CustomButton.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)

/**
 *  快速创建一个正常状态下的按钮
 *
 *  @param buttonTitle     按钮的标题
 *  @param titleFont       按钮标题的字体
 *  @param titleColor      按钮标题的字体颜色
 *  @param image           按钮的图片
 *  @param backgroundImage 按钮的背景图片
 *  @param target          点击事件对象
 *  @param action          点击事件
 *  @param backgroundColor 按钮的背景颜色
 *
 *  @return 返回创建好的按钮
 */
+(UIButton *)custombuttonNormalStateWithTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor clickThingTarget:(id)target action:(SEL)action
{
    //创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮的标题
    if (buttonTitle) {[button setTitle:buttonTitle forState:UIControlStateNormal];}
    //设置按钮的字体
    if (titleFont) {button.titleLabel.font = titleFont;}
    //设置按钮的字体颜色
    if (titleColor) { [button setTitleColor:titleColor forState:UIControlStateNormal];}
    //设置按钮的图标
    if (image) {[button setImage:image forState:UIControlStateNormal];}
    //设置按钮的背景图标
    if (backgroundImage) {[button setBackgroundImage:backgroundImage forState:UIControlStateNormal];}
    //设置按钮背景颜色
    if (backgroundColor) {[button setBackgroundColor:backgroundColor];}
    //设置按钮的点击事件
    if (target && action) {[button addButtonTouchUpInsideTarget:target action:action];}
    return button;
}
/**
 *  设置选中状态下的button的属性
 *
 *  @param buttonTitle
 按钮的标题
 */
+ (UIButton *)setMainButtonWithTitle:(NSString *)buttonTitle clickThingTarget:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton custombuttonNormalStateWithTitile:buttonTitle titleFont:textFont32 titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:action];
    btn.layer.cornerRadius = 5.0f;
    btn.layer.masksToBounds = YES;
    return btn;
    
}
/**
 *  给按钮增加一个点击事件
 *
 *  @param target 时间的对象
 *  @param action 事件
 */
- (void)addButtonTouchUpInsideTarget:(id)target action:(SEL)action
{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

}


/**
 *  设置正常状态下的button的属性
 *
 *  @param buttonTitle     按钮的标题
 *  @param titleFont       按钮的标题字号
 *  @param titleColor      按钮标题的颜色
 *  @param image           按钮的图片
 *  @param backgroundImage 按钮的背景图片
 *  @param target          事件对象
 *  @param action          事件
 */
- (void)setButtonNormalStateTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage clickThingTarget:(id)target action:(SEL)action
{

    //设置按钮的标题
    if (buttonTitle) {[self setTitle:buttonTitle forState:UIControlStateNormal];}
    //设置按钮的字体
    if (titleFont) {self.titleLabel.font = titleFont;}
    //设置按钮的字体颜色
    if (titleColor) { [self setTitleColor:titleColor forState:UIControlStateNormal];}
    //设置按钮的图标
    if (image) {[self setImage:image forState:UIControlStateNormal];}
    //设置按钮的背景图标
    if (backgroundImage) {[self setBackgroundImage:backgroundImage forState:UIControlStateNormal];}
    //设置按钮的点击事件
    if (target && action) {[self addButtonTouchUpInsideTarget:target action:action];}
    

}

/**
 *  设置选中状态下的button的属性
 *
 *  @param buttonTitle     按钮的标题
 *  @param titleFont       按钮的标题字号
 *  @param titleColor      按钮标题的颜色
 *  @param image           按钮的图片
 *  @param backgroundImage 按钮的背景图片
 *  @param target          事件对象
 *  @param action          事件
 */
- (void)setButtonSelectStateTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage clickThingTarget:(id)target action:(SEL)action
{

    //设置按钮的标题
    if (buttonTitle) {[self setTitle:buttonTitle forState:UIControlStateSelected];}
    //设置按钮的字体
    if (titleFont) {self.titleLabel.font = titleFont;}
    //设置按钮的字体颜色
    if (titleColor) { [self setTitleColor:titleColor forState:UIControlStateSelected];}
    //设置按钮的图标
    if (image) {[self setImage:image forState:UIControlStateSelected];}
    //设置按钮的背景图标
    if (backgroundImage) {[self setBackgroundImage:backgroundImage forState:UIControlStateSelected];}
    //设置按钮的点击事件
    if (target && action) {[self addButtonTouchUpInsideTarget:target action:action];}
}
@end
