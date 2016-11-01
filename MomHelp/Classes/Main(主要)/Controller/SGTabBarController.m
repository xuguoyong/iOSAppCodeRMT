//
//  SGTabBarController.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGTabBarController.h"
#import "SGTabBar.h"
#import "RMTHomePageViewController.h"
#import "RMTHealthCarViewController.h"
#import "SGNavigationController.h"
#import "RMTUserInfoViewController.h"
#import "SGControllerTool.h"

//原结算界面
//#import "RMTAccountViewController.h"
//更改为商城界面
#import "RMTShopMainViewController.h"


@interface SGTabBarController () <UITabBarControllerDelegate>
@property (nonatomic,assign) int currentIndex;
@property (nonatomic,assign) int lastSelectIndex;
@end

@implementation SGTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    //改变tabbar 线条颜色
    [self setTBbarSeperateColor];
    // 添加所有的子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
    self.lastSelectIndex = 0;
}

/**
 *  设置tabbar线条的颜色
 */
- (void)setTBbarSeperateColor
{
   
    [self.tabBar setShadowImage:[UIImage imageNamed:@"tabbar_separte"]];
    
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
   // SGTabBar *customTabBar = [[SGTabBar alloc] init];
//    customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
   // [self setValue:customTabBar forKeyPath:@"tabBar"];
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background_image"];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    
   
    RMTHomePageViewController *homePage = [[RMTHomePageViewController alloc] init];
  
    [self addOneChlildVc:homePage title:@"首页" imageName:@"homePage_normal" selectedImageName:@"homePage_selected"];
    
    self.delegate = self;
    RMTHealthCarViewController *health = [[RMTHealthCarViewController alloc] init];
    [self addOneChlildVc:health title:@"购物卡" imageName:@"health_nomal" selectedImageName:@"health_selected"];

#pragma mark --原结算界面 更改为商城界面
//    RMTAccountViewController *account = [[RMTAccountViewController alloc] init];
//    [self addOneChlildVc:account title:@"结算" imageName:@"account_normal" selectedImageName:@"account_selected"];
    RMTShopMainViewController *account = [[RMTShopMainViewController alloc] init];
       [self addOneChlildVc:account title:@"商城" imageName:@"account_normal" selectedImageName:@"account_selected"];

    RMTUserInfoViewController *me = [[RMTUserInfoViewController alloc] init];
    [self addOneChlildVc:me title:@"我" imageName:@"User_normal" selectedImageName:@"User_selected"];

}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x868686);
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem  setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = UIColorFromRGB(0x0FC3DC);
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
     SGNavigationController*nav = [[SGNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    self.lastSelectIndex = (int)self.selectedIndex;
    
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    //处理未登录的时候需要跳转到登录界面
//    if ((tabBarController.selectedIndex == 2 || tabBarController.selectedIndex == 3) && ![RMTUserInfoModel isUserLogin]) {
//        [self setSelectedIndex:self.lastSelectIndex];
//        [SGControllerTool popToLoginControllerTarget:self loginSuccessBlock:^(id data) {
//            
//        }];
//    }
    
    if ((tabBarController.selectedIndex == 3) && ![RMTUserInfoModel isUserLogin]) {
        [self setSelectedIndex:self.lastSelectIndex];
        [SGControllerTool popToLoginControllerTarget:self loginSuccessBlock:^(id data) {
            
        }];
    }
    
    
    
}




@end
