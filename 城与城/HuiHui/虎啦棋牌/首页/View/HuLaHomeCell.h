//
//  HuLaHomeCell.h
//  HuiHui
//
//  Created by mac on 2017/11/2.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HuLaHomeFrame;

@interface HuLaHomeCell : UITableViewCell

+ (instancetype)HuLaHomeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HuLaHomeFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t bindBlock;

@property (nonatomic, copy) dispatch_block_t delegate_Block;

@property (nonatomic, copy) dispatch_block_t Send_Block;

@property (nonatomic, copy) dispatch_block_t ToOther_Block;

@property (nonatomic, copy) dispatch_block_t ToMe_Block;

@end
