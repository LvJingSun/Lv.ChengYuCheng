//
//  BuyDelegateCell.h
//  HuiHui
//
//  Created by mac on 2017/11/15.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyDelegateFrame;

@interface BuyDelegateCell : UITableViewCell

+ (instancetype)BuyDelegateCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) BuyDelegateFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t oneBlock;

@property (nonatomic, copy) dispatch_block_t twoBlock;

@property (nonatomic, copy) dispatch_block_t threeBlock;

@property (nonatomic, copy) dispatch_block_t cycBlock;

@property (nonatomic, copy) dispatch_block_t wxBlock;

@property (nonatomic, copy) dispatch_block_t zfbBlock;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
