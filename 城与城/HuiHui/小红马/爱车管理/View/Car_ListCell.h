//
//  Car_ListCell.h
//  HuiHui
//
//  Created by mac on 2017/6/8.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  Car_ListFrame;

@interface Car_ListCell : UITableViewCell

+ (instancetype)Car_ListCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) Car_ListFrame *frameModel;

@property (nonatomic, copy) dispatch_block_t DefaultBlock;

@end
