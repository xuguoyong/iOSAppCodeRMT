//
//  RMTImageViewCollectionViewCell.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/14.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZAssetModel.h"
@interface RMTImageViewCollectionViewCell : UICollectionViewCell
/**
 *  展示图片的按钮
 */
- (void)setImaeViewImage:(UIImage *)image;
@property (nonatomic,strong) void(^seeBigPhotoButtonClickBlock)(UIButton *sender);
@end
