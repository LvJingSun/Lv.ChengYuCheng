//
//  H_TuiJianCell.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_TuiJianFrame;

@interface H_TuiJianCell : UITableViewCell

+ (instancetype)H_TuiJianCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) H_TuiJianFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t shareBlock;

@property (nonatomic, copy) dispatch_block_t copyBlock;

@property (nonatomic, copy) dispatch_block_t mailBlock;

@end
