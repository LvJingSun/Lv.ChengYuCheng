//
//  InsuranceNoDataCell.h
//  HuiHui
//
//  Created by mac on 2017/6/9.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsuranceNoDataCell : UITableViewCell

+ (instancetype)InsuranceNoDataCellWithTableview:(UITableView *)tableview;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, copy) dispatch_block_t PhoneClickBlock;

@property (nonatomic, copy) dispatch_block_t ApplyClickBlock;

@end
