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

#define itemW  ((d_screen_width-45)/4.0f)
@interface RMTIdeaFeelbackViewController () <UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
@property (nonatomic,strong) RMTTextView *textView;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *waterFlowLayout;
@property (nonatomic,strong) UILabel *selectPic;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) NSMutableArray *selectPhoto;

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
    
    UIButton *commit = [UIButton setMainButtonWithTitle:@"提交" clickThingTarget:self action:@selector(commitButtonClick:)];
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
- (void)commitButtonClick:(UIButton *)sender
{
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
