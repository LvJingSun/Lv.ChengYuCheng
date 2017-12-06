//
//  ZZ_FunctionCell.h
//  HuiHui
//
//  Created by mac on 2017/6/30.
//  Copyright © 2017年 MaxLinksTec. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZZ_FunctionFrame;

@interface ZZ_FunctionCell : UITableViewCell

+ (instancetype)ZZ_FunctionCellWithTableview:(UITableView *)tableview;

@property (nonatomic, strong) ZZ_FunctionFrame *frameModel;

@end
