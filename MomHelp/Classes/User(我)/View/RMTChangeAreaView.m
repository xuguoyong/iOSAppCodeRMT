//
//  RMTChangeAreaView.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTChangeAreaView.h"
#import "RMTAreaModel.h"
#import "NSFileManager+HomeDocumentPath.h"

@interface RMTChangeAreaView ()
@property (nonatomic,strong) NSMutableArray *dataSources;
@property (nonatomic,strong) NSMutableArray *provinceSources;
@property (nonatomic,strong) NSMutableArray *citySources;
@property (nonatomic,strong) NSMutableArray *areaSources;

@end


@implementation RMTChangeAreaView

- (NSMutableArray *)dataSources
{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}
- (NSMutableArray *)areaSources
{
    if (!_areaSources) {
        _areaSources = [[NSMutableArray alloc] init];
    }
    return _areaSources;
}
- (NSMutableArray *)provinceSources
{
    if (!_provinceSources) {
        _provinceSources = [[NSMutableArray alloc] init];
    }
    return _provinceSources;
}
- (NSMutableArray *)citySources
{
    if (!_citySources) {
        _citySources = [[NSMutableArray alloc] init];
    }
    return _citySources;
}
-(void)awakeFromNib
{
    [super awakeFromNib];[self requestData];
    self.datePicker.delegate = self;
    self.datePicker.dataSource = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHideenHimSelf)];
    [self addGestureRecognizer:tap];
    
}

- (void)touchHideenHimSelf
{
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
    }];
}
-(void)showInWindow
{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];
    self.alpha = 0.0f;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1.0f;
    }];
    
}

- (void)requestData
{
    [self.dataSources removeAllObjects];
    [RMTDataService getDataWithURL:GET_Area_List parma:nil showErrorMessage:YES showHUD:YES logData:NO success:^(NSDictionary *responseObj) {

    
        for (NSDictionary *dic in [responseObj objectForKey:@"data"]) {
            RMTAreaModel *area = [RMTAreaModel mj_objectWithKeyValues:dic];
            [self.dataSources addObject:area];
            if (self.dataSources.count ==1) {
                RMTAreaModel *modelP = self.dataSources[0];
                
                self.citySources = modelP.child;
                if (self.citySources.count > 0) {
                    RMTAreaModel *area = self.citySources[0];
                    self.areaSources = area.child;
                }
            }
        }
        [self.datePicker reloadAllComponents];
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

    
}
- (IBAction)buttonClick:(id)sender {
    
   
    
    if (sender == self.cancelButton) {
        __weak typeof(self)weakself = self;
        [UIView animateWithDuration:0.25 animations:^{
            weakself.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [weakself removeFromSuperview];
        }];
    }else
    {
        
        RMTAreaModel *province = self.dataSources[[self.datePicker selectedRowInComponent:0]];
        RMTAreaModel *city = self.citySources[[self.datePicker selectedRowInComponent:1]];
        RMTAreaModel *area =nil;
        if (self.areaSources.count > 0) {
         area = self.areaSources[[self.datePicker selectedRowInComponent:2]];
        }
        
        NSMutableDictionary *areaDict = [NSMutableDictionary dictionary];
        areaDict[@"provinceId"] =province.areaId;
        areaDict[@"provinceName"] = province.areaName;
        areaDict[@"cityId"] = city.areaId;
        areaDict[@"cityName"] = city.areaName;
        if (area) {
            areaDict[@"areaId"] = area.areaId;
            areaDict[@"areaName"] = area.areaName;
        }
       
        if (self.selectAreaBlcok ) {
            self.selectAreaBlcok(areaDict);
        }
        
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
   
    if (component ==0) {
        return  self.dataSources.count;
    }else if (component == 1)
    {
        
      return  self.citySources.count;

    }
    return self.areaSources.count;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
 
    RMTAreaModel *model = nil;
    if (component ==0) {
        model = self.dataSources[row];
    }else if (component ==1)
    {
        model = self.citySources[row];
        
    }else
    {
         model = self.areaSources[row];
    
    }
    return model.areaName;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component ==0) {
         RMTAreaModel *modelP = self.dataSources[row];
        
        self.citySources = modelP.child;
        
        RMTAreaModel *area = self.citySources[[pickerView selectedRowInComponent:1]];
        self.areaSources = area.child;
        [pickerView reloadComponent:1];
        [pickerView reloadComponent:2];
        
    }else if (component ==1)
    {
        RMTAreaModel *area = self.citySources[row];
        self.areaSources = area.child;
        [pickerView reloadComponent:2];
    }

}

#pragma mark =============s设置上面的字体自适应大小=======================================
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel. minimumFontSize = 10.0f;
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:20]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
@end
