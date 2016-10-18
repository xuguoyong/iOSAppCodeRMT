//
//  RMTUserDetailInfoViewController.h
//  MomHelp
//
//  Created by RMT on 2016/10/13.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "SGBaseViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
typedef void (^getPhotoBlock)(UIImage *);
#define ORIGINAL_MAX_WIDTH 640.0f
@interface RMTUserDetailInfoViewController : SGBaseViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, VPImageCropperDelegate>
@property (nonatomic,strong) getPhotoBlock originalImageBlock;
@property (nonatomic,strong) getPhotoBlock eiditImageBlock;
@end
