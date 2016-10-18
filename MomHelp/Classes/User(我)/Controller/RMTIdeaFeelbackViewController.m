//
//  RMTIdeaFeelbackViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/14.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTIdeaFeelbackViewController.h"
#import "RMTTextView.h"
#import "RMTImageViewCollectionViewCell.h"
#import "TZImagePickerController.h"
#import <AliyunOSSiOS/OSSService.h>
#define itemW  ((d_screen_width-45)/4.0f)
@interface RMTIdeaFeelbackViewController () <UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
{
    OSSClient *_client;
}
@property (nonatomic,strong) RMTTextView *textView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *waterFlowLayout;
@property (nonatomic,strong) UILabel *selectPic;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *selectPhoto;
@property (nonatomic,strong) NSMutableArray *tips;
@property (nonatomic,strong) NSArray *imageArr;
@end

@implementation RMTIdeaFeelbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 150 +itemW + 10 +31)];
    self.bgView .backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    
    [self setupTextView];
    [self.view addSubview:self.collectionView];
    self.selectPic  = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.collectionView.frame), d_screen_width, 21)];
    self.selectPic.text = @"请选择图片";
    self.selectPic.textColor = UIColorFromRGB(0xd2d2d2);
    self.selectPic.font = textFont24;
    self.selectPic.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.selectPic];
    
    UIButton *commit = [UIButton setMainButtonWithTitle:@"提交" clickThingTarget:self action:@selector(commitButtonClickCustom:)];
    commit.frame = CGRectMake(15, CGRectGetMaxY(self.bgView.frame)+20, d_screen_width - 30, 45);
   
    [self.view addSubview:commit];
    
    
  
    
}
// 添加输入控件
- (void)setupTextView
{
    // 1.创建输入控件
    RMTTextView *textView = [[RMTTextView alloc] init];
    textView.frame = CGRectMake(0, 0, d_screen_width, 150);
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.backgroundColor = [UIColor whiteColor];
    // 2.设置提醒文字（占位文字）
    textView.placehoder = @"意见与反馈写在此处";
    
    // 3.设置字体
    textView.font = [UIFont systemFontOfSize:15];
    
}

#pragma mark===懒加载瀑布流
-(UICollectionViewFlowLayout *)waterFlowLayout
{
    if (_waterFlowLayout == nil) {
        _waterFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _waterFlowLayout.scrollDirection= UICollectionViewScrollDirectionHorizontal;
        _waterFlowLayout.sectionInset = UIEdgeInsetsMake(5, 10, 5, 10);
        _waterFlowLayout.minimumLineSpacing = 10;
    }
    
    return _waterFlowLayout;
}

#pragma mark ===懒加载collectionView
-(UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        
   _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.textView.frame) , d_screen_width, itemW + 10) collectionViewLayout:self.waterFlowLayout];
        
        
        _collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerClass:[RMTImageViewCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _collectionView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(itemW, itemW);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.selectPhoto.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    RMTImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    
    
    if (indexPath.row >= self.selectPhoto.count) {
        [cell setImaeViewImage:nil];
    }else
    {
         [cell setImaeViewImage:self.imageArr[indexPath.row]];
    
    }
    return cell;
    
    
}

//点击每一个宝宝会调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
     imagePickerVc.selectedAssets = self.selectPhoto;
    imagePickerVc.isSelectOriginalPhoto = NO;
    
    imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.selectPhoto = [[NSMutableArray alloc] initWithArray:assets];
        self.imageArr = photos;
        [self.collectionView reloadData];
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

//点击提交按钮会调用的方法
- (void)commitButtonClickCustom:(UIButton *)sender
{
    if (self.selectPhoto.count >0 || self.textView.text.length >0) {
        if (self.selectPhoto.count > 0) {
           [self requestPramaFromBackFont:self.imageArr];
        }else
        {
         [self didFinishUploadAllPhotoWithAllObjectKey:nil];
        }
       
    }else
    {
        [SGShowMesssageTool showMessage:@"请输入您的意见"];
    }
    
    
}

#pragma mark -- 1 请求后台将要上传数据
- (void)requestPramaFromBackFont:(NSArray *)imageArr
{
    
    
    [RMTDataService getDataWithURL:GET_Aliyun_SDKPamark parma:nil showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        
        NSDictionary *parmar = [responseObj objectForKey:@"data"];
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
        
        
        
        _client  = [[OSSClient alloc] initWithEndpoint:[NSString stringWithFormat:@"http://%@",[parmar objectForKey:@"endpoint"]] credentialProvider:credential2 clientConfiguration:conf];
        [self uploadPhotoWithImageArray:imageArr oSSClient:_client parga:parmar];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [SGShowMesssageTool showMessage:@"意见上传失败"];
    }];
    

}
- (NSMutableArray *)tips
{
    if (!_tips) {
        _tips =[[NSMutableArray alloc] init];
    }
    return _tips;
}

- (void)uploadPhotoWithImageArray:(NSArray *)imageArr oSSClient:(OSSClient *)client parga:(NSDictionary *)parmar
{
    NSLog(@"%@",imageArr);
   
    [self.tips removeAllObjects];
    for (NSInteger i = 0; i < imageArr.count; i ++) {
        UIImage *image = [imageArr objectAtIndex:i];
        NSData *data =  UIImageJPEGRepresentation(image, 0.7);
        [self.tips addObject:@"noSuccess"];
        [self uploadOneImage:data oSSClient:client currentIndex:i parga:parmar];
    }
    
    
}

- (void)uploadOneImage:(NSData *)imageData oSSClient:(OSSClient *)client currentIndex:(NSInteger)index parga:(NSDictionary *)parmar
{
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];
    
    put.bucketName =[parmar  objectForKey:@"bucket"];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeStamp =[dat timeIntervalSince1970]*1000;
    NSString *objectKey  = [NSString stringWithFormat:@"%@%ld.png",[parmar objectForKey:@"userDir"],(long)timeStamp + index];
    
    put.objectKey =objectKey;
    
    put.uploadingData = imageData; // 直接上传NSData
    
    OSSTask * putTask = [_client putObject:put];
    
    // 上传阿里云
    [putTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload object success!");
            [self.tips replaceObjectAtIndex:index withObject:objectKey];
            if (![self.tips containsObject:@"noSuccess"]) {
                [self didFinishUploadAllPhotoWithAllObjectKey:self.tips];
            }
            
        } else {
            
            NSLog(@"upload object failed, error: %@" , task.error);
            [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"意见上传失败，请稍后重试"];
        }
        return nil;
    }];
    
}

#pragma mark ===图片全部上传成功后会调用的方法
//objectArray 是的到的所有的图片文件名字 该文件名需要直接上传到后台
- (void)didFinishUploadAllPhotoWithAllObjectKey:(NSArray *)objectArray
{
    
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
  
    parmeters[@"content"] = self.textView.text.length<=0?@"":self.textView.text;
    parmeters[@"coverPicture"]=@"";
    if (objectArray) {
        parmeters[@"coverPicture"] = [objectArray componentsJoinedByString:@","];
    }
    
    [RMTDataService postDataWithURL:POST_User_Feel_Back parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
      
        dispatch_async(dispatch_get_main_queue(), ^{
            [SGShowMesssageTool showMessage:@"意见反馈成功，感谢您的宝贵意见"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"意见上传失败，请稍后重试"];
    }];
 
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
