//
//  RMTHomePageHealthCarThreeTableViewCell.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHomePageHealthCarThreeTableViewCell.h"
#import "RMTHomepageModel.h"
#import "RMTAdModel.h"

@implementation RMTHomePageHealthCarThreeTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

/**
 创建UI
 */
- (void)createUI
{
    
    CGFloat itemH = itemW *(250/190.0f);

    for (NSInteger i = 0; i < 3; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 +(itemW+ 7.5)*i, 10, itemW, itemH)];
        imageView.layer.borderWidth = 1;
        imageView.tag = 100 +i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.layer.borderColor = [UIColorFromRGB(0xEBEBEB) CGColor];
        [self.contentView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTouchAction:)];
        [imageView addGestureRecognizer:tap];
    }
}
- (void)setModel:(RMTHomepageModel *)model
{
    
    _model = model;
    if (!model) {
        return;
    }
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:i + 100];
        
        RMTAdModel *adModel = [model.adResponseList objectAtIndexedSubscript:i + 6];
         [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImg] placeholderImage:[UIImage imageNamed:@"defult_health_small"]];
    }

}

- (void)imageTouchAction:(UITapGestureRecognizer *)tap
{
    
    if (self.touchImageViewAction) {
        self.touchImageViewAction(0,nil);
    }
    
}
@end
