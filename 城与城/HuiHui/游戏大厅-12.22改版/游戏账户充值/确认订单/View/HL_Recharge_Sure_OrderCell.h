//
//  HL_RechargeOrderCell.h
//  HuiHui
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_Recharge_Sure_OrderFrame;

@interface HL_Recharge_Sure_OrderCell : UITableViewCell

+ (instancetype)HL_Recharge_Sure_OrderCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_Recharge_Sure_OrderFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t zfbBlock;

@property (nonatomic, copy) dispatch_block_t wxBlock;

@property (nonatomic, copy) dispatch_block_t cycBlock;

@property (nonatomic, copy) dispatch_block_t fsbBlock;

@end
