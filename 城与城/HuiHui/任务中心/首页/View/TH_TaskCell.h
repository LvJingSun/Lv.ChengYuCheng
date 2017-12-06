//
//  TH_TaskCell.h
//  HuiHui
//
//  Created by mac on 2017/4/27.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TH_TaskCellFrameModel;

@protocol TaskCellDelegate <NSObject>

- (void)addBtnClick:(UIButton *)sender;

@end

@interface TH_TaskCell : UITableViewCell

+ (instancetype)TH_TaskCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) TH_TaskCellFrameModel *frameModel;

@property (nonatomic, weak) id<TaskCellDelegate> delegate;

@end
