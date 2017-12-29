//
//  HL_RecommendCell.h
//  HuiHui
//
//  Created by mac on 2017/12/25.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_RecommendFrame;

@interface HL_RecommendCell : UITableViewCell

+ (instancetype)HL_RecommendCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_RecommendFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t QQBlock;

@property (nonatomic, copy) dispatch_block_t QZoneBlock;

@property (nonatomic, copy) dispatch_block_t WXBlock;

@property (nonatomic, copy) dispatch_block_t CircleBlock;

@property (nonatomic, copy) dispatch_block_t MessageBlock;

@property (nonatomic, copy) dispatch_block_t CopyBlock;

@end
