//
//  RMTShareAppViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTShareAppViewController.h"
#define itemW ((d_screen_width - 50)/5.0f)
@interface RMTShareAppViewController ()

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong)UIButton *cancelButton;



@end

@implementation RMTShareAppViewController

- (UIView *)bgView
{
    if (!_bgView) {
       
        
         _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, d_screen_height - (itemW + 157), d_screen_width, (itemW+ 157))];
        _bgView.backgroundColor = [UIColor whiteColor];
        
        self.cancelButton = [UIButton custombuttonNormalStateWithTitile:@"取消" titleFont:textFont36 titleColor:[UIColor redColor] butttonImage:nil backgroundImage:nil backgroundColor:[UIColor whiteColor] clickThingTarget:self action:@selector(cancelButtonClick:)];
        self.cancelButton.frame = CGRectMake(0, _bgView.height - 50, d_screen_width, 50);
        [_bgView addSubview:self.cancelButton];
        
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, d_screen_width, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = UIColorFromRGB(0x979797);
        label.text = @"分享到";
        [_bgView addSubview:label];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.cancelButton.y - 15, d_screen_width, 15)];
        line.backgroundColor = UIColorFromRGB(0xEBEDEC);
        [_bgView addSubview:line];
        
        NSArray *arr = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"新浪"];
        NSArray *imageNameArr = @[@"share_wechat_icon",@"share_friend_icon",@"share_QQ_icon",@"share_QQKongjian_icon",@"share_weibo_icon"];
        for (NSInteger i = 0; i < 5; i ++) {
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5 + i *(itemW + 10), line.y - 21-10, itemW, 21)];
            label1.textAlignment = NSTextAlignmentCenter;
            label1.textColor = UIColorFromRGB(0x000000);
            label1.font = [UIFont systemFontOfSize:15.0f];
            label1.text = [arr objectAtIndex:i];
            [_bgView addSubview:label1];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 + i *(itemW + 10), CGRectGetMaxY(label.frame) + 20, itemW, itemW)];
            [_bgView addSubview:imageView];
            imageView.image = [UIImage imageNamed:imageNameArr[i]];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareImageViewTouchAction:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
          
       }
        
    }
    return _bgView;
}


- (void)shareImageViewTouchAction:(UITapGestureRecognizer *)tap
{

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[touches allObjects] lastObject];
    if (![touch.view isKindOfClass:[UIImageView class]]) {
     [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
-(void)cancelButtonClick:(UIButton *)sender
{
     [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.bgView];

}



@end
