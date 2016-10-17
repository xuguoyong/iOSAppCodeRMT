//
//  RMTMessageViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTMessageViewController.h"
#import "RMTMessageListTableViewCell.h"
#import "RMTMessageDetailViewController.h"


typedef NS_ENUM (NSInteger,MessageType) {
    SYSTEM_Message,
    RECEVE_Message,
    CHANGE_Message
};


@interface RMTMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UISegmentedControl *segControl;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UITableView *systemTableView;
@property (nonatomic,strong) UITableView *receveTableView;
@property (nonatomic,strong) UITableView *changeTableView;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@end

@implementation RMTMessageViewController

-(UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 55)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bgView];
        _segControl = [[UISegmentedControl alloc] initWithItems:@[@"系统",@"收益",@"转让"]];
        _segControl.layer.cornerRadius = 5.0f;
       _segControl.layer.masksToBounds = YES;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,
                             [UIFont boldSystemFontOfSize:14],
                             NSFontAttributeName,nil];
        
        [ _segControl setTitleTextAttributes:dic forState:UIControlStateSelected];
        _segControl.tintColor = MainColor;
        [_segControl addTarget:self action:@selector(segControlAction:) forControlEvents:UIControlEventValueChanged];
        //默认字体颜色
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:MainColor,
                              NSForegroundColorAttributeName,
                              [UIFont boldSystemFontOfSize:14],
                              NSFontAttributeName,nil];
        
        [_segControl setTitleTextAttributes:dic1 forState:UIControlStateNormal];
        
        _segControl.frame = CGRectMake(0, 0, d_screen_width - 40, 35);
        _segControl.center = _bgView.center;
        _segControl.selectedSegmentIndex = 0;
        [_bgView addSubview:_segControl];
        
        
    }
    return _bgView;
    
}

- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bgView.frame), d_screen_width, d_screen_height - 64 -55)];
        _bgScrollView.autoresizesSubviews = NO;
        self.systemTableView = [self getTabelVIewWithFrame:CGRectMake(0, 0, d_screen_width, _bgScrollView.height) withTabaleViewType:SYSTEM_Message];
        [_bgScrollView addSubview:self.systemTableView];
        
        self.receveTableView = [self getTabelVIewWithFrame:CGRectMake(d_screen_width, 0, d_screen_width, _bgScrollView.height) withTabaleViewType:RECEVE_Message];
        [_bgScrollView addSubview:self.receveTableView];
        
        self.changeTableView = [self getTabelVIewWithFrame:CGRectMake(d_screen_width *2, 0, d_screen_width, _bgScrollView.height) withTabaleViewType:CHANGE_Message];
        [_bgScrollView addSubview:self.changeTableView];
        _bgScrollView.contentSize = CGSizeMake(d_screen_width *3, 0);
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.delegate = self;
        
    }
    return _bgScrollView;

}

- (UITableView *)getTabelVIewWithFrame:(CGRect)frame withTabaleViewType:(MessageType)type
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;

    tableView.frame = frame;
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
    [tableView registerNib:[UINib nibWithNibName:@"RMTMessageListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    [tableView addRefreshNormalHeaderWithRefreshBlock:^{
        if (type == SYSTEM_Message) {
            [self requestSystemMessageWithIndex:0];
        }else if (type == RECEVE_Message)
        {
            [self requestReceveMoneyMessageWithIndex:0];
        }else
        {
        [self requestdemiseMessageWithIndex:0];
        }
    } andRefrshNormalFooterWithRefreshBlock:^{
        if (type == SYSTEM_Message) {
            [self requestSystemMessageWithIndex:0];
        }else if (type == RECEVE_Message)
        {
            [self requestReceveMoneyMessageWithIndex:0];
        }else
        {
            [self requestdemiseMessageWithIndex:0];
        }
    }];
    
    
    return tableView;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.bgScrollView];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.5;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RMTMessageListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RMTMessageDetailViewController *detail  =[[RMTMessageDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)segControlAction:(UISegmentedControl *)seg
{
   
    [self.bgScrollView setContentOffset:CGPointMake(seg.selectedSegmentIndex *d_screen_width, 0) animated:YES];
    
    
    if (seg.selectedSegmentIndex ==0) {
        [self requestSystemMessageWithIndex:0];
        
       
    }else if (seg.selectedSegmentIndex ==1)
    {
        [self requestReceveMoneyMessageWithIndex:0];
    }else
    {
        [self requestdemiseMessageWithIndex:0];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UITableView class]]) {
     [self.segControl setSelectedSegmentIndex:(int)(scrollView.contentOffset.x/d_screen_width)];
    }
    
}


//请求系统消息
- (void)requestSystemMessageWithIndex:(NSInteger)pageIndex
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求收益消息
- (void)requestReceveMoneyMessageWithIndex:(NSInteger)pageIndex
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
//请求转让消息
- (void)requestdemiseMessageWithIndex:(NSInteger)pageIndex
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

@end
