//
//  UploadImageTool.h
//  深体健康
//
//  Created by RMT on 2016/10/11.
//  Copyright © 2016年 刘家攀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadImageTool : NSObject


/**
 这个方法用于上传单张图片到阿里云

 @param parmar       这是参数是一个字典，直接将后台的字典传入
 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
+(void)upLoadImageWithPamgamar:(NSDictionary *)parmar imageData:(NSData *)imageData success:(void (^)(NSString *objectKey))successBlock faile:(void (^)(NSError *))faile;
/**
 这个方法用于上传多张图片到里云上
 
 @param parmar       这是参数是一个字典，直接将后台的字典传入
 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
+(void)upLoadImageWithPamgamar:(NSDictionary *)parmar imageDataArray:(NSArray *)imageDataArray success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *))faile;
@end
