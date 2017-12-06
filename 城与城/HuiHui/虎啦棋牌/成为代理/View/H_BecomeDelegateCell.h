//
//  H_BecomeDelegateCell.h
//  HuiHui
//
//  Created by mac on 2017/11/3.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_BecomeDelegateFrame;

@interface H_BecomeDelegateCell : UITableViewCell

+ (instancetype)H_BecomeDelegateCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) H_BecomeDelegateFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t lookBlock;

@property (nonatomic, copy) dispatch_block_t buyBlock;

@end
