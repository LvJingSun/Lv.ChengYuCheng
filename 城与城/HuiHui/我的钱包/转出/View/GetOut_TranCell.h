//
//  GetOut_TranCell.h
//  HuiHui
//
//  Created by mac on 2017/9/12.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GetOut_TranFrame;

@protocol GetOutFieldDelegate <NSObject>

- (void)CountFieldChange:(UITextField *)field;

@end

@interface GetOut_TranCell : UITableViewCell

+ (instancetype)GetOut_TranCellWithTableview:(UITableView *)tableview;

@property (nonatomic, weak) UIButton *sureBtn;

@property (nonatomic, strong) GetOut_TranFrame *frameModel;

@property (nonatomic, strong) id<GetOutFieldDelegate> delegate;

@property (nonatomic, copy) dispatch_block_t sureBlock;

@end
