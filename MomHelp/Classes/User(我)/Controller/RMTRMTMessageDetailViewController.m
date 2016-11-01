//
//  RMTRMTMessageDetailViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/17.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTRMTMessageDetailViewController.h"

@interface RMTRMTMessageDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageContentTextView;

@end

@implementation RMTRMTMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title  =@"消息详情";
    self.messageTitle.text = self.detailModel.title;
    self.messageTimeLabel.text = self.detailModel.date;
    self.messageContentTextView.text = self.detailModel.content;
    [self setMessageHadRead];
}

- (void)setMessageHadRead
{
    [RMTDataService getDataWithURL:GET_Message_Details  parma:@{@"messageId":self.detailModel.noticeId} showErrorMessage:YES showHUD:YES logData:YES success:^(NSDictionary *responseObj) {
        
    } failure:^(NSError *error, NSString *errorCode, NSString *remark) {
        
    }];

}


@end
