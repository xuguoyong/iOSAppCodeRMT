//
//  SGConfigure.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  这个类主要用于设置一些默认属性 比如字体啊 导航栏的颜色 默认的背景颜色等

#ifndef SGConfigure_h
#define SGConfigure_h

// 导航栏标题的字体
#define SGNavigationTitleFont [UIFont systemFontOfSize:21.0f]
//没有网络的时候的提示语
#define SGNotNetWorkingTips @"世界上最遥远的距离就是没有网络~"

//界面的背景颜色
#define viewAndTableViewBackgroundColor UIColorFromRGB(0xEBEBEB)
//分割线颜色
#define tableViewSeparateColor UIColorFromRGB(0xD2D2D2)
//主色调
#define MainColor  UIColorFromRGB(0x0FC3DC)

#define textColor666666 UIColorFromRGB(0x666666)
#define textColor868686 UIColorFromRGB(0x868686)


//字号的对应

#define textFont24 [UIFont systemFontOfSize:16.0f]
#define textFont30 [UIFont systemFontOfSize:18.0f]
#define textFont32 [UIFont systemFontOfSize:19.0f]
#define textFont36 [UIFont systemFontOfSize:20.5f]
#define textFont38 [UIFont systemFontOfSize:21.0f]


#endif /* SGConfigure_h */
