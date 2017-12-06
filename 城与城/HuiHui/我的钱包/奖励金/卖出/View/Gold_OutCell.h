//
//  Gold_OutCell.h
//  HuiHui
//
//  Created by mac on 2017/9/19.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Gold_OutFrame;

@protocol GetOutFieldDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface Gold_OutCell : UITableViewCell

+ (instancetype)Gold_OutCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Gold_OutFrame *frameModel;

@property (nonatomic, strong) id<GetOutFieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@property (nonatomic, copy) dispatch_block_t lookBlock;

@property (nonatomic, weak) UILabel *moneyLab;

@end
