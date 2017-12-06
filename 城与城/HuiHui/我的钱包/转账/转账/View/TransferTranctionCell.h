//
//  TransferTranctionCell.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TransferTransactionFrame;

@protocol TransferTransaction_FieldDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface TransferTranctionCell : UITableViewCell

+ (instancetype)TransferTranctionCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) TransferTransactionFrame *frameModel;

@property (nonatomic, strong) id<TransferTransaction_FieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
