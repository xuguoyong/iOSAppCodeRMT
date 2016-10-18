//
//  NSFileManager+HomeDocumentPath.h
//  MomHelp
//
//  Created by xuguoyong on 16/8/16.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (HomeDocumentPath)

/**
 *  获取沙盒Document的路径
 */
+ (NSString *)getHomeDocumentPath;
/**
 *  在沙盒中创建一个文件夹
 *
 *  @param documentName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithDocumentName:(NSString *)documentName;

/**
 *  获取离线缓存的数据的存放路径
 */
+ (NSString *)getOfflineCacheSqlitePath;

/**
 *  在沙盒中创建一个文件
 *
 *  @param documentName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithfileName:(NSString *)fileName;
@end
