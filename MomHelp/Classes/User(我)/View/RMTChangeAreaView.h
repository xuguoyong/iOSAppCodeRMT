//
//  RMTChangeAreaView.h
//  MomHelp
//
//  Created by guoyong xu on 16/10/18.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMTChangeAreaView : UIView <UIPickerViewDelegate,UIPickerViewDataSource>
- (void)showInWindow;
@property (weak, nonatomic) IBOutlet UIPickerView *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (nonatomic,strong) void(^selectAreaBlcok)(NSDictionary *area);



@end
