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

@interface RMTAddhealthRecordViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,TZImagePickerControllerDelegate>
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
        
    }
    return _bgScrollView;
}

- (void)commitBUttonClick:(UIButton *)sender
{
    
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

@end
