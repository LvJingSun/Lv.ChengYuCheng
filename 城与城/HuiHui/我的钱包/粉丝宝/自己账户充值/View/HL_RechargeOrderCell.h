//
//  HL_RechargeOrderCell.h
//  HuiHui
//
//  Created by mac on 2017/12/20.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_RechargeOrderFrame;

@interface HL_RechargeOrderCell : UITableViewCell

+ (instancetype)HL_RechargeOrderCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_RechargeOrderFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t zfbBlock;

@property (nonatomic, copy) dispatch_block_t wxBlock;

@property (nonatomic, copy) dispatch_block_t cycBlock;

@property (nonatomic, copy) dispatch_block_t fsbBlock;

@end
