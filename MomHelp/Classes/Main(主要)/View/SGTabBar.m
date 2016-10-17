//
//  SGTabBar.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGTabBar.h"

@implementation SGTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.backgroundImage = [UIImage imageNamed:@"tabbar_background_image"];
        
       
    }
    return self;
}


/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}



/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }
}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
//    // 计算button的尺寸
//    CGFloat buttonW = self.width / (self.items.count + 1);
//    CGFloat buttonH = self.height;
//    
//    tabBarButton.width = buttonW;
//    tabBarButton.height = buttonH;
//    tabBarButton.x = buttonW * index;
//    if (index >= 2) {
//        tabBarButton.x = buttonW * (index + 1);
//    } else {
//        tabBarButton.x = buttonW * index;
//    }
//    tabBarButton.y = -20;
}


@end
