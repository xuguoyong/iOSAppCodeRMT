//
//  RMTHealthCarViewController.m
//  MomHelp
//
//  Created by RMT on 2016/10/12.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTHealthCarViewController.h"
#import "RMTDirctBuyProductModel.h"
#import "RMTDirectBuyHeaderCell.h"
#import "RMTDirctProductListCell.h"
#import "RMTProductListButButtonCell.h"
#import "RMTPayPageViewController.h"
#import "RMTTransferAlivingCell.h"
#import "RMTtransferListModel.h"
#import "RMTMoneyPackageHeadCell.h"
#import "RMTMoneyPackageCarCell.h"
#import "RMTCarPackageModel.h"
#import "RMTPutPasswrdView.h"
/**
 *  每个产品的大小
 */
#define productBtnW ((d_screen_width - 50)/3.0f)
#define productBtnH productBtnW *(88/180.0f)/**
*  每个产品之间的距离
*/
#define marginBtnToBtn 10


typedef NS_ENUM (NSInteger,ProductType) {
    Direct_Product_List,
    Change_bib_home,
    Car_package
};


@interface RMTHealthCarViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) UISegmentedControl *segControl;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIScrollView *bgScrollView;
//直购
@property (nonatomic,strong) NSMutableArray *productListArray;
@property (nonatomic,strong) UITableView *drectBuyTableView;
@property (nonatomic,strong) RMTDirctBuyProductModel *willBuyModel;

//转让
@property (nonatomic,strong) UITableView *changeTableView;
@property (nonatomic,strong) UIView *toobarView;
@property (nonatomic,strong) UIButton *buyButton;
@property (nonatomic,strong) UIButton *tipsButton;
@property (nonatomic,strong) UITextField *moneyTextField;
@property (nonatomic,strong) NSMutableArray *transferDataSource;

//卡包
@property (nonatomic,strong) UITableView *carTableView;
@property (nonatomic,assign) int carPage;
@property (nonatomic,strong) NSMutableArray *cardDataSource;

@property (nonatomic,strong) NSString *incrementValue;// = "174.24";
@property (nonatomic,strong) NSString *totalCount;// = 2;
@property (nonatomic,strong) NSString *totalValue;// = "1274.24";
@property (nonatomic,strong) NSString *yesterdayIncrement;// = "174.23";


@end

@implementation RMTHealthCarViewController

-(UIView *)bgView
{
    if (!_bgView) {
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 55)];
        _bgView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_bgView];
        _segControl = [[UISegmentedControl alloc] initWithItems:@[@"直购",@"转让大厅",@"卡包"]];
        _segControl.layer.cornerRadius = 10.0f;
        _segControl.layer.borderWidth = 1.0f;
        _segControl.layer.borderColor = [UIColor whiteColor].CGColor;
        _segControl.layer.masksToBounds = YES;
        
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,
                             [UIFont boldSystemFontOfSize:14],
                             NSFontAttributeName,nil];
        
        [ _segControl setTitleTextAttributes:dic forState:UIControlStateNormal];
        _segControl.tintColor = [UIColor whiteColor];
        [_segControl addTarget:self action:@selector(segmentControlClickAction:) forControlEvents:UIControlEventValueChanged];
        //默认字体颜色
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:MainColor,
                              NSForegroundColorAttributeName,
                              [UIFont boldSystemFontOfSize:14],
                              NSFontAttributeName,nil];
        
        [_segControl setTitleTextAttributes:dic1 forState:UIControlStateSelected];
        
        _segControl.frame = CGRectMake(0, 0,_bgView.width-100, 35);
        _segControl.center = _bgView.center;
        _segControl.selectedSegmentIndex = 0;
        [_bgView addSubview:_segControl];

        
        
    }
    return _bgView;
    
}

- (UIScrollView *)bgScrollView
{
    if (!_bgScrollView) {
        _bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, d_screen_height - 64)];
        _bgScrollView.autoresizesSubviews = NO;
        self.drectBuyTableView = [self getTabelVIewWithFrame:CGRectMake(0, 0, d_screen_width, _bgScrollView.height) withTabaleViewType:Direct_Product_List];
        [_bgScrollView addSubview:self.drectBuyTableView];
        
        self.changeTableView = [self getTabelVIewWithFrame:CGRectMake(d_screen_width, 0, d_screen_width, _bgScrollView.height-50) withTabaleViewType:Change_bib_home];
        [_bgScrollView addSubview:self.changeTableView];
        
        self.carTableView = [self getTabelVIewWithFrame:CGRectMake(d_screen_width *2, 0, d_screen_width, _bgScrollView.height) withTabaleViewType:Car_package];
        [_bgScrollView addSubview:self.carTableView];
        _bgScrollView.contentSize = CGSizeMake(d_screen_width *3, 0);
        _bgScrollView.pagingEnabled = YES;
        _bgScrollView.delegate = self;
        
    }
    return _bgScrollView;
    
}
- (UITableView *)getTabelVIewWithFrame:(CGRect)frame withTabaleViewType:(ProductType)type
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    tableView.frame = frame;
    tableView.backgroundColor = viewAndTableViewBackgroundColor;
    tableView.separatorColor = tableViewSeparateColor;
    if (type == Direct_Product_List) {
        [tableView addRefreshNormalHeaderWithRefreshBlock:^{
          [self requestDirectDataFromBack];
        }];
        
        [tableView registerNib:[UINib nibWithNibName:@"RMTDirectBuyHeaderCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
        
        [tableView registerNib:[UINib nibWithNibName:@"RMTProductListButButtonCell" bundle:nil] forCellReuseIdentifier:@"buyCell"];
        
        [tableView registerClass:[RMTDirctProductListCell class] forCellReuseIdentifier:@"listCell"];
       
    
        
    }else if (type == Change_bib_home)
    {
        [tableView addRefreshNormalHeaderWithRefreshBlock:^{
            [self requestTransferListDataFromBack];
        }];
         [tableView registerNib:[UINib nibWithNibName:@"RMTTransferAlivingCell" bundle:nil] forCellReuseIdentifier:@"alivingCell"];
        
    }else if (type == Car_package)
    {
    
    
        [tableView registerNib:[UINib nibWithNibName:@"RMTMoneyPackageHeadCell" bundle:nil] forCellReuseIdentifier:@"headCellpack"];
        
        [tableView registerNib:[UINib nibWithNibName:@"RMTMoneyPackageCarCell" bundle:nil] forCellReuseIdentifier:@"carCell"];
        
        [tableView addRefreshNormalHeaderWithRefreshBlock:^{
            self.carPage = 1;
            [self requestpackCarListDataFromBack];
        } andRefrshNormalFooterWithRefreshBlock:^{
            self.carPage ++;
            [self requestpackCarListDataFromBack];
            
        }];

    }
    /*
     
     [tableView addRefreshNormalHeaderWithRefreshBlock:^{
     if (type == SYSTEM_Message) {
     [self requestSystemMessageWithIndex:0];
     }else if (type == RECEVE_Message)
     {
     [self requestReceveMoneyMessageWithIndex:0];
     }else
     {
     [self requestdemiseMessageWithIndex:0];
     }
     } andRefrshNormalFooterWithRefreshBlock:^{
     if (type == SYSTEM_Message) {
     [self requestSystemMessageWithIndex:0];
     }else if (type == RECEVE_Message)
     {
     [self requestReceveMoneyMessageWithIndex:0];
     }else
     {
     [self requestdemiseMessageWithIndex:0];
     }
     }];
     
     */
    
     tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
    
}

- (UIView *)toobarView
{
    if (!_toobarView) {
        _toobarView = [[UIView alloc] init];
        _toobarView.backgroundColor = [UIColor whiteColor];
        self.buyButton = [UIButton custombuttonNormalStateWithTitile:@"购买" titleFont:[UIFont systemFontOfSize:18.0f] titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:@selector(buyButtonClick:)];
     
        [_toobarView addSubview:self.buyButton];
        self.buyButton.sd_layout.rightEqualToView(_toobarView).topEqualToView(_toobarView).bottomEqualToView(_toobarView).widthIs(130);
        UILabel *label = [[UILabel alloc] init];
        label.textColor = UIColorFromRGB(0x000000);
        label.font = [UIFont systemFontOfSize:30.0f];
        label.text =@"¥";
        [_toobarView addSubview:label];
        label.sd_layout.leftEqualToView(_toobarView).offset(15).topEqualToView(_toobarView).bottomEqualToView(_toobarView).widthIs(20);
        self.moneyTextField = [[UITextField alloc] init];
        self.moneyTextField.backgroundColor = [UIColor clearColor];
        [_toobarView addSubview:self.moneyTextField];
        self.moneyTextField.borderStyle = UITextBorderStyleNone;
        self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.moneyTextField.font = [UIFont systemFontOfSize:30.0f];
        self.moneyTextField.delegate = self;
        _moneyTextField.sd_layout.leftSpaceToView(label,0).rightSpaceToView(self.buyButton,0).topEqualToView(_toobarView).bottomEqualToView(_toobarView);
        
         self.tipsButton = [UIButton custombuttonNormalStateWithTitile:@"前往直购卡购买" titleFont:[UIFont systemFontOfSize:18.0f] titleColor:[UIColor whiteColor] butttonImage:nil backgroundImage:nil backgroundColor:MainColor clickThingTarget:self action:@selector(buyButtonClick:)];
        [_toobarView addSubview:self.tipsButton];
        self.tipsButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        

    }
    return _toobarView;

}

- (NSMutableArray *)cardDataSource
{
    if (!_cardDataSource) {
        _cardDataSource = [[NSMutableArray alloc] init];
    }
    return _cardDataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.bgView;
    [self.view addSubview:self.bgScrollView];
 
     [self requestDirectDataFromBack];
    [self requestTransferListDataFromBack];
    self.carPage = 1;
    [self requestpackCarListDataFromBack];
    
    [self.view addSubview:self.toobarView];
    self.toobarView.sd_layout.bottomEqualToView(self.view).leftEqualToView(self.view).rightSpaceToView(self.view,0).heightIs(50);
    self.toobarView.hidden =YES;
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
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
        self.toobarView.sd_layout
        .bottomSpaceToView(self.view,0);
        [self.toobarView updateLayout];
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
        self.toobarView.sd_layout
        .bottomSpaceToView(self.view,keyboardH);
        [self.toobarView updateLayout];
        
    }];
}
//请求直购列表
- (void)requestDirectDataFromBack
{
    [RMTDataService getDataWithURL:GET_Product_List parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
       
      self.productListArray = [RMTDirctBuyProductModel mj_objectArrayWithKeyValuesArray:[responseObj objectForKey:@"data"]];
        RMTDirctBuyProductModel *first = [self.productListArray firstObject];
        RMTDirctBuyProductModel *model = [[RMTDirctBuyProductModel alloc] init];
        model.worth = @"10086";
        model.userId = @"-10086";
        model.productId = first.productId;
        
        [self.productListArray addObject:model];
       [self.drectBuyTableView reloadData];
        [self.drectBuyTableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
         [self.drectBuyTableView.mj_header endRefreshing];
    }];

   
    
    

}

//请求转让列表
- (void)requestTransferListDataFromBack
{
//
    
    [RMTDataService getDataWithURL:GET_Transfer_List parma:nil showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        self.transferDataSource = [RMTtransferListModel mj_objectArrayWithKeyValuesArray:[responseObj objectForKey:@"data"]];
        [self.changeTableView reloadData];
        [self.changeTableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
         [self.changeTableView.mj_header endRefreshing];
    }];
    [RMTDataService getDataWithURL:GET_Product_Usable parma:nil showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        self.tipsButton.hidden = ![[responseObj objectForKey:@"data"] boolValue];
        [self.changeTableView.mj_header endRefreshing];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [self.changeTableView.mj_header endRefreshing];
    }];
    
}
//请求卡包列表
- (void)requestpackCarListDataFromBack
{
    //
    
    [RMTDataService getDataWithURL:GET_CardPackaget_List parma:@{@"page":[NSString stringWithFormat:@"%d",self.carPage],@"pageSize":@"10"} showErrorMessage:YES showHUD:NO logData:NO success:^(NSDictionary *responseObj) {
        if (self.carPage ==1) {
            [self.cardDataSource removeAllObjects];
        }
        NSDictionary *data =[responseObj objectForKey:@"data"];
        NSMutableArray *arr = [RMTCarPackageModel mj_objectArrayWithKeyValuesArray:[[data objectForKey:@"cardPackageResponseBasePageable"] objectForKey:@"list"]];
        
        [self.cardDataSource addObjectsFromArray:arr];
      
        self.incrementValue =[data objectForKey:@"incrementValue"];
        
        self.totalCount =[data objectForKey:@"totalCount"];
        self.totalValue =[data objectForKey:@"totalValue"];
        self.yesterdayIncrement =[data objectForKey:@"yesterdayIncrement"];
        [self.carTableView reloadData];
        [self.carTableView.mj_header endRefreshing];
        [self.carTableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        [self.carTableView.mj_header endRefreshing];
        [self.carTableView.mj_footer endRefreshing];
        
    }];
  
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.changeTableView) {
        return 1;
    }else if (tableView == self.drectBuyTableView)
    {
        return 3;
    }else if (tableView == self.carTableView)
    {
        return 2;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.drectBuyTableView) {
        if (section == 1) {
            return self.productListArray.count>0?1:0;
        }else if (section ==2)
        {
            return self.productListArray.count>0?1:0;
        }
    }else if (tableView == self.changeTableView)
    {
        return self.transferDataSource.count;
    }else if (tableView == self.carTableView)
    {
        if (section == 0) {
            return 1;
        }
        return self.cardDataSource.count;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == self.drectBuyTableView) {
        if (indexPath.section ==0) {
            return d_screen_width *(270/640.0f);
        }else if (indexPath.section == 1 && self.productListArray.count>0)
        {
            NSInteger hangshu =self.productListArray.count %3==0?self.productListArray.count /3:self.productListArray.count /3+1;
            CGFloat height =  hangshu *productBtnH + (hangshu - 1)*marginBtnToBtn + 30;
            return height;
        }else if (indexPath.section ==2)
        {
            return 200.0f;
        }
    }else if (tableView == self.changeTableView)
    {
        return (d_screen_width-30) * (184/580.0f) + 15 +30 +40;
    }else if (tableView == self.carTableView)
    {
        if (indexPath.section == 0) {
            return 160.0f;
        }
        else
        {
          return   150 + d_screen_width*(46 /145.0f);
        }
    }
  
    return 55.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.drectBuyTableView) {
        if (section == 2) {
            return 200.0f;
        }
    }else if (tableView == self.carTableView)
    {
        if (section == 1) {
            return 100.0f;
        }
    }else if (tableView == self.changeTableView)
    {
        return 50.0f;
    }
    
    return 0.001f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.drectBuyTableView) {
        __weak typeof(self)weaself = self;
        if (indexPath.section == 0) {
            RMTDirectBuyHeaderCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return headCell;
        }else if (indexPath.section ==1)
        {
            RMTDirctProductListCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
            listCell.productList = self.productListArray;
            listCell.selectionStyle = UITableViewCellSelectionStyleNone;
            listCell.didSelectWillBuyCarModel = ^(RMTDirctBuyProductModel *model)
            {
                weaself.willBuyModel = model;
            };
            return listCell;
        }else if (indexPath.section == 2)
        {
            
            RMTProductListButButtonCell *buyCell = [tableView dequeueReusableCellWithIdentifier:@"buyCell"];
            buyCell.selectionStyle = UITableViewCellSelectionStyleNone;
            buyCell.buyButtonClickBock = ^(id data)
            {
                [weaself buyButtonClick:data];
            };
            return buyCell;
            
        }
    }else if (tableView == self.changeTableView)
    {
        RMTTransferAlivingCell *alivingCell = [tableView dequeueReusableCellWithIdentifier:@"alivingCell"];
      alivingCell.selectionStyle = UITableViewCellSelectionStyleNone;
        RMTtransferListModel *model = self.transferDataSource[indexPath.row];
        alivingCell.car_numberLabel.text = model.cardNo;
        alivingCell.zhukaLabel.text = [NSString stringWithFormat:@"主卡 ¥ %@",model.worth];
        alivingCell.timeLabel.text = model.transferTime;
        if ([model.status isEqualToString:@"transfer"]/*转让中*/) {
            alivingCell.stautesImageView.hidden = YES;
            alivingCell.productImageView .image =[UIImage imageNamed:@"direct_buy_healthCar"];
            alivingCell.car_numberLabel.textColor = UIColorFromRGB(0x000000);
            alivingCell.zhukaLabel.textColor = UIColorFromRGB(0x000000);
        }else
        {
            alivingCell.stautesImageView.hidden = NO;
            alivingCell.productImageView .image =[UIImage imageNamed:@"already_transfer_image"];
            alivingCell.car_numberLabel.textColor = UIColorFromRGB(0x868686);
            alivingCell.zhukaLabel.textColor = UIColorFromRGB(0x868686);

        }
        
        return alivingCell;
    }else if (tableView == self.carTableView)
    {
    
        if (indexPath.section == 0) {
            
            RMTMoneyPackageHeadCell *headCellpack = [tableView dequeueReusableCellWithIdentifier:@"headCellpack"];
             headCellpack.selectionStyle = UITableViewCellSelectionStyleNone;
            
            headCellpack.totalMoneyLabel.text = [NSString stringWithFormat:@"¥ %@",self.totalValue];
            headCellpack.daijinquanLabel.text = [NSString stringWithFormat:@"代金券¥ %@",self.incrementValue];
            headCellpack.yeasterdayMoneyLabel.text = [NSString stringWithFormat:@"昨日增值¥ %@",self.yesterdayIncrement];
            return headCellpack;
        }
        
        RMTMoneyPackageCarCell *carCell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
         carCell.selectionStyle = UITableViewCellSelectionStyleNone;
        RMTCarPackageModel *model =self.cardDataSource[indexPath.row];
        carCell.model = model;
        __weak typeof(self)weakself = self;
        carCell.transferButtonClickBlock = ^(id dta)
        {
            [weakself transferHeathCarWithModel:dta];
        };
        carCell.carNumberLabel.text =model.cardNo;
        carCell.timeLabel.text = model.resaleDate;
        carCell.monthLabel.text = [NSString stringWithFormat:@"%@  %@",[model.canTransferDate substringWithRange:NSMakeRange(5, 1)],[model.canTransferDate substringWithRange:NSMakeRange(6, 1)]];
        carCell.dayLabel.text = [NSString stringWithFormat:@"%@  %@",[model.canTransferDate substringWithRange:NSMakeRange(8, 1)],[model.canTransferDate substringWithRange:NSMakeRange(9, 1)]];
        
        carCell.daijinquanLabel.text = [NSString stringWithFormat:@"代金券 ¥%@",model.cashCoupon];
        carCell.moneyLabel.text = [NSString stringWithFormat:@"¥ %@",model.totalWorth];
        if ([model.status isEqualToString:@"increment"]/*增值中，可转让*/) {
            [carCell setButtonColorWithStates:YES];
        }else
        {
             [carCell setButtonColorWithStates:NO];
        }
        
        return carCell;
        
   
    }

    
  
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试";
    return cell;


}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![RMTTool isNumberRegex:string]) {
        return NO;
    }
    return YES;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    if (![scrollView isKindOfClass:[UITableView class]]) {
        [self.segControl setSelectedSegmentIndex:(int)(scrollView.contentOffset.x/d_screen_width)];
        if (self.segControl.selectedSegmentIndex == 1) {
            [self.tabBarController.tabBar setHidden:YES];
            self.toobarView.hidden =NO;
        }else
        {
            [self.tabBarController.tabBar setHidden:NO];
            self.toobarView.hidden =YES;
        }
        
        
    }
    
}


#pragma mark  click--even
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}

#pragma mark==== 点击转让会调用的方法
- (void)transferHeathCarWithModel:(RMTCarPackageModel *)carModel
{

    RMTPutPasswrdView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMTPutPasswrdView" owner:nil options:nil]firstObject];
    __weak typeof(view)weakView = view;
    __weak typeof(self)weakself =self;
    view.userHasPutPassWord = ^(NSString *passwd)
    {
        NSLog(@"用户密码为 %@",passwd);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself transferHeathCarAfterPutPasswdWithModel:carModel andPasswd:passwd];
        });
      
        [UIView animateWithDuration:0.25 animations:^{
            weakView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [weakView removeFromSuperview];
        }];
        
        
    };
    [view showInWindow];
}
- (void)transferHeathCarAfterPutPasswdWithModel:(RMTCarPackageModel *)carModel andPasswd:(NSString *)passwd
{
    NSLog(@"用户密码为 %@",passwd);
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    parmeters[@"cardPackageId"] = carModel.cardPackageId;
    
    parmeters[@"tradePassword"] = passwd;
    
    parmeters[@"number"] = carModel.number;
    [RMTDataService postDataWithURL:POST_Cardpackage_Transfer parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        [SGShowMesssageTool showMessage:@"转让成功"];
        carModel.status =@"transfer";
        [self.carTableView reloadData];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
}

#pragma mark ====购买按钮的点击事件
- (void)buyButtonClick:(UIButton *)sender
{
    
    if (sender == self.tipsButton/*前往直购厅购买*/) {
        [self.bgScrollView setContentOffset:CGPointMake(0,0) animated:YES];
        self.segControl.selectedSegmentIndex= 0;
        if (self.segControl.selectedSegmentIndex == 1) {
            [self.tabBarController.tabBar setHidden:YES];
            self.toobarView.hidden =NO;
        }else
        {
            [self.tabBarController.tabBar setHidden:NO];
            self.toobarView.hidden =YES;
        }
    }else
    {
        if (!self.willBuyModel) {
            [SGShowMesssageTool showMessage:@"请选择要购买的直购卡" showTime:1.5f];
            return;
        }
        if ( [self.willBuyModel.worth intValue]%100 !=0) {
            [SGShowMesssageTool showMessage:@"输入的金额必须为100的整数倍" showTime:1.5f];
            return;
        }
        
       
        
        RMTPayPageViewController *pay = [[RMTPayPageViewController alloc] init];
        if ([self.willBuyModel.userId isEqualToString:@"-10086"]) {
            
             pay.numberCar = [NSString stringWithFormat:@"%d",[self.willBuyModel.worth intValue]/100];
        }else
        {
         pay.numberCar = self.willBuyModel.quantityList;
        
        }
        pay.productID =self.willBuyModel.productId;
        pay.buyType = BuyCarType_direct_buy;
       
        [self.navigationController pushViewController:pay animated:YES];
    }

   
    
    
}


#pragma mark ===segmentControl的点击事件
-(void)segmentControlClickAction:(UISegmentedControl *)seg
{
    NSLog(@"%ld",seg.selectedSegmentIndex);
    
    [self.bgScrollView setContentOffset:CGPointMake(d_screen_width *seg.selectedSegmentIndex,0) animated:YES];
    if (self.segControl.selectedSegmentIndex == 1) {
        [self.tabBarController.tabBar setHidden:YES];
        self.toobarView.hidden =NO;
    }else
    {
        [self.tabBarController.tabBar setHidden:NO];
        self.toobarView.hidden =YES;
    }

}


@end
