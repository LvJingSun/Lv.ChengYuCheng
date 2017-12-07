//
//  HL_NoticeCell.h
//  HuiHui
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HL_NoticeFrame;

@interface HL_NoticeCell : UITableViewCell

+ (instancetype)HL_NoticeCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) HL_NoticeFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t notice1Block;

@property (nonatomic, copy) dispatch_block_t notice2Block;

@end
