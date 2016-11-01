//
//  SGBaseViewController.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/11.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SGBaseViewController : UIViewController
/**
 *  是否需要添加tableView
 *
 *  @param delegate tableView的代理
 *
 *  @return 返回一个tableView
 */
- (UITableView *)addTableViewWithDelegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style;
    /**
     给界面添加一个TableView
     
     @param frame tableView的frame
     @param delegate 代理对象
     @param style tableView的样式
     @return UITableView
     */
- (UITableView *)addTableViewWithFrame:(CGRect)frame Delegate:(id <UITableViewDelegate,UITableViewDataSource>)delegate style:(UITableViewStyle)style;
    
/**
 *  右边按钮的点击事件
 *
 *  @param bar
 */
- (void)leftButtonClickToback:(UIBarButtonItem *)bar;

@end
