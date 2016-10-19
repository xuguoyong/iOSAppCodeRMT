//
//  RMTImageViewCollectionViewCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/14.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTImageViewCollectionViewCell.h"
#import "TZImageManager.h"
#import "UIView+Layout.h"

@interface RMTImageViewCollectionViewCell ()
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation RMTImageViewCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
       
        self.imageView.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setImaeViewImage:(UIImage *)image
{
    if (!image) {
        self.imageView.image = [UIImage imageNamed:@"add_icon_white"];
      self.imageView.contentMode = UIViewContentModeCenter;
    }else
    {
       self.imageView.image = image;
         self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
}



//点击查看大图
- (IBAction)showBigPhotoButtonClick:(UIButton *)sender {
    if (self.seeBigPhotoButtonClickBlock) {
        self.seeBigPhotoButtonClickBlock(sender);
    }
}

@end
