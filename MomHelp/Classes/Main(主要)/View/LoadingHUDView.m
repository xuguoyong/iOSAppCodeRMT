//
//  LoadingHUDView.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/16.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "LoadingHUDView.h"

@interface LoadingHUDView ()
{
    UIImageView *_animoutionImageView;
}

@end


@implementation LoadingHUDView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        [self setUpAnimoution];
    }
    return self;
}
- (void)setUpAnimoution
{
    _animoutionImageView = [[UIImageView alloc] init];
    _animoutionImageView.backgroundColor = [UIColor clearColor];
    _animoutionImageView.image =[UIImage imageNamed:@"dropdown_anim__0001"];
    _animoutionImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_animoutionImageView];
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [_animoutionImageView setAnimationImages:idleImages];
    
    [_animoutionImageView setAnimationDuration:idleImages.count *0.01];
    [_animoutionImageView setAnimationRepeatCount:100/(idleImages.count *0.01)];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _animoutionImageView.frame = self.bounds;
}
- (void)startHUD
{
    [_animoutionImageView startAnimating];
}
- (void)stopHUD
{
    [_animoutionImageView stopAnimating];
    [_animoutionImageView removeFromSuperview];
    _animoutionImageView = nil;

}
@end
