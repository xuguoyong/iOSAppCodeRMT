//
//  UploadImageTool.m
//  深体健康
//
//  Created by RMT on 2016/10/11.
//  Copyright © 2016年 刘家攀. All rights reserved.
//

#import "UploadImageTool.h"
#import <AliyunOSSiOS/OSSService.h>
@implementation UploadImageTool
+(void)upLoadImageWithPamgamar:(NSDictionary *)parmar imageData:(NSData *)imageData success:(void (^)(NSString *objectKey))successBlock faile:(void (^)(NSError *))faile
{

    
  
    id<OSSCredentialProvider> credential2 = [[OSSFederationCredentialProvider alloc] initWithFederationTokenGetter:^OSSFederationToken * {
        OSSFederationToken * token = [OSSFederationToken new];
        token.tAccessKey = [parmar objectForKey:@"accessKeyId"];
        token.tSecretKey = [parmar objectForKey:@"accessKeySecret"];
        token.tToken = [parmar objectForKey:@"securityToken"];
        token.expirationTimeInGMTFormat = [parmar objectForKey:@"expiration"];
        NSLog(@"get token: %@", token);
        return token;
    }];
    
    
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 2;
    conf.timeoutIntervalForRequest = 30;
    conf.timeoutIntervalForResource = 24 * 60 * 60;
    
    OSSClient *_client = [[OSSClient alloc] initWithEndpoint:[NSString stringWithFormat:@"http://%@",[parmar objectForKey:@"endpoint"]] credentialProvider:credential2 clientConfiguration:conf];
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    put.bucketName =[parmar objectForKey:@"bucket"];
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[dat timeIntervalSince1970]*1000;
    
    NSString *objectKey  = [NSString stringWithFormat:@"%@%ld.png",[parmar objectForKey:@"userDir"],(long)timeStamp];
    
    put.objectKey =objectKey;
   
    put.uploadingData = imageData; // 直接上传NSData
    
    
    OSSTask * putTask = [_client putObject:put];
    
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
            if (successBlock) {
                successBlock(objectKey);
            }
        } else {
            if (faile) {
                faile(task.error);
            }
            NSLog(@"upload object failed, error: %@" , task.error);
        }
        return nil;
    }];

}

/**
 这个方法用于上传多张图片到里云上
 
 @param parmar       这是参数是一个字典，直接将后台的字典传入
 @param successBlock 上传成功后的回调，你可以在这里处理UI
 @param faile        上传失败会走的回调
 */
+(void)upLoadImageWithPamgamar:(NSDictionary *)parmar imageDataArray:(NSArray *)imageDataArray success:(void (^)(NSArray *objectKeys))successBlock faile:(void (^)(NSError *))faile
{
    


}






@end
