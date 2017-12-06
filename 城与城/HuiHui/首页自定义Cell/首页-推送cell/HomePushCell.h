//
//  HomePushCell.h
//  HuiHui
//
//  Created by mac on 2017/9/5.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomePushFrame;

@interface HomePushCell : UITableViewCell

+ (instancetype)HomePushCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HomePushFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t clickBlock;

@end
