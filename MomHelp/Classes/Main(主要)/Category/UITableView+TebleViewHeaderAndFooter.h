//
//  UITableView+TebleViewHeaderAndFooter.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/15.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  这个控制器用来给tableView添加一个上下拉刷新的

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UITableView (TebleViewHeaderAndFooter)

/**
 *  增加一个头部刷新控件
 *
 *  @param headerRefreshBlock 进入刷新之前会调用的block ，
*    请将刷新的时候需要条用的代码写在headerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock;

/**
 *  增加一个尾部刷新控件 （scrollView滚动到底部时候自动刷新）
 *  (这个方法的增加的控件，当用户滚动到scrollView或者是tableView的底部的时候会自动调用footerRefreshBlock)
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock;

/**
 *  增加一个尾部刷新控件(不会自都进入刷新)
 *  （scrollView滚动到底部时候不会自动刷新，需要用户手动上拉加载）
 *
 *  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock;
/**
 *  同时增加一个头部和尾部的刷新控件（尾部会自动进入刷新)
 *
 *  @param headerRefreshBlock  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 *  @param footerRefreshBlock footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifAutoFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock;


/**
 *  同时增加一个头部和尾部的刷新控件（尾部不会自动进入刷新)
 *
 *  @param headerRefreshBlock  @param footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 *  @param footerRefreshBlock footerRefreshBlock 进入刷新之前会调用的block ，
 *    请将刷新的时候需要条用的代码写在footerRefreshBlock里面
 */
- (void)addRefrshGifHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshGifBackFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock;



/**
 增加上下拉刷新

 @param headerRefreshBlock 头部刷新会调用的方法
 @param footerRefreshBlock 尾部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock  andRefrshNormalFooterWithRefreshBlock:(void(^)(void))footerRefreshBlock;
/**
 增加下拉刷新
 
 @param headerRefreshBlock 头部刷新会调用的方法
 */
- (void)addRefreshNormalHeaderWithRefreshBlock:(void(^)(void))headerRefreshBlock;

@end
