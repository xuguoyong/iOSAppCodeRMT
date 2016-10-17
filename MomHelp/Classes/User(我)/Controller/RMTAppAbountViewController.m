//
//  RMTAppAbountViewController.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/14.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTAppAbountViewController.h"

@interface RMTAppAbountViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;

@end

@implementation RMTAppAbountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // app版本
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version = [appInfo objectForKey:@"CFBundleShortVersionString"];
    // app build版本
   self.appVersionLabel.text = [NSString stringWithFormat:@"version %@ %@",app_Version,VersionType];
    self.appVersionLabel.textAlignment = NSTextAlignmentCenter;
 
}



@end
