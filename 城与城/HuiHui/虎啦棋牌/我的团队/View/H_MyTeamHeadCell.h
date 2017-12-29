//
//  H_MyTeamHeadCell.h
//  HuiHui
//
//  Created by mac on 2017/11/7.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class H_MyTeamHeadFrame;

@interface H_MyTeamHeadCell : UITableViewCell

+ (instancetype)H_MyTeamHeadCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) H_MyTeamHeadFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t oneBlock;

@property (nonatomic, copy) dispatch_block_t twoBlock;

@property (nonatomic, copy) dispatch_block_t threeBlock;

@property (nonatomic, copy) dispatch_block_t fourBlock;

@end
