//
//  RMTRecordDetailViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTRecordDetailViewController.h"
#import "RMTTextView.h"

@interface RMTRecordDetailViewController ()
@property (nonatomic,strong) RMTRecordListModel *dataModel;
@property (nonatomic,strong) UILabel *recordDateLabel;
@property (nonatomic,strong) UILabel *remarkLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (nonatomic,strong) RMTTextView *textView;
@property (nonatomic,strong) UIButton *editeButton;
@property (nonatomic,strong) UIView *toobarView;



@end

@implementation RMTRecordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  =@"档案详情";
    [self requestDataFromBack];
    [self CreateUI];
    
    
    // 4.监听键盘
    // 键盘的frame(位置)即将改变, 就会发出UIKeyboardWillChangeFrameNotification
    // 键盘即将弹出, 就会发出UIKeyboardWillShowNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // 键盘即将隐藏, 就会发出UIKeyboardWillHideNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
}


#pragma mark - 键盘处理
/**
 *  键盘即将隐藏
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        self.toobarView.transform = CGAffineTransformIdentity;
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    // 1.键盘弹出需要的时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 2.动画
    [UIView animateWithDuration:duration animations:^{
        // 取出键盘高度
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toobarView.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}

- (void)CreateUI
{
    self.recordDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, d_screen_width -30, 45)];
    self.recordDateLabel.textColor =UIColorFromRGB(0x868686);
    self.recordDateLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:self.recordDateLabel];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recordDateLabel.frame), d_screen_width, 0.5)];
    line.backgroundColor = UIColorFromRGB(0xd2d2d2);
    [self.view addSubview:line];
    
    CGFloat itemW = (d_screen_width -45)/4.0f;
    UIImageView *lastImageView = nil;
    for (NSInteger i =0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15 + i*(itemW +5), CGRectGetMaxY(line.frame) +10, itemW, itemW)];
        imageView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:imageView];
        imageView.tag = 100 +i;
        lastImageView = imageView;
    }
    
    UILabel *remarktLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,  CGRectGetMaxY(lastImageView.frame) +15, d_screen_width -30, 30)];
    remarktLabel.textColor =UIColorFromRGB(0x868686);
    remarktLabel.text = @"备注";
    remarktLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.view addSubview:remarktLabel];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(remarktLabel.frame) +10, d_screen_width - 30, 130.0f)];
    view.backgroundColor = UIColorFromRGB(0xF5F5F5);
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 6.0f;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = UIColorFromRGB(0xd2d2d2).CGColor;
    [self.view addSubview:view];
    
    
    self.remarkLabel = [[UILabel alloc] init];
    
    self.remarkLabel.textColor =UIColorFromRGB(0x868686);
    self.remarkLabel.font = [UIFont systemFontOfSize:12.0f];
    self.remarkLabel.numberOfLines = 0;
    [view addSubview:self.remarkLabel];
    self.remarkLabel.sd_layout.topSpaceToView(view,5).leftEqualToView(view).offset(5).rightSpaceToView(view,5).autoHeightRatio(0).maxHeightIs(view.height - 20);
    
    
    self.dateLabel = [[UILabel alloc] init];
    
    self.dateLabel.textColor =UIColorFromRGB(0x868686);
    self.dateLabel.font = [UIFont systemFontOfSize:13.0f];
    self.dateLabel.numberOfLines = 0;
    self.dateLabel.textAlignment = NSTextAlignmentRight;
    [view addSubview:self.dateLabel];
    self.dateLabel.sd_layout.bottomEqualToView(view).offset(-5).leftEqualToView(view).offset(5).rightSpaceToView(view,5).heightIs(21);
    
    
    
    self.toobarView = [[UIView alloc] initWithFrame:CGRectMake(0, d_screen_height - 64-50, d_screen_width, 50)];
    self.toobarView.backgroundColor = [UIColor whiteColor];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 0.5)];
    line1.backgroundColor = UIColorFromRGB(0xd2d2d2);
    [self.toobarView addSubview:line1];
    
    [self.view addSubview:self.toobarView];
    self.editeButton = [UIButton custombuttonNormalStateWithTitile:@" 添加备注" titleFont:[UIFont systemFontOfSize:13.0f] titleColor:MainColor butttonImage:[UIImage imageNamed:@"add_remark_icon"] backgroundImage:nil backgroundColor:[UIColor clearColor] clickThingTarget:self action:@selector(addRemarkButtonClick:)];
    self.editeButton.frame = CGRectMake(self.toobarView.width - 90,1 , 90, self.toobarView.height);
    [self.toobarView addSubview:self.editeButton];
    self.textView = [[RMTTextView alloc] init];
    self.textView.backgroundColor =UIColorFromRGB(0xEBEBEB);
    self.textView.placehoder = @"备注";
    [self.toobarView addSubview:self.textView];
    self.textView.sd_layout.topSpaceToView(self.toobarView,5).leftEqualToView(self.toobarView).offset(5).rightSpaceToView(self.editeButton,5).bottomSpaceToView(self.toobarView,5);

    

}

- (void)addRemarkButtonClick:(UIButton *)sender
{

    [self.view endEditing:YES];
    [RMTDataService postDataWithURL:POST_Add_Remark_Record parma:@{@"healthRecordId":self.dataModel.healthRecordId,@"remark":self.textView.text} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        [self requestDataFromBack];
        [SGShowMesssageTool showMessage:@"添加备注成功"];
        self.textView.text  =@"";
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
}
- (void)reloadAllDataToUI
{
    
    self.recordDateLabel.text= [NSString stringWithFormat:@"病例日期 %@",self.dataModel.recordDate];
    self.remarkLabel.text = [self.dataModel.remark componentsJoinedByString:@","];
    self.dateLabel.text = self.dataModel.recordDate;
    
    
    for (NSInteger i = 0; i < self.dataModel.covers.count; i ++) {
        UIImageView *imgView = [self.view viewWithTag:100 +i];
    
        NSString *img =[NSString stringWithFormat:@"%@/%@",ImagePerfix,self.dataModel.covers[i]];
        [imgView sd_setImageWithURL:[NSURL URLWithString:img] placeholderImage:nil];
    }
    
    
}
-(void)requestDataFromBack
{

    [RMTDataService getDataWithURL:GET_Record_Detail parma:@{@"healthRecordId":self.detailModel.healthRecordId} showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        
        self.dataModel = [RMTRecordListModel mj_objectWithKeyValues:[responseObj objectForKey:@"data"]];
        [self reloadAllDataToUI];
    NSLog(@"%@",responseObj);
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
