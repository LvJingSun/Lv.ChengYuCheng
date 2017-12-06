//
//  SureIDInfoCell.h
//  HuiHui
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SureIDInfoFrame;

@interface SureIDInfoCell : UITableViewCell

+ (instancetype)SureIDInfoCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) SureIDInfoFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
