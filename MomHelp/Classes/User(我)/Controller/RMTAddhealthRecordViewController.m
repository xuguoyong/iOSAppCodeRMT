//
//  RMTAddhealthRecordViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTAddhealthRecordViewController.h"
#import "NSDate+Time.h"
#import "RMTImageViewCollectionViewCell.h"
#import "TZImagePickerController.h"
#import <AliyunOSSiOS/OSSService.h>
#import "RMTTextView.h"
#define itemW  ((d_screen_width-45)/4.0f)

@interface RMTAddhealthRecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate,UIScrollViewDelegate>
{
    OSSClient *_client;
}
@property (nonatomic,strong) UILabel *recordDateLabel;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *waterFlowLayout;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *selectPhoto;
@property (nonatomic,strong) NSMutableArray *tips;
@property (nonatomic,strong) NSArray *imageArr;
@property (nonatomic,strong) UILabel *textLenthLabel;
@property (nonatomic,strong) UIButton *commitButton;


@property (nonatomic,strong) RMTTextView *textView;
@end

@implementation RMTAddhealthRecordViewController

- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, d_screen_height -64)];
        _bgScrollView.backgroundColor =UIColorFromRGB(0xEBEBEB);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 45)];
        view.backgroundColor = [UIColor whiteColor];
        [_bgScrollView addSubview:view];
        
        UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, d_screen_width -30, 45)];
        typeLabel.textColor =UIColorFromRGB(0x000000);
        typeLabel.text  =@"病例档案";
        typeLabel.font = [UIFont systemFontOfSize:15.0f];
        [view addSubview:typeLabel];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"select_icon"];
        [view addSubview:imageView];
        imageView.sd_layout.centerYEqualToView(typeLabel).widthIs(20).heightIs(20).rightSpaceToView(view,15);
        
        UIView *bigBgView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(typeLabel.frame) + 10, d_screen_width, 400)];
        bigBgView.backgroundColor = [UIColor whiteColor];
        [_bgScrollView addSubview:bigBgView];
        _bgScrollView.contentSize = CGSizeMake(0, bigBgView.height + typeLabel.height + 200);
        
        
        self.recordDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, d_screen_width -30, 45)];
       
        self.recordDateLabel.textColor =UIColorFromRGB(0x868686);
        self.recordDateLabel.font = [UIFont systemFontOfSize:15.0f];
        self.recordDateLabel.text  =[NSString stringWithFormat:@"档案日期 %@", [NSDate getCurrentStandarTimeWithFormatter:@"yyyy-MM-dd"]];
        
        [bigBgView addSubview:self.recordDateLabel];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recordDateLabel.frame), d_screen_width, 0.5)];
        line.backgroundColor = UIColorFromRGB(0xd2d2d2);
        [bigBgView addSubview:line];
        self.lineView = line;
        [bigBgView addSubview:self.collectionView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.collectionView.frame) + 10, d_screen_width - 30, 30)];
        label.textColor =UIColorFromRGB(0x868686);
        label.text  =@"选择档案图片";
        label.font = [UIFont systemFontOfSize:15.0f];
        
        [bigBgView addSubview:label];
        
        
        UIView *viewGray = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) +10, d_screen_width - 30, 200)];
        viewGray.backgroundColor = UIColorFromRGB(0xF5F5F5);
        viewGray.layer.masksToBounds = YES;
        viewGray.layer.cornerRadius = 6.0f;
        viewGray.layer.borderWidth = 0.5;
        viewGray.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
        [bigBgView addSubview:viewGray];
        
        
        self.textView = [[RMTTextView alloc] init];
        self.textView.backgroundColor =[UIColor clearColor];
        self.textView.placehoder = @"备注";
        [viewGray addSubview:self.textView];
        self.textView.sd_layout.topSpaceToView(viewGray,5).leftEqualToView(viewGray).offset(5).rightSpaceToView(viewGray,5).bottomSpaceToView(viewGray,20);
        
        self.textLenthLabel = [[UILabel alloc] init];
        self.textLenthLabel.textColor =UIColorFromRGB(0x868686);
        self.textLenthLabel.text  =@"0/400";
        self.textLenthLabel.font = [UIFont systemFontOfSize:15.0f];
        self.textLenthLabel.textAlignment = NSTextAlignmentRight;
        [viewGray addSubview:self.textLenthLabel];
        self.textLenthLabel.sd_layout.rightSpaceToView(viewGray,5).widthIs(100).bottomSpaceToView(viewGray,0).heightIs(30);
        
        
        self.commitButton = [UIButton setMainButtonWithTitle:@"提交" clickThingTarget:self action:@selector(commitBUttonClick:)];
        self.commitButton.frame = CGRectMake(15, CGRectGetMaxY(bigBgView.frame) + 10, d_screen_width - 30, 45);
        [_bgScrollView addSubview:self.commitButton];
        _bgScrollView.delegate =self;
    }
    return _bgScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  = @"添加档案";
    [self.view addSubview:self.bgScrollView];
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.recordDateLabel.frame)+10 , d_screen_width, itemW + 10) collectionViewLayout:self.waterFlowLayout];
        
        
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
    cell.backgroundColor = UIColorFromRGB(0xebebeb);
    
    
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
//提交按钮的点击事件
- (void)commitBUttonClick:(UIButton *)sender
{
    if (self.selectPhoto.count <=0) {
        [SGShowMesssageTool showMessage:@"请至少上传一张图片"];
    }else
    {
        [self requestPramaFromBackFont:self.imageArr];
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
        [SGShowMesssageTool showMessage:@"添加档案失败"];
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
            [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"添加档案失败，请稍后重试"];
        }
        return nil;
    }];
    
}

#pragma mark ===图片全部上传成功后会调用的方法
//objectArray 是的到的所有的图片文件名字 该文件名需要直接上传到后台
- (void)didFinishUploadAllPhotoWithAllObjectKey:(NSArray *)objectArray
{
    
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    
    parmeters[@"type"] = @"caseFile";
    parmeters[@"recordDate"] = [NSDate getCurrentStandarTimeWithFormatter:@"yyyy-MM-dd"];
    
    parmeters[@"remark"] = self.textView.text.length<=0?@"":self.textView.text;
    parmeters[@"covers"]=@"";
    if (objectArray) {
        parmeters[@"covers"] = [objectArray componentsJoinedByString:@","];
    }
    
    [RMTDataService postDataWithURL:POST_Add_Record parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SGShowMesssageTool showMessage:@"添加档案成功"];
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"添加档案失败，请稍后重试"];
    }];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
