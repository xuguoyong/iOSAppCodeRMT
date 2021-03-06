//
//  UITableView+TebleViewHeaderAndFooter.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "UITableView+TebleViewHeaderAndFooter.h"
#import "XGYRefreshGifHeader.h"
#import "XGYRefreshAutoGifFooter.h"
#import "XGYRefreshBackGifFooter.h"
#import <AFNetworking.h>


@implementation UITableView (TebleViewHeaderAndFooter)
/**
 *  增加一个头部刷新控件
 *
 *  @param headerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在headerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock
{

    // 设置回调（一旦进入刷新状态，就调用headerRefreshBlock）
    self.mj_header = [XGYRefreshGifHeader headerWithRefreshingBlock:^{
       
        if ([SGShowMesssageTool isHaveNetWork]) {
            headerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_header endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
        
    }];

}

/**
 *  增加一个尾部刷新控件 （scrollView滚动到底部时候自动刷新）
 *  (这个方法的增加的控件，当用户滚动到scrollView或者是tableView的底部的时候会自动调用footerRefreshBlock)
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock
{
    // 设置回调（一旦进入刷新状态，就调用footerRefreshBlock）
    self.mj_footer = [XGYRefreshAutoGifFooter  footerWithRefreshingBlock:^{
       
        
        if ([SGShowMesssageTool isHaveNetWork]) {
            footerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_footer endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
    }];
    
}

/**
 *  增加一个尾部刷新控件(不会自都进入刷新)
 *  （scrollView滚动到底部时候不会自动刷新，需要用户手动上拉加载）
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock
{
    self.mj_footer = [XGYRefreshBackGifFooter  footerWithRefreshingBlock:^{
        
        
        if ([SGShowMesssageTool isHaveNetWork]) {
          footerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_footer endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
        
    }];
    
}
/**
 *  同时增加一个头部和尾部的刷新控件（尾部会自动进入刷新)
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block
 *  @param footerRefreshBlock footerRefreshBlock 进入刷新之前会调用的block
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock
{
    // 设置回调（一旦进入刷新状态，就调用headerRefreshBlock）
    self.mj_header = [XGYRefreshGifHeader headerWithRefreshingBlock:^{
        if ([SGShowMesssageTool isHaveNetWork]) {
            headerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_header endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
          
        }
        
       
    }];
    
    // 设置回调（一旦进入刷新状态，就调用footerRefreshBlock）
    self.mj_footer = [XGYRefreshAutoGifFooter  footerWithRefreshingBlock:^{
        
        
        if ([SGShowMesssageTool isHaveNetWork]) {
          footerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_footer endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
    }];
}


/**
 *  同时增加一个头部和尾部的刷新控件（尾部不会自动进入刷新)
 *
 * @param footerRefreshBlock 进入刷新之前会调用的block
 * @param  footerRefreshBlock 进入刷新之前会调用的block
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock
{
    
    // 设置回调（一旦进入刷新状态，就调用headerRefreshBlock）
    self.mj_header = [XGYRefreshGifHeader headerWithRefreshingBlock:^{
        if ([SGShowMesssageTool isHaveNetWork]) {
            headerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_header endRefreshing];
                 [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
     
    }];
    
    // 设置回调（一旦进入刷新状态，就调用footerRefreshBlock）
    self.mj_footer = [XGYRefreshBackGifFooter  footerWithRefreshingBlock:^{
       
        if ([SGShowMesssageTool isHaveNetWork]) {
            footerRefreshBlock();
        }else
        {
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                [self.mj_footer endRefreshing];
                [SGShowMesssageTool showMessage:SGNotNetWorkingTips];
            });
            
            
        }
    }];

}


/**
 增加上下拉刷新
 
 @param headerRefreshBlock 头部刷新会调用的方法
 @param footerRefreshBlock 尾部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshNormalFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        headerRefreshBlock();
    }];
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        footerRefreshBlock();
    }];

}
/**
 增加下拉刷新
 
 @param headerRefreshBlock 头部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock
{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        headerRefreshBlock();
    }];
}
@end
