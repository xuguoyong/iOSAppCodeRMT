//
//  RMTDirctProductListCell.m
//  MomHelp
//
//  Created by guoyong xu on 16/10/20.
//  Copyright © 2016年 hudongkeji. All rights reserved.
//

#import "RMTDirctProductListCell.h"
#import "RMTProductListView.h"

@interface RMTDirctProductListCell ()
@property (nonatomic,strong) RMTProductListView *listView;

@end

@implementation RMTDirctProductListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}

/**
 创建UI
 */
- (void)createUI
{
    self.listView = [[RMTProductListView alloc] init];
    [self.contentView addSubview:self.listView];
    self.listView.sd_layout.topEqualToView(self.contentView).offset(15).leftEqualToView(self.contentView).offset(15);
    
}
- (void)setProductList:(NSMutableArray *)productList
{
    _productList = productList;
    self.listView.productList = productList;
}
@end
