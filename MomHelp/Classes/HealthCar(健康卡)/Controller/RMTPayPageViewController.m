//
//  RMTPayPageViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTPayPageViewController.h"
#import "RMTPayPageHeadCell.h"
#import "RMTSelectPayTypeCelll.h"
#import "UPPaymentControl.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RMTYEEBaopayViewController.h"
#import "RMTPutPasswrdView.h"
#import "RMTBuyProdecuOrCarSuccessViewController.h"

typedef NS_ENUM(NSUInteger,PayType) {
    PayType_Unionpay,//银联
    PayType_Zhifubao,//支付宝
    PayType_Yeepay,//易宝
    PayType_Balance//余额
};


@interface RMTPayPageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
    
@property (nonatomic,strong) NSMutableArray *select;

@end

@implementation RMTPayPageViewController


-(NSMutableArray *)select
{
    if (!_select) {
        _select = [[NSMutableArray alloc] init];
        
        for (NSInteger i = 0; i < 5; i++) {
          [_select addObject:[NSNumber numberWithBool:NO]];
        }
      
    }
    return _select;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付";
    self.tableView = [self addTableViewWithDelegate:self style:UITableViewStyleGrouped];
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTPayPageHeadCell" bundle:nil] forCellReuseIdentifier:@"headCell"];
    
     [self.tableView registerNib:[UINib nibWithNibName:@"RMTSelectPayTypeCelll" bundle:nil] forCellReuseIdentifier:@"typeCell"];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUnionPayTypeStautes:) name:NotificationUionPayStaues object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAliyPayTypeStautes:) name:NotificationAlipayPayStaues object:nil];

    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    
    return 5;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return (d_screen_width-30)*(92/290.0f)+30+30+40;
    }
    if (indexPath.section == 1 &&indexPath.row ==0) {
        return 44.0f;
    }
    
    return 55.0f;

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 200.0f;
    }
    return 0.001f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RMTPayPageHeadCell *headCell = [tableView dequeueReusableCellWithIdentifier:@"headCell"];
        headCell.timeLabel.text = [NSDate getCurrentStandarTimeWithFormatter:@"M月d日HH时mm分"];
        if (self.buyType == BuyCarType_direct_buy) {
          headCell.moneyLabel.text =[NSString stringWithFormat:@"主卡 ¥%d",[self.numberCar intValue]*100];
        }else
        {
        
         headCell.moneyLabel.text =[NSString stringWithFormat:@"主卡 ¥%@",self.trabsferMoney];
        }
       
        return headCell;
    }else if (indexPath.section ==1&&indexPath.row !=0 )
    {
        
        RMTSelectPayTypeCelll *typeCell = [tableView dequeueReusableCellWithIdentifier:@"typeCell"];
        NSString *imageName = nil;
        NSString *typeName = nil;
        if (indexPath.row ==1) {
            imageName = @"yinlian_icon";
            typeName = @"银联支付";
        }else if (indexPath.row == 2)
        {
            imageName = @"zhifubao_icon";
            typeName = @"支付宝支付";
        }else if (indexPath.row ==3)
        {
            imageName = @"yibo_icon";
            typeName = @"易宝支付";
        }else if (indexPath.row ==4)
        {
            imageName = @"yuezhifu_icon";
            typeName = @"余额支付";
        
        }
        
        if (![[self.select objectAtIndex:indexPath.row] boolValue]) {
          typeCell.selectImageView.image =[UIImage imageNamed:@"un_select_pay"];
        }else
        {
             typeCell.selectImageView.image = [UIImage imageNamed:@"select_pay"];
        }
        
        typeCell.typeImageView.image = [UIImage imageNamed:imageName];
        typeCell.typeName.text = typeName;
        return typeCell;
       
        
    
    }
    
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor = UIColorFromRGB(0x868686);
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    cell.textLabel.text = @"选择支付方式";
    return cell;

    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, d_screen_width, 80)];
        UIButton *btn = [UIButton custombuttonNormalStateWithTitile:@"确认支付" titleFont:textFont32 titleColor:MainColor butttonImage:nil backgroundImage:nil backgroundColor:nil clickThingTarget:self action:@selector(comfirmPayButtonClick:)];
        btn.frame = CGRectMake(15, 30, d_screen_width - 30, 45);
        btn.layer.cornerRadius = 5.0f;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = MainColor.CGColor;
        [view addSubview:btn];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1&&indexPath.row != 0) {
        
        for (NSInteger i = 0; i < self.select.count; i ++) {
          [self.select replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:NO]];
        }
        [self.select replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
       
        [self.tableView reloadData];
    }
    
}
- (void)comfirmPayButtonClick:(UIButton *)bar
{
    
    NSInteger index = 0;
    for (NSInteger i = 0; i < self.select.count; i ++) {
        BOOL result = [[self.select objectAtIndex:i] boolValue];
        if (result) {
            index = i;
            break;
        }
        
    }
    
    
    if (index ==0) {
        [SGShowMesssageTool showMessage:@"请选择一种支付方方式"];
        return;
    }
    
   
 
    
    switch (index) {
        case 1:
        {
            [self payForPayType_Unionpay:PayType_Unionpay];
        
        }
            break;
        case 2:
        {
            [self payForPayPayType_Zhifubao:PayType_Zhifubao];
            
        }
            break;
        case 3:
        {
            [self payForPayType_Yeepay:PayType_Yeepay];
        }
            break;
        case 4:
        {
            RMTPutPasswrdView *view = [[[NSBundle mainBundle] loadNibNamed:@"RMTPutPasswrdView" owner:nil options:nil]firstObject];
            __weak typeof(view)weakView = view;
            __weak typeof(self)weakself =self;
            view.userHasPutPassWord = ^(NSString *passwd)
            {
                NSLog(@"用户密码为 %@",passwd);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself payForPayPayType_Balance:PayType_Balance passwd:passwd];
                });
                
                
                [UIView animateWithDuration:0.25 animations:^{
                    weakView.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    [weakView removeFromSuperview];
                }];
                
                
            };
            [view showInWindow];
            
            
          
        }
            break;
      
            
        default:
            break;
    }
    
}

//银联支付
- (void)payForPayType_Unionpay:(PayType)type
{
    NSLog(@"银联支付");
    
    NSString *URL = nil;
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    if (self.buyType == BuyCarType_trasfer) {
        URL = GET_CardPackage_Buy;
        parmeters[@"money"] = self.trabsferMoney;
    }else
    {
        URL = GET_Product_Buy;
        parmeters[@"productId"] = self.productID;
        parmeters[@"number"] = self.numberCar;
        
    }
    
    parmeters[@"paymentType"] =  @"unionpay";;
    parmeters[@"tradeOrderType"] = @"";
    parmeters[@"tradePassword"] = self.payPassword?self.payPassword:@"";
    
    [RMTDataService postDataWithURL:URL parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        NSDictionary *data = [responseObj objectForKey:@"data"];
        NSString *payOrderString = [data objectForKey:@"payOrderString"];
        
        if (payOrderString != nil && payOrderString.length > 0)
        {
            [[UPPaymentControl defaultControl]
             startPay:payOrderString
             fromScheme:@"com.91stjk.shentijiankang"
             mode:UionPayModel
             viewController:self];
        }
        
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    

    
}
//支付宝支付
- (void)payForPayPayType_Zhifubao:(PayType)type
{
    NSLog(@"支付宝支付");
    NSString *URL = nil;
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    if (self.buyType == BuyCarType_trasfer) {
        URL = GET_CardPackage_Buy;
        parmeters[@"money"] = self.trabsferMoney;
    }else
    {
        URL = GET_Product_Buy;
        parmeters[@"productId"] = self.productID;
        parmeters[@"number"] = self.numberCar;
        
    }
    
    parmeters[@"paymentType"] =  @"zhifubao";;
    parmeters[@"tradeOrderType"] = @"";
    parmeters[@"tradePassword"] = self.payPassword?self.payPassword:@"";
    
    [RMTDataService postDataWithURL:URL parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        NSDictionary *data = [responseObj objectForKey:@"data"];
        NSString *payOrderString = [data objectForKey:@"payOrderString"];
        NSString *appScheme = @"com.91stjk.shentijiankang";
        
 
        [[AlipaySDK defaultService] payUrlOrder:payOrderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
           
            [self getAliyPayTypeStautes:resultDic];
            
        }];
        
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
    
}
//易宝支付
- (void)payForPayType_Yeepay:(PayType)type
{
    NSLog(@"易宝支付");
    NSString *URL = nil;
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    if (self.buyType == BuyCarType_trasfer) {
        URL = GET_CardPackage_Buy;
        parmeters[@"money"] = self.trabsferMoney;
    }else
    {
        URL = GET_Product_Buy;
        parmeters[@"productId"] = self.productID;
        parmeters[@"number"] = self.numberCar;
        
    }
    
    parmeters[@"paymentType"] =  @"yeepay";
    parmeters[@"tradeOrderType"] = @"";
    parmeters[@"tradePassword"] = self.payPassword?self.payPassword:@"";
    
    [RMTDataService postDataWithURL:URL parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        NSDictionary *data = [responseObj objectForKey:@"data"];
        NSDictionary *payOrderData = data[@"payOrderData"];
        NSString *payUrl = payOrderData[@"payUrl"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (payUrl) {
                RMTYEEBaopayViewController *yeeb = [[RMTYEEBaopayViewController alloc] init];
                yeeb.urlString = payUrl;
                [self.navigationController pushViewController:yeeb animated:YES];
            }else
            {
                [SGShowMesssageTool showMessage:@"易宝支付请求失败"];
            }
           
        });
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];



}
//余额支付
- (void)payForPayPayType_Balance:(PayType)type passwd:(NSString *)passwd
{
    
    NSLog(@"余额支付");
    
    NSLog(@"易宝支付");
    NSString *URL = nil;
    NSMutableDictionary *parmeters = [NSMutableDictionary dictionary];
    if (self.buyType == BuyCarType_trasfer) {
        URL = GET_CardPackage_Buy;
        parmeters[@"money"] = self.trabsferMoney;
    }else
    {
        URL = GET_Product_Buy;
        parmeters[@"productId"] = self.productID;
        parmeters[@"number"] = self.numberCar;
        
    }
    
    parmeters[@"paymentType"] =  @"balance";
    parmeters[@"tradeOrderType"] = @"";
    parmeters[@"tradePassword"] = passwd;
    
    [RMTDataService postDataWithURL:URL parma:parmeters showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {
        NSLog(@"%@",responseObj);
        [SGShowMesssageTool showMessage:@"支付成功"];
        if (self.buySccessBlock) {
            self.buySccessBlock(nil);
        }
        [self popToSuccessPage];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];
    
}




#pragma mark====一下方法是支付之后的回调

//银联支付的回调
- (void)getUnionPayTypeStautes:(NSNotification *)not
{
    NSDictionary *userInfo = not.userInfo;
    NSString *code = [userInfo objectForKey:@"stautes"];
    //结果code为成功时，先校验签名，校验成功后做后续处理
    if([code isEqualToString:@"success"]) {
        
        //交易成功
        [SGShowMesssageTool showMessage:@"支付成功"];
        if (self.buySccessBlock) {
            self.buySccessBlock(nil);
        }
      [self popToSuccessPage];
        
        
    }
    else if([code isEqualToString:@"fail"]) {
        //交易失败
        [SGShowMesssageTool showMessage:@"支付失败"];
    }
    else if([code isEqualToString:@"cancel"]) {
        //交易取消
        [SGShowMesssageTool showMessage:@"取消支付"];
    }
}
//支付宝回调
- (void)getAliyPayTypeStautes:(id )not
{
    NSDictionary *uerinfo = nil;
    if ([not isKindOfClass:[NSDictionary class]]) {
        uerinfo = not;
    }else
    {
        
        NSNotification *nn = not;
        uerinfo=nn.userInfo;
    }
    NSString *stautes = uerinfo[@"resultCode"][@"resultCode"];
    
    
    if ([stautes intValue] ==9000/*订单支付成功*/) {
    [SGShowMesssageTool showMessage:@"订单支付成功"] ;
        if (self.buySccessBlock) {
            self.buySccessBlock(nil);
        }
        [self popToSuccessPage];
    }else if ([stautes intValue] ==8000/*正在处理中*/)
    {
      [SGShowMesssageTool showMessage:@"订单已经提交，支付结果返回前，请勿重复支付！" showTime:2.0f];
    }else if ([stautes intValue] ==84000/*订单支付失败*/)
    {
        [SGShowMesssageTool showLoadingHUDWithErrorMessage:@"订单支付失败~"];
    }else if ([stautes intValue] ==6001/*用户中途取消*/)
    {
        [SGShowMesssageTool showMessage:@"取消支付"] ;
    }else
    {
        [SGShowMesssageTool showMessage:@"支付失败，请稍后重试！" showTime:2.0f];
    }
    
    
//    9000 订单支付成功
//    8000
//    4000
//    6001
//    6002
    

}


- (void)popToSuccessPage
{
    RMTBuyProdecuOrCarSuccessViewController *success = [[RMTBuyProdecuOrCarSuccessViewController alloc] initWithNibName:@"RMTBuyProdecuOrCarSuccessViewController" bundle:nil];
    success.money = [self.numberCar intValue]*100;
    [self.navigationController pushViewController:success animated:YES];

}

@end
