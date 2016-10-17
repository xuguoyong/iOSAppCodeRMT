//
//  XGYLabel.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "XGYLabel.h"
/**
 *  可点击字体的默认颜色
 */
#define attributedTextDefaultColor [UIColor redColor]
/**
 *  可点击字体的点击时候的颜色
 */
#define attributedTextHightLightColor [UIColor lightGrayColor]
/**
 *  可点击字体点击时候的背景颜色
 */
#define attributedTextHightLightBackgroundColor [UIColor greenColor]



@implementation XGYLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.lineSpacing = 6.0f;
        self.backgroundColor = [UIColor clearColor];
        self.font = [UIFont systemFontOfSize:17.0f];
        self.dataDetectorTypes = MLDataDetectorTypeNone;
        self.linkTextAttributes =  @{NSForegroundColorAttributeName:attributedTextDefaultColor};
        self.activeLinkTextAttributes = @{NSForegroundColorAttributeName:attributedTextHightLightColor,NSBackgroundColorAttributeName:attributedTextHightLightBackgroundColor};
        self.isAttributedContent = YES;
        
        
        
    }
    return self;
}
@end
