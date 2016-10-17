//
//  UIButton+CustomButton.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CustomButton)


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
+(UIButton *)custombuttonNormalStateWithTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage backgroundColor:(UIColor *)backgroundColor clickThingTarget:(id)target action:(SEL)action;

/**
 *  给按钮增加一个点击事件
 *
 *  @param target 时间的对象
 *  @param action 事件
 */
- (void)addButtonTouchUpInsideTarget:(id)target action:(SEL)action;


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
- (void)setButtonNormalStateTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage clickThingTarget:(id)target action:(SEL)action;

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
- (void)setButtonSelectStateTitile:(NSString *)buttonTitle titleFont:(UIFont *)titleFont titleColor:(UIColor *)titleColor butttonImage:(UIImage *)image backgroundImage:(UIImage *)backgroundImage clickThingTarget:(id)target action:(SEL)action;

/**
 *  设置选中状态下的button的属性
 *
 *  @param buttonTitle
 按钮的标题
 */
+ (UIButton *)setMainButtonWithTitle:(NSString *)buttonTitle clickThingTarget:(id)target action:(SEL)action;
@end
