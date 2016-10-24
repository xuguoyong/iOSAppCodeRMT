//
//  RMTProductListView.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTProductListView.h"

/**
 *  每个产品的大小
 */
#define productBtnW ((d_screen_width - 50)/3.0f)
#define productBtnH productBtnW *(88/180.0f)
/**
 *  每个产品之间的距离
 */
#define marginBtnToBtn 10

@interface RMTProductListView ()<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) UITextField *putTextField;;

@end


@implementation RMTProductListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        self.putTextField = [[UITextField alloc] init];
        self.putTextField.placeholder = @"填写金额";
        self.putTextField.textAlignment = NSTextAlignmentCenter;
        self.putTextField.keyboardType = UIKeyboardTypeNumberPad;
        self.putTextField.layer.cornerRadius = 3.0f;
        self.putTextField.layer.borderWidth = 0.5f;
        self.putTextField.layer.borderColor = UIColorFromRGB(0x979797).CGColor;
        self.putTextField.delegate = self;
        [self addSubview:self.putTextField];
        
    }
    return self;
}
- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 30; i++) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(productButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i + 100;
        btn.layer.cornerRadius = 3.0f;
        btn.layer.borderWidth = 0.5f;
        btn.layer.borderColor = UIColorFromRGB(0x979797).CGColor;
        [btn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [btn setTitleColor:MainColor forState:UIControlStateSelected];
        [self addSubview:btn];
        [temp addObject:btn];
        
    }
    
    self.buttonArray = [temp copy];
}

-(void)setProductList:(NSMutableArray *)productList{
    
    _productList = productList;
    for (long i = _productList.count; i < self.buttonArray.count; i++) {
        UIButton *btn = [self.buttonArray objectAtIndex:i];
        btn.hidden = YES;
    }

    if (_productList.count == 0) {
        self.height = 0;
        self.fixedHeight = @(0);
        return;
    }
    
    CGFloat itemW = productBtnW;
    CGFloat itemH = productBtnH;
    long perRowItemCount =3;
    
    for (NSInteger idx = 0; idx <_productList.count; idx ++) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        if (idx == _productList.count - 1) {
            
            self.putTextField.frame = CGRectMake(columnIndex * (itemW + marginBtnToBtn), rowIndex * (itemH + marginBtnToBtn), itemW, itemH);
        }else
        {
            UIButton *btn = [_buttonArray objectAtIndex:idx];
            btn.hidden = NO;
            RMTDirctBuyProductModel *model = [_productList objectAtIndex:idx];
            int money = [model.worth intValue] *[model.quantityList intValue];
            [btn setTitle:[NSString stringWithFormat:@"%d元",money] forState:UIControlStateNormal];
            btn.frame = CGRectMake(columnIndex * (itemW + marginBtnToBtn), rowIndex * (itemH + marginBtnToBtn), itemW, itemH);
        }
       
    }
  
    
    
    CGFloat w = perRowItemCount * itemW + (perRowItemCount - 1) * marginBtnToBtn;
    int columnCount = ceilf(_productList.count * 1.0 / perRowItemCount);
    CGFloat h = columnCount * itemH + (columnCount - 1) * marginBtnToBtn;
    self.width = w;
    self.height = h;
    self.fixedHeight = @(h);
    self.fixedWidth = @(w);
    
}


#pragma mark ===每个产品按钮的点击事件
- (void)productButtonClick:(UIButton *)sender
{
    for (NSInteger i = 0; i< self.productList.count; i ++) {
        UIButton *btn = [self.buttonArray objectAtIndex:i];
         btn.layer.borderColor = UIColorFromRGB(0xE1E1E1).CGColor;
        btn.selected = NO;
    }
 
    self.putTextField.layer.borderColor = UIColorFromRGB(0xE1E1E1).CGColor;
    sender.selected = YES;
     sender.layer.borderColor = MainColor.CGColor;
    
    RMTDirctBuyProductModel *model = [_productList objectAtIndex:sender.tag - 100];
    if (self.didSelectWillBuyCarModel) {
        self.didSelectWillBuyCarModel(model);
    }
    
    

}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    for (NSInteger i = 0; i< self.productList.count; i ++) {
        UIButton *btn = [self.buttonArray objectAtIndex:i];
        btn.layer.borderColor = UIColorFromRGB(0xE1E1E1).CGColor;
        btn.selected = NO;
    }
     self.putTextField.layer.borderColor = MainColor.CGColor;
   
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (![RMTTool isNumberRegex:string]) {
        return NO;
    }
    
   
    
    return YES;
}



- (void)textFieldDidEndEditing:(UITextField *)textField{

    RMTDirctBuyProductModel *model = [_productList lastObject];
    model.worth = textField.text;
    if (self.didSelectWillBuyCarModel) {
        self.didSelectWillBuyCarModel(model);
    }
}

@end
