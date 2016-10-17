//
//  NSFileManager+HomeDocumentPath.m
//  MomHelp
//
//  Created by xuguoyong on 16/8/16.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "NSFileManager+HomeDocumentPath.h"

@implementation NSFileManager (HomeDocumentPath)
/**
 *  获取沙盒Document的路径
 */
+ (NSString *)getHomeDocumentPath
{
     NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return doc;
}

/**
 *  在沙盒中创建一个文件夹
 *
 *  @param documentName 文件夹的名称
 *
 *  @return 返回文件夹路径
 */
+ (NSString *)createDocumentWithDocumentName:(NSString *)documentName
{

   
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", [self getHomeDocumentPath],documentName];
  
    BOOL result = NO;
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
       
      result =   [[NSFileManager defaultManager] createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }else
    {
        result = YES;//已经存在
    }
    return result?createPath:nil;
}

/**
 *  获取离线缓存的数据的存放路径
 */
+ (NSString *)getOfflineCacheSqlitePath
{
   NSString * sqliteDocument = [self createDocumentWithDocumentName:@"cacheSqlite"];
    NSString *sqlitePath = [NSString stringWithFormat:@"%@/cacheSqlite.sqlite",sqliteDocument];
  
    return sqlitePath;
}

@end
