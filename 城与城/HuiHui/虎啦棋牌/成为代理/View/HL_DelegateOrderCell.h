//
//  HL_DelegateOrderCell.h
//  HuiHui
//
//  Created by mac on 2017/12/14.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_DelegateOrderFrame;

@interface HL_DelegateOrderCell : UITableViewCell

+ (instancetype)HL_DelegateOrderCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_DelegateOrderFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t zfbBlock;

@property (nonatomic, copy) dispatch_block_t wxBlock;

@property (nonatomic, copy) dispatch_block_t cycBlock;

@end
