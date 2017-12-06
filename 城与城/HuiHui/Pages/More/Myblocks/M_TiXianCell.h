//
//  M_TiXianCell.h
//  HuiHui
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class M_TiXianFrame;

@protocol CountFieldDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface M_TiXianCell : UITableViewCell

+ (instancetype)M_TiXianCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) M_TiXianFrame *frameModel;

@property (nonatomic, weak) UILabel *needLab;

@property (nonatomic, strong) id<CountFieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
