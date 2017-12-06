//
//  NearByInfoCell.h
//  HuiHui
//
//  Created by mac on 2017/6/29.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NearByInfoFrame;

@interface NearByInfoCell : UITableViewCell

+ (instancetype)NearByInfoCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) NearByInfoFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t daoHaoBlock;

@end
