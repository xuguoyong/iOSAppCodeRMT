//
//  RMTHomePageAdCell.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHomePageAdCell.h"
#import "RMTHomepageModel.h"
#import "RMTAdModel.h"
@interface RMTHomePageAdCell ()
{
    UIScrollView *_backgroundScrollView;
    UIPageControl *_pageControl;

}
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) int sce;
@end


@implementation RMTHomePageAdCell


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
    _backgroundScrollView = [[UIScrollView alloc] init];
    [self.contentView addSubview:_backgroundScrollView];
    _backgroundScrollView.pagingEnabled = YES;
    _backgroundScrollView.contentSize = CGSizeMake(d_screen_width *5, 0);
    _backgroundScrollView.contentOffset = CGPointMake(d_screen_width, 0);
    _backgroundScrollView.delegate = self;
    _backgroundScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    _backgroundScrollView.showsVerticalScrollIndicator = NO;
    _backgroundScrollView.showsHorizontalScrollIndicator = NO;
  
    [_backgroundScrollView updateLayout];
    for (NSInteger i = 0; i < 5; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * d_screen_width, 0, d_screen_width,d_screen_width *advImagesScale)];
        imageView.tag = 10 + i;
        [_backgroundScrollView addSubview:imageView];
    }
    _pageControl =[[UIPageControl alloc] initWithFrame:CGRectMake(0, d_screen_width *advImagesScale - 20, 100, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPageIndicatorTintColor = MainColor;
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self.contentView addSubview:_pageControl];
    [self performSelector:@selector(addTimer) withObject:nil afterDelay:2.0f];
    _pageControl.centerX = _backgroundScrollView.centerX;
    
}

- (void)setModel:(RMTHomepageModel *)model
{
    for (int i = 0; i < 5; i ++) {
        UIImageView *imageView = (UIImageView *)[self.contentView viewWithTag:i + 10];
        
        RMTAdModel *adModel =nil;// [model.adResponseList objectAtIndexedSubscript:i];
        if (i == 0) {
            adModel = [model.adResponseList objectAtIndexedSubscript:2];
        }else if (i == 4)
        {
            adModel = [model.adResponseList objectAtIndexedSubscript:0];
        }else
        {
            adModel = [model.adResponseList objectAtIndexedSubscript: i - 1];
        }
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:adModel.adImg] placeholderImage:[UIImage imageNamed:@"defult_health_small"]];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_backgroundScrollView.contentOffset.x == 0) {
        [_backgroundScrollView setContentOffset:CGPointMake(d_screen_width*3, 0)];
     
    }else if(_backgroundScrollView.contentOffset.x == d_screen_width * 4)
    {
       [_backgroundScrollView setContentOffset:CGPointMake(d_screen_width, 0)];
    
    }
    int page =_backgroundScrollView.contentOffset.x/d_screen_width;
    
    [_pageControl setCurrentPage:page-1];
   
}

#pragma mark====增加定时器
- (void)addTimer
{
    self.sce = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(uploadImageView:) userInfo:nil repeats:YES];
    [self.timer fire];
  //  [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    NSLog(@"定时器开始");
    
    
}
- (void)removeTime
{
    NSLog(@"定时器停止");
    [self.timer invalidate];
    self.timer = nil;
}


#pragma mark====更新UI界面
- (void)uploadImageView:(NSTimer *)timer
{
    self.sce ++;
    if (self.sce >=4.0f) {
        self.sce = 0;
        [UIView animateWithDuration:1.0f animations:^{
            
            [_backgroundScrollView setContentOffset:CGPointMake(d_screen_width+_backgroundScrollView.contentOffset.x, 0)];
        } completion:^(BOOL finished) {
            if (_backgroundScrollView.contentOffset.x > d_screen_width *4) {
                [_backgroundScrollView setContentOffset:CGPointMake(d_screen_width, 0)];
            }else if (_backgroundScrollView.contentOffset.x <= 0)
            {
                [_backgroundScrollView setContentOffset:CGPointMake(d_screen_width * 3, 0)];
            }
            int page =_backgroundScrollView.contentOffset.x/d_screen_width;
            
            [_pageControl setCurrentPage:page-1];
        }];
        
        
       
        
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    self.sce = 0;
    if (scrollView.contentOffset.x > d_screen_width *3) {
        [scrollView setContentOffset:CGPointMake(d_screen_width, 0)];
    }else if (scrollView.contentOffset.x <= 0)
    {
        [scrollView setContentOffset:CGPointMake(d_screen_width * 3, 0)];
    }
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
