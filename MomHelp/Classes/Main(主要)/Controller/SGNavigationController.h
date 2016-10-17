//
//  SGNavigationController.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGNavigationController : UINavigationController
/**
 *  右边按钮的点击事件
 *
 *  @param bar
 */
- (void)leftButtonClickToback:(UIBarButtonItem *)bar;
@end
