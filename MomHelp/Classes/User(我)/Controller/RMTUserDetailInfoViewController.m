//
//  RMTUserDetailInfoViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//  用户的详细信息

#import "RMTUserDetailInfoViewController.h"
#import "RMTUserInfoHeadCell.h"
#import <VPImageCropperViewController.h>
#import "RMTUserInfoModel.h"
#import "UploadImageTool.h"
#import "RMTChangeNickNameView.h"
#import "HooDatePicker.h"
#import "NSDate+Time.h"

#import "RMTChangeAreaView.h"
@interface RMTUserDetailInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,HooDatePickerDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) UIActionSheet *changeHeaderSheet;
@property (nonatomic,strong) UIActionSheet *changeSexSheet;
@property (nonatomic, strong) HooDatePicker *datePicker;



@end

@implementation RMTUserDetailInfoViewController

#pragma mark ==========懒加载ActionSheet======================
- (UIActionSheet *)changeHeaderSheet
{
    if (_changeHeaderSheet == nil) {
        _changeHeaderSheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
    }
    return _changeHeaderSheet;
    
}
- (UIActionSheet *)changeSexSheet
{
    if (_changeSexSheet == nil) {
        _changeSexSheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    }
    return _changeSexSheet;
    
}
-(NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
        [_dataSources addObject:@[@"头像",@"昵称",@"手机",@"性别",@"生日",@"地区"]];
      //  [_dataSources addObject:@[@"实名认证",@"绑定银行卡",@"交易密码"]];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.title = @"个人资料";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMTUserInfoHeadCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    self.datePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
    self.datePicker.delegate = self;
    self.datePicker.datePickerMode = HooDatePickerModeDate;
    NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
    [dateFormatter setDateFormat:kDateFormatYYYYMMDD];
    NSDate *maxDate =[dateFormatter dateFromString:@"2049-01-01"];
    NSDate *minDate = [dateFormatter dateFromString:@"1900-01-01"];
    self.datePicker.minimumDate = minDate;
    self.datePicker.maximumDate = maxDate;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSources.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *ar = self.dataSources[section];
    return ar.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        return 70.0f;
    }
    return 50.0f;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 &&indexPath.row == 0) {
        RMTUserInfoHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
      
        if ([RMTUserInfoModel shareInstance].HeadImage) {
            headCell.userHeadImage.image = [RMTUserInfoModel shareInstance].HeadImage;
        }else
        {
            [headCell.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[RMTUserInfoModel shareInstance].headPortrait] placeholderImage:nil];
        }
        return headCell;
    }
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.detailTextLabel.text  =@"显示详情的信息";
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
            {
                cell.detailTextLabel.text= [RMTUserInfoModel shareInstance].nick;
            }
                break;
            case 2:
            {
                cell.detailTextLabel.text= [RMTUserInfoModel shareInstance].mobile;
            }
                break;
            case 3:
            {
                cell.detailTextLabel.text= [RMTUserInfoModel shareInstance].sex;
            }
                break;
            case 4:
            {
                cell.detailTextLabel.text= [RMTUserInfoModel shareInstance].birthday;
            }
                break;
            case 5:
            {
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%@ %@ %@", [RMTUserInfoModel shareInstance].provinceName, [RMTUserInfoModel shareInstance].cityName, [RMTUserInfoModel shareInstance].areaName];
            }
                break;
                
            default:
                break;
        }
    }else if (indexPath.section ==1)
    {
        if (indexPath.row == 0) {
        cell.detailTextLabel.text=[[RMTUserInfoModel shareInstance].whetherCertification intValue] ==1?@"已认证":@"未认证";
        }else if (indexPath.row ==1)
        {
        cell.detailTextLabel.text=[[RMTUserInfoModel shareInstance].whetherBankCard intValue] ==1?@"已绑定":@"未绑定";
        }else if (indexPath.row ==2)
        {
            cell.detailTextLabel.text= [[RMTUserInfoModel shareInstance].whetherTransactionPassword intValue] ==1?@"已设置":@"未设置";
        }
    }
    
    cell.textLabel.text =self.dataSources [indexPath.section][indexPath.row];
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    __weak typeof(self)weakself =self;
    if (indexPath.section == 0) {
    
        switch (indexPath.row) {
            case 0://头像
            {
                //点击头像
                [self.changeHeaderSheet showInView:self.view];
            }
                break;
            case 1://昵称
            {
                
                RMTChangeNickNameView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMTChangeNickNameView" owner:nil options:nil]firstObject];
                __weak typeof(view)weakView = view;
                view.getNickNameText = ^(NSString *nick)
                {
                    [weakself getNewName:nick];
                    
                    [weakView.nickNameLabel resignFirstResponder];
                    [UIView animateWithDuration:0.25 animations:^{
                        weakView.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [weakView removeFromSuperview];
                    }];
                };
                [view showInWindow];
            }
                break;
            case 2://手机
            {
            }
                break;
            case 3://性别
            {
                //点击性别
                [self.changeSexSheet showInView:self.view];
            }
                break;
            case 4://生日
            {
                NSDateFormatter *dateFormatter = [NSDate shareDateFormatter];
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                
                NSDate *minDate = [dateFormatter dateFromString:[RMTUserInfoModel shareInstance].birthday];
                [self.datePicker setDate:minDate animated:NO];
                [self.datePicker show];
                
            }
                break;
            case 5://地区
            {
                RMTChangeAreaView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMTChangeAreaView" owner:nil options:nil]firstObject];
                 __weak typeof(view)weakView = view;
                view.selectAreaBlcok = ^(NSDictionary *area)
                {
                    [UIView animateWithDuration:0.25 animations:^{
                        weakView.alpha = 0.0f;
                    } completion:^(BOOL finished) {
                        [weakView removeFromSuperview];
                    }];
                    [self changeProvinceAndCity:area];
                };
                [view showInWindow];
                
            }
                break;
          
                
            default:
                break;
        }
    }else
    {
    
    }
    

}


/**  负责图片上传请求 */
- (void)obtainHeadPortraitForWebServer:(UIImage *)file{
    
    
    [RMTDataService getDataWithURL:GET_Aliyun_SDKPamark parma:nil showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        
        NSDictionary *dict1 = [responseObj objectForKey:@"data"];
        
        [UploadImageTool upLoadImageWithPamgamar:dict1 imageData:UIImageJPEGRepresentation(file, 0.7) success:^(NSString *objectKey) {
            [self uploadUserHeaderPicToBackfontWithImageName:objectKey];
        } faile:^(NSError *error) {
            
        }];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [SGShowMesssageTool showMessage:@"头像修改失败"];
    }];
    
   
    
}
#pragma mark ==上传用户头像
- (void)uploadUserHeaderPicToBackfontWithImageName:(NSString *)headPortrait
{

    [RMTDataService postDataWithURL:POST_Change_User_HeadPortrait parma:@{@"headPortrait":headPortrait} showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"头像修改成功"];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
      [SGShowMesssageTool showMessage:@"头像修改失败"];
    }];

    
    
}


#pragma mark ===修改用户头像=========

- (void)changeMyHeaderWithHeaderImage:(UIImage *)headerImage
{
    
    [RMTUserInfoModel shareInstance].HeadImage = headerImage;
    [self.tableView reloadData];
    [self obtainHeadPortraitForWebServer:headerImage];

    
}

#pragma mark=====修改用户昵称========
- (void)getNewName:(NSString *)newName
{
    [RMTUserInfoModel shareInstance].nick = newName;
    [self.tableView reloadData];
    [RMTDataService postDataWithURL:POST_Change_User_Nick parma:@{@"nike":newName} showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"修改昵称成功"];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
}

#pragma mark=====修改用户性别========
- (void)changeUserSex:(NSString *)sex
{
    
    NSString *ss =[sex intValue] ==1?@"女":@"男";
    if ( [[RMTUserInfoModel shareInstance].sex isEqualToString:ss]) {
        return;
    }
    [RMTUserInfoModel shareInstance].sex = ss;
    [self.tableView reloadData];
    
    [RMTDataService postDataWithURL:POST_Change_User_Sex parma:@{@"sex":ss} showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}

#pragma mark=====修改用户生日========
- (void)changeUserBirthday:(NSString *)birthdayString
{
    
    [RMTUserInfoModel shareInstance].birthday =birthdayString;
    
    [self.tableView reloadData];
    
    
    [RMTDataService postDataWithURL:POST_Change_User_Birthday parma:@{@"birthday":birthdayString} showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"修改生日成功"];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
}

- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date
{

    [self changeUserBirthday: [NSDate dateToString:@"yyyy-MM-dd" byDate:date]];
}
#pragma mark =====修改用户地区=======
- (void)changeProvinceAndCity:(NSDictionary *)provinceAndCity
{
    [RMTUserInfoModel shareInstance].cityId = [provinceAndCity objectForKey:@"cityId"];
    [RMTUserInfoModel shareInstance].cityName = [provinceAndCity objectForKey:@"cityName"];
    [RMTUserInfoModel shareInstance].provinceId = [provinceAndCity objectForKey:@"provinceId"];
    [RMTUserInfoModel shareInstance].provinceName = [provinceAndCity objectForKey:@"provinceName"];
    [RMTUserInfoModel shareInstance].areaId = [provinceAndCity objectForKey:@"areaId"];
    [RMTUserInfoModel shareInstance].areaName = [provinceAndCity objectForKey:@"areaName"];
    [self.tableView reloadData];
    
    [RMTDataService postDataWithURL:POST_Change_User_Area parma:provinceAndCity showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"修改地区成功"];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}



#pragma mark ===actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex

{
    if (actionSheet == self.changeSexSheet) {
        [self changeUserSex:[NSString stringWithFormat:@"%ld",buttonIndex]];
        return;
    }
    
    
    if (buttonIndex == 0) {
        //拍照
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if(authStatus == AVAuthorizationStatusRestricted ||authStatus ==  AVAuthorizationStatusDenied){
            NSString*message=@"应用程序想要访问您的相机，是否允许？";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            
            [alert show];
            
            
            
        }else
        {
            // 点击拍照，判断当前是否有摄像头是否支持拍照
            if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]
                ) {
                
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                //设置来源类型
                controller.sourceType = UIImagePickerControllerSourceTypeCamera;
                //判断前置摄像头是否可用
                if ([self isFrontCameraAvailable]) {
                    //如果有前置摄像头，则默认打开后置摄像头
                    controller.cameraDevice = UIImagePickerControllerCameraDeviceRear;
                }
                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                
                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                //设置媒体类型
                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                    
                                 }];
            }
            
        }
        
    }else if(buttonIndex == 1)
    {
        //    从相册中选取
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                            
                             }];
        }
    }
    
}

#pragma mark ======点击拍照完成后会调用的方法（得到的portraitImg是原图）==

//拍照后点击使用图片会调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        //取得当前拍照得到的图片
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if (self.originalImageBlock) {
            self.originalImageBlock(portraitImg);
        }
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 选取图片的框的大小
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, ((d_screen_height - d_screen_width)/2.0), d_screen_width, d_screen_width) limitScaleRatio:3.0];
        
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
        
    }];
}




#pragma mark ======点击使用照片完成后会调用的方法（得到的portraitImg是选取框）==
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    
    
    //在这里点击使用照片的时候会调用的方法，得到的图片是editedImage是裁剪后的图片
    
    if (self.eiditImageBlock) {
        self.eiditImageBlock(editedImage);
    }
    
    [self changeMyHeaderWithHeaderImage:editedImage];
    
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}


#pragma mark ===一下方法不用看=================
//判断摄像头是否可用（是否有摄像头）
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}
//判断后置摄像头是否可用
- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}
//判断前置摄像头是否可用
- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}
//判断摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}
//检查相册是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
//是否可用在相册中选取视频
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
//是否可以在相册中选取图片
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
// 判断是否支持某种多媒体类型：拍照，视频
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex == 1) {
        if ([[UIDevice currentDevice].systemVersion floatValue]>8.0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Setting"]];
        }
    }
    
    
}
//点击取消拍照
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}
- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    //点击不适用照片会调用的方法
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}


@end
