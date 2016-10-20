//
//  SGBaseViewController.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseViewController.h"
@interface SGBaseViewController ()

@end

@implementation SGBaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];

}



#pragma mark ==如果需要添加tableView 直接调用一下方法即可
/**
 *  是否需要添加tableView
 *
 *  @param delegate tableView的代理
 *
 *  @return 返回一个tableView
 */
- (UITableView *)addTableViewWithDelegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style
{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:style];
    
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    [self.view addSubview:tableView];
    tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    [tableView updateLayout];
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
      
    return tableView;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001f;

}



@end
